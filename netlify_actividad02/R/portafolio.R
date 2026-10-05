# Funciones para análisis de portafolios óptimos (Markowitz + Simulación)

library(readr)
library(dplyr)
library(tibble)
library(quadprog)
library(jsonlite)

# ==============================================================================
# 1. Cargar datos
# ==============================================================================
cargar_datos <- function(ruta_csv) {
  portafolio_retornos <- read_csv(ruta_csv, show_col_types = FALSE)

  retornos_matrix <- portafolio_retornos |>
    select(-fecha) |>
    as.matrix()

  list(
    datos = portafolio_retornos,
    matrix = retornos_matrix,
    activos = colnames(retornos_matrix)
  )
}

# ==============================================================================
# 2. Calcular estadísticas descriptivas
# ==============================================================================
estadisticas_descriptivas <- function(retornos_matrix) {
  stats <- colMeans(retornos_matrix) * 12  # Anualizados
  volatilidades <- apply(retornos_matrix, 2, sd) * sqrt(12)

  tibble(
    activo = colnames(retornos_matrix),
    retorno_anual_pct = stats * 100,
    volatilidad_anual_pct = volatilidades * 100
  )
}

# ==============================================================================
# 3. Matriz de correlación
# ==============================================================================
matriz_correlacion <- function(retornos_matrix) {
  cor(retornos_matrix)
}

# ==============================================================================
# 4. Frontera eficiente de Markowitz con quadprog
# ==============================================================================
calcular_frontera_markowitz <- function(retornos_matrix, n_puntos = 50) {
  retornos_esperados <- colMeans(retornos_matrix)
  cov_matrix <- cov(retornos_matrix)
  n_activos <- ncol(retornos_matrix)
  tasa_libre_riesgo <- 0.02 / 12

  # Rango de retornos objetivo
  ret_min <- min(retornos_esperados) * 12
  ret_max <- max(retornos_esperados) * 12
  ret_objetivo_min <- ret_min * 0.9
  ret_objetivo_max <- ret_max * 0.95

  retornos_objetivo <- seq(ret_objetivo_min, ret_objetivo_max, length.out = n_puntos) / 12

  # Contenedores para resultados
  frontera <- list(
    retorno = numeric(n_puntos),
    volatilidad = numeric(n_puntos),
    sharpe = numeric(n_puntos),
    pesos = matrix(NA, nrow = n_puntos, ncol = n_activos)
  )

  # Loop sobre puntos de retorno objetivo
  for (i in seq_along(retornos_objetivo)) {
    r_obj <- retornos_objetivo[i]

    # Formulación para solve.QP:
    # minimiza: 0.5 * x' H x + f' x
    # sujeto a: A' x >= b0 (meq primeras restricciones son igualdad)

    H <- 2 * cov_matrix
    f <- rep(0, n_activos)

    # Restricciones: sum(w)=1, w'*r=r_obj, w>=0
    A <- cbind(
      rep(1, n_activos),        # suma = 1
      retornos_esperados,        # retorno objetivo
      diag(n_activos)            # w >= 0
    )

    b0 <- c(1, r_obj, rep(0, n_activos))

    tryCatch({
      resultado <- solve.QP(H, f, A, b0, meq = 2)
      w_opt <- resultado$solution
      vol_opt <- sqrt(t(w_opt) %*% cov_matrix %*% w_opt) * sqrt(12)

      frontera$retorno[i] <- r_obj * 12
      frontera$volatilidad[i] <- vol_opt
      frontera$pesos[i, ] <- w_opt
    }, error = function(e) {
      warning(paste("solve.QP falló en iteración", i))
    })
  }

  # Calcular Sharpe ratio
  frontera$sharpe <- ifelse(
    frontera$volatilidad > 1e-10,
    (frontera$retorno - 0.02) / frontera$volatilidad,
    NA
  )

  # Portafolio tangente
  idx_tangente <- which.max(frontera$sharpe)

  frontera$portafolio_tangente <- list(
    idx = idx_tangente,
    retorno = frontera$retorno[idx_tangente],
    volatilidad = frontera$volatilidad[idx_tangente],
    sharpe = frontera$sharpe[idx_tangente],
    pesos = frontera$pesos[idx_tangente, ]
  )

  frontera
}

# ==============================================================================
# 5. Simulación de portafolios aleatorios (Monte Carlo)
# ==============================================================================
simular_portafolios <- function(retornos_matrix, n_sims = 10000, seed = 42) {
  set.seed(seed)

  retornos_esperados <- colMeans(retornos_matrix)
  cov_matrix <- cov(retornos_matrix)
  n_activos <- ncol(retornos_matrix)

  # Generar pesos aleatorios long-only
  pesos_matrix <- matrix(NA, nrow = n_sims, ncol = n_activos)

  for (i in 1:n_sims) {
    w <- runif(n_activos)
    w <- w / sum(w)
    pesos_matrix[i, ] <- w
  }

  # Calcular métricas
  retornos_port <- pesos_matrix %*% retornos_esperados * 12
  volatilidades_port <- sqrt(diag(pesos_matrix %*% cov_matrix %*% t(pesos_matrix))) * sqrt(12)
  sharpe_ratios <- (retornos_port - 0.02) / volatilidades_port

  # Mejor portafolio simulado
  idx_mejor <- which.max(sharpe_ratios)

  list(
    resultados = tibble(
      retorno_anual = as.numeric(retornos_port),
      volatilidad_anual = as.numeric(volatilidades_port),
      sharpe_ratio = as.numeric(sharpe_ratios)
    ),
    pesos = pesos_matrix,
    mejor_idx = idx_mejor,
    mejor_portafolio = list(
      retorno = retornos_port[idx_mejor],
      volatilidad = volatilidades_port[idx_mejor],
      sharpe = sharpe_ratios[idx_mejor],
      pesos = pesos_matrix[idx_mejor, ]
    )
  )
}

# ==============================================================================
# 6. Calcular brecha de optimización (Simulación vs Markowitz)
# ==============================================================================
calcular_brecha <- function(frontera_markowitz, simulacion, activos) {
  porta_tang <- frontera_markowitz$portafolio_tangente
  porta_sim <- simulacion$mejor_portafolio

  # Tabla de brecha
  brecha_retorno <- abs(porta_sim$retorno - porta_tang$retorno)
  brecha_vol <- abs(porta_sim$volatilidad - porta_tang$volatilidad)
  brecha_sharpe <- abs(porta_sim$sharpe - porta_tang$sharpe)

  comparacion <- tibble(
    metrica = c("Retorno Anual", "Volatilidad Anual", "Sharpe Ratio"),
    simulado = c(
      round(porta_sim$retorno * 100, 3),
      round(porta_sim$volatilidad * 100, 3),
      round(porta_sim$sharpe, 4)
    ),
    markowitz = c(
      round(porta_tang$retorno * 100, 3),
      round(porta_tang$volatilidad * 100, 3),
      round(porta_tang$sharpe, 4)
    ),
    brecha = c(
      round(brecha_retorno * 100, 3),
      round(brecha_vol * 100, 3),
      round(brecha_sharpe, 4)
    ),
    error_pct = c(
      round(brecha_retorno / abs(porta_tang$retorno) * 100, 2),
      round(brecha_vol / porta_tang$volatilidad * 100, 2),
      round(brecha_sharpe / porta_tang$sharpe * 100, 2)
    )
  )

  # Tabla de composición de pesos
  pesos_tabla <- tibble(
    activo = activos,
    markowitz_pct = round(porta_tang$pesos * 100, 2),
    simulado_pct = round(porta_sim$pesos * 100, 2),
    diferencia_pct = round(abs(porta_tang$pesos - porta_sim$pesos) * 100, 2)
  )

  list(
    comparacion = comparacion,
    pesos = pesos_tabla,
    brecha_sharpe_pct = round(brecha_sharpe / porta_tang$sharpe * 100, 2)
  )
}

# ==============================================================================
# 7. Exportar pesos a JSON para Observable JS
# ==============================================================================
exportar_pesos_json <- function(frontera_markowitz, simulacion, activos, ruta_salida) {
  porta_tang <- frontera_markowitz$portafolio_tangente
  porta_sim <- simulacion$mejor_portafolio

  pesos_json <- list(
    tangente = list(
      retorno = round(porta_tang$retorno, 4),
      volatilidad = round(porta_tang$volatilidad, 4),
      sharpe = round(porta_tang$sharpe, 4),
      pesos = setNames(as.list(round(porta_tang$pesos, 4)), activos)
    ),
    simulado = list(
      retorno = round(porta_sim$retorno, 4),
      volatilidad = round(porta_sim$volatilidad, 4),
      sharpe = round(porta_sim$sharpe, 4),
      pesos = setNames(as.list(round(porta_sim$pesos, 4)), activos)
    )
  )

  write_json(pesos_json, ruta_salida, pretty = TRUE)
}
