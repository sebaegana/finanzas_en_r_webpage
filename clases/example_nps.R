library(tidyverse)

my_data_01 <- tibble(
  fechas = c("2023-Q1", "2023-Q2", "2023-Q3", "2023-Q4"),
  NPS_servicios = c(60, 65, 62, 70)
)

# Create a data frame with two columns
my_data_02 <- tibble(
  Categoria_NPS = c("Promotores", "Neutros", "Detractores"),
  Promerio_años = c(4, 5, 3),
  Conteo = c(10000, 1500, 1500)
)

# Create a data frame with two columns
my_data_03 <- tibble(
  Categoria_NPS = c("Promotores", "Neutros", "Detractores"),
  Porcentaje_egresos = c(0.05, 0.04, 0.03)
)

# Create a data frame with two columns
my_data_04 <- tibble(
  Categoria_NPS = c("Promotores", "Neutros", "Detractores"),
  Probabilidad_egreso = c(0.2, 0.1, 0.05)
)


# Create a line graph using ggplot
p <- ggplot(my_data_01, aes(x = fechas, y = NPS_servicios)) +
  geom_line(group=1, color="blue") + # Add line
  geom_point(color="red") + # Add points
  theme_minimal() + # Use a minimal theme
  labs(title = "Net Promoter Score (NPS) Across Quarters",
       x = "Quarter",
       y = "NPS Score")

p
