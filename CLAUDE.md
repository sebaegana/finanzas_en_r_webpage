# Convenciones de Proyecto - Claude Code

Instrucciones y convenciones para trabajar con Claude Code en este proyecto.

---

## 📋 Convenciones Generales del Proyecto

### Estructura del Repositorio

```
webpage/
├── clases/                # Material heredado (2024-2025) en PDF
│   ├── actividad_01.qmd
│   ├── notebook_01.qmd
│   └── ...
├── clases_ia/             # Nueva línea: Clases con IA (HTML interactivo)
│   ├── index.qmd          # Listing automático
│   ├── intro.qmd
│   ├── notebook_01.qmd
│   ├── actividad_01_con_ia.qmd
│   └── ...
├── recursos/              # Links, referencias externas
├── docs/                  # Output build (no editar manualmente)
├── _quarto.yml            # Config global de Quarto
└── CLAUDE.md              # Este archivo
```

### Flujo de Trabajo Estándar

1. **Crear/editar archivos `.qmd`** en sus carpetas correspondientes
2. **Renderizar localmente**: `quarto render [archivo.qmd]`
3. **Revisar HTML generado** en `docs/`
4. **Commit**: incluir `.qmd` fuente + `.html` generado
5. **Mensaje de commit**: descriptivo con tipo (feat/fix/docs)

### Opciones YAML Estándar

Todos los materiales educativos usan este template:

```yaml
---
title: "Título Principal"
subtitle: "Subtítulo"
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
```

**Nota**: Algunos materiales (especialmente en `clases_ia/`) incluyen `listing_title` para control de orden en index.

---

## 🎓 Convenciones para `clases_ia/` (Clases con IA)

Esta es la **nueva línea de materiales** que integra Claude Code y Positron como herramientas pedagógicas.

### Numeración Secuencial

Los materiales se ordenan usando `listing_title` (auto-listado por Quarto en `index.qmd`):

```yaml
---
listing_title: "NN - [TIPO] MM - [Nombre Descriptivo]"
```

Donde:
- `NN` = número secuencial (01, 02, 03, ...)
- `[TIPO]` = Clase / Actividad / Taller / Guía
- `MM` = número de unidad temática (01, 02, 03, ...)
- `[Nombre Descriptivo]` = título corto

### Orden Actual (2026-09-10)

| Num | Tipo | Archivo | Descripción |
|-----|------|---------|-------------|
| 01 | Intro | `herramientas.qmd` | Herramientas y setup |
| 02 | Intro | `intro.qmd` | IA en finanzas cuantitativas |
| 03 | Clase | `notebook_01.qmd` | Clase 01 - Desarrollo asistido |
| 04 | — | — | [DISPONIBLE] |
| 05 | Actividad | `actividad_01_con_ia.qmd` | Actividad 01 - Limpieza de datos |

### Estructura de Contenido para Clases_IA

Cada material en `clases_ia/` debe incluir:

1. **Frontmatter completo**: título, autores, `listing_title`, formato HTML+PDF
2. **Sección de descargas**: botones PDF y fuente `.qmd`
3. **Contenido pedagógico**: 
   - Contexto/motivación
   - Comparación manual vs asistido (cuando aplique)
   - Ejemplos de código/prompts
   - Actividad/ejercicio para estudiantes
4. **Reflexión final**: cómo usar IA correctamente, limitaciones

### Template Completo para `clases_ia/`

```yaml
---
listing_title: "NN - [TIPO] MM - [Nombre Descriptivo]"
title: |
  [Título Formal]
subtitle: "[Subtítulo]"
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
  <a href="archivo.pdf" class="btn btn-primary" role="button" 
     style="padding: 8px 16px; border-radius: 4px; background-color: #0d6efd; 
            color: white; text-decoration: none;">📄 Descargar PDF</a>
  <a href="archivo.qmd" class="btn btn-secondary" role="button" 
     style="padding: 8px 16px; border-radius: 4px; background-color: #6c757d; 
            color: white; text-decoration: none;">💾 Descargar Fuente</a>
</div>
\`\`\`

---

# Contenido
```

### Ejemplos de Numeración Válida

✅ **Correcto**:
```yaml
listing_title: "06 - Actividad 02 - Agregaciones y Joins con IA"
listing_title: "04 - Taller 01 - Debugging de Código R"
listing_title: "07 - Guía 01 - Buenas Prácticas de Prompting"
```

❌ **Incorrecto**:
```yaml
listing_title: "Actividad 02"          # Sin numeración
listing_title: "4 - Actividad"         # Número sin ceros
listing_title: "06-Actividad-02"       # Formato inconsistente
```

### Checklist para Crear Nuevo Material en `clases_ia/`

- [ ] Identifica el siguiente número disponible (revisa `clases_ia/*.qmd`)
- [ ] Copia el template YAML arriba
- [ ] Usa `listing_title: "NN - [TIPO] MM - [Nombre]"`
- [ ] Incluye sección de descargas (PDF + fuente)
- [ ] Estructura el contenido: contexto → comparación → ejemplos → actividad → reflexión
- [ ] Renderiza localmente: `quarto render clases_ia/archivo.qmd --to html`
- [ ] Revisa HTML en `docs/clases_ia/archivo.html`
- [ ] Commit: incluir `.qmd` + `.html` + actualizar este CLAUDE.md (tabla de orden)
- [ ] Mensaje de commit: `feat: Add NN - [TIPO] MM - [Descripción breve]`

---

## 💾 Commits y Versionado

### Formato de Mensaje de Commit

```
<tipo>: <descripción breve>

[cuerpo opcional con detalles]

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
Claude-Session: [URL de sesión]
```

**Tipos válidos**:
- `feat`: Nuevo material, actividad, clase
- `fix`: Corrección de errores, typos, links rotos
- `docs`: Cambios en documentación (este CLAUDE.md, README, etc.)
- `refactor`: Reorganización de estructura sin cambio de contenido

### Ejemplos

```
feat: Add Actividad 01 - Limpieza de Datos (Manual vs IA)

Create interactive lesson comparing traditional (50-60 min) vs
AI-assisted (10-15 min) approach for Activity 01 (chess dataset).

Includes: code comparisons, real prompts, 3 student approaches, rubric.

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01Xn33EoyAgw3Eq2wJPP94zT
```

---

## 🔍 Búsqueda Rápida

Para verificar el siguiente número disponible en `clases_ia/`:

```bash
# Windows PowerShell
Get-ChildItem clases_ia/*.qmd | Select-String "listing_title" | Sort-Object

# Bash
grep -h "listing_title" clases_ia/*.qmd | sort
```

---

## 📝 Notas Importantes

- El `index.qmd` en `clases_ia/` lista **automáticamente** todos los `.qmd` excepto el index mismo
- El sorting es **alfabético por `listing_title`**, así que la numeración controla el orden visual
- **No edites** `docs/` manualmente; se regenera con cada `quarto render`
- Mantén este CLAUDE.md actualizado cuando agregues nuevos materiales
- La rama principal para desarrollo es `develop`, cambios se integran a `main` mediante PR

---

## 🚀 Próximos Materiales Planeados

```
06 - Actividad 02 - Agregaciones y Joins con IA
07 - Clase 02 - Regresión y Modelado Financiero
08 - Actividad 03 - Simulación Monte Carlo
09 - Guía 01 - Buenas Prácticas de Prompting
10 - Taller 01 - Debugging Interactivo en Positron
```

*(Esta lista es aproximada y puede cambiar según necesidades pedagógicas)*
