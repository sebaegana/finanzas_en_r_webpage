# Aplicación Shiny: Laboratorio de Portafolios

Esta carpeta contiene la aplicación ejecutable de la clase
`clase_shiny_portafolios.qmd`.

## Ejecutar

Desde RStudio o Positron:

1. Abre `app.R`.
2. Verifica que el directorio de trabajo sea esta carpeta.
3. Instala los paquetes indicados en la clase.
4. Presiona **Run App**.

También puedes ejecutar:

```r
shiny::runApp("clases_ia/shiny_portafolio")
```

La aplicación busca automáticamente los datos en las rutas habituales, por lo
que funciona tanto si se ejecuta desde esta carpeta como desde la raíz del
repositorio. El archivo utilizado es:

```text
clases_ia/data/portafolio_retornos.csv
```
