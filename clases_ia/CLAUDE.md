# Instrucciones para Claude Code - Clases con IA

## Convención de Numeración de Materiales

Los materiales en `clases_ia/` se organizan secuencialmente usando la propiedad `listing_title` en el frontmatter YAML.

### Orden Actual (2026-09-10)

```
01 - Intro y Herramientas (herramientas.qmd)
02 - Intro a IA en Finanzas (intro.qmd)
03 - Clase 01 - Desarrollo Asistido por IA (notebook_01.qmd)
04 - [DISPONIBLE para próximo material]
05 - Actividad 01 - Limpieza de Datos (actividad_01_con_ia.qmd)
```

### Estructura de Numeración

- **01-04**: Contenido teórico y de clase (notebooks, lecciones)
- **05+**: Actividades prácticas para estudiantes

### Patrón a Seguir

Cada nuevo material sigue este patrón en `listing_title`:

```yaml
---
listing_title: "NN - [TIPO] NN - [Nombre Descriptivo]"
```

Donde:
- `NN` = número secuencial (01, 02, 03, ...)
- `[TIPO]` = Clase / Actividad / Taller / Guía
- El siguiente número es el de la unidad temática
- `[Nombre Descriptivo]` = título corto del contenido

### Ejemplos

✅ Correcto:
```yaml
listing_title: "06 - Actividad 02 - Agregaciones y Joins con IA"
listing_title: "04 - Taller - Debugging de Código R"
listing_title: "07 - Guía - Buenas Prácticas de Prompting"
```

❌ Incorrecto:
```yaml
listing_title: "Actividad 02"  # Sin numeración
listing_title: "4 - Actividad" # Número mal formateado
```

## Creación de Nuevos Materiales

### Checklist para Claude

Cuando crees un nuevo material:

1. ✅ **Identifica el siguiente número**: Revisa `clases_ia/*.qmd` y `grep listing_title` para ver cuál es el siguiente disponible
2. ✅ **Sigue la estructura de numeración**: usa `NN - [TIPO] MM - [Nombre]`
3. ✅ **Usa el template YAML estándar**: (ver sección Template abajo)
4. ✅ **Agrega download buttons**: (PDF y Fuente .qmd)
5. ✅ **Renderiza**: `quarto render clases_ia/nuevo_material.qmd --to html`
6. ✅ **Commit**: incluye el archivo `.qmd` y el `.html` generado
7. ✅ **Actualiza esta lista**: si es necesario, actualiza el "Orden Actual" arriba

### Template YAML Estándar

```yaml
---
listing_title: "NN - [TIPO] MM - [Nombre Descriptivo]"
title: |
  [Título Formal]
subtitle: "[Subtítulo Descriptivo]"
author:
  - Sebastián Egaña Santibáñez (segana@fen.uchile.cl)
  - Nicolás Leiva Díaz (nleivad@fen.uchile.cl)
date: last-modified
lang: es
format:
  html:
    toc: true
    toc-depth: 2
    theme: cosmo
    number-sections: false
    code-block-bg: true
    code-block-border-left: "#FF0000"
  pdf:
    documentclass: report
    fontsize: 11pt
    geometry: margin=1in
---

## 📥 Descargas

\`\`\`{=html}
<div style="margin-bottom: 20px; display: flex; gap: 10px;">
  <a href="nombre_archivo.pdf" class="btn btn-primary" role="button" style="padding: 8px 16px; border-radius: 4px; background-color: #0d6efd; color: white; text-decoration: none;">📄 Descargar PDF</a>
  <a href="nombre_archivo.qmd" class="btn btn-secondary" role="button" style="padding: 8px 16px; border-radius: 4px; background-color: #6c757d; color: white; text-decoration: none;">💾 Descargar Fuente</a>
</div>
\`\`\`

---

# Contenido aquí...
```

## Notas Importantes

- El `index.qmd` en `clases_ia/` **lista automáticamente** todos los `.qmd` excepto el índice mismo
- El sorting es **alfabético por `listing_title`**, así que la numeración controla el orden visual
- Mantén esta lista actualizada cuando agregues nuevos materiales
- Ante dudas sobre el siguiente número, usa: `ls -la clases_ia/*.qmd | grep listing_title`
