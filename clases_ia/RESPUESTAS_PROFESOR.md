# RESPUESTAS Y RÚBRICA - Clase 01

**⚠️ CONFIDENCIAL - SOLO PROFESOR**

---

## Pregunta 1: Conceptos Fundamentales (20 puntos)

**Pregunta**: Explica en 3-4 líneas por qué usamos herramientas de IA generativa en un curso de finanzas cuantitativas. ¿Cuáles son los tres problemas principales que resuelven?

**Respuesta esperada**:
- Reducen tiempo de escritura de código boilerplate
- Aceleran exploración de datos (prueba múltiples enfoques rápidamente)
- Facilitan documentación y comunicación de análisis
- (Bonus: Mejoran debugging interactivo)

**Rúbrica**:
- **20 pts**: Menciona 3 problemas claros y específicos
- **15 pts**: Menciona 2-3 problemas pero falta claridad
- **10 pts**: Menciona 1-2 problemas vagos
- **0 pts**: No responde o respuesta incorrecta

---

## Pregunta 2: Herramientas y Configuración (20 puntos)

**Pregunta**: Describe los pasos principales para instalar y configurar Claude Code en Windows PowerShell. ¿Qué es lo más importante después de instalar Node.js?

**Respuesta esperada**:
1. Instalar Node.js (v18+)
2. Crear cuenta en console.anthropic.com
3. Generar API key
4. Configurar variable de entorno: `$env:ANTHROPIC_API_KEY="sk-ant-..."`
5. Verificar con `npx @anthropic-ai/claude-code --version`

**Lo más importante**: Configurar la API key (sin ella no funciona)

**Rúbrica**:
- **20 pts**: Pasos correctos en orden + identifica API key como crítica
- **15 pts**: 4 de 5 pasos correctos
- **10 pts**: 3 de 5 pasos correctos
- **5 pts**: 2 de 5 pasos correctos
- **0 pts**: Menos de 2 pasos o incorrectos

---

## Pregunta 3: Prompting Efectivo (20 puntos)

**Pregunta**: Reescribe este prompt MALO para que sea EFECTIVO según las 5 reglas de prompting:

```
Genera código R para analizar datos financieros
```

**Respuesta esperada** (ejemplo):
```
Usa tidyverse para analizar un CSV de retornos diarios de acciones.
El script debe:
- Cargar el archivo 'precios.csv' (columnas: fecha, ticker, precio)
- Calcular retornos diarios usando (precio_hoy - precio_ayer) / precio_ayer
- Generar gráfico de serie de tiempo con ggplot2
- Calcular y imprimir: media, desviación estándar, ratio de Sharpe (asumir Rf=0)
```

**Rúbrica**:
- **20 pts**: Específico + reproducible + menciona librerías + incluye formato entrada/salida
- **15 pts**: Específico + reproducible + menciona librerías (falta detalles)
- **10 pts**: Más específico que el original pero falta reproducibilidad
- **5 pts**: Mejorado pero aún vago
- **0 pts**: Sin mejora o no intenta

**Nota**: Aceptar variaciones siempre que demuestre aplicación de las 5 reglas (contexto, reproducibilidad, librerías, explicación, iteración)

---

## Pregunta 4: Flujo de Trabajo Práctico (20 puntos)

**Pregunta**: Describe paso a paso cómo usarías Claude Code para:
1. Crear un script que simule 252 retornos diarios
2. Ejecutarlo en Positron
3. Manejar un error que aparezca

**Respuesta esperada**:
1. Abre Claude Code en terminal
2. Pega prompt para simulación
3. Claude genera código → copias al archivo `simular.R`
4. Ctrl+Enter en Positron para ejecutar
5. Si hay error: copia el error y pégalo en Claude Code
6. Claude explica el problema y propone solución
7. Editas el código y vuelves a ejecutar

**Rúbrica**:
- **20 pts**: 7 pasos claros y correctos
- **15 pts**: 5-6 pasos correctos
- **10 pts**: 3-4 pasos correctos
- **5 pts**: 1-2 pasos
- **0 pts**: No responde o incorrectos

**Criterios de evaluación**:
- Debe incluir: generar → copiar → ejecutar → error → consultar → corregir
- Aceptar variaciones en el orden/formato siempre que el flujo sea correcto

---

## Pregunta 5: Análisis Crítico (20 puntos)

**Pregunta**: ¿Cuáles son las 3 limitaciones principales de usar IA generativa en análisis financiero? ¿Cómo se mitigan?

**Respuesta esperada**:
1. **No es 100% preciso**: Mitiga revisando código antes de usarlo en datos reales
2. **Requiere conexión a internet**: Mitiga teniendo alternativas offline (código manual)
3. **Requiere comprensión del usuario**: Mitiga NO delegando pensamiento financiero a la IA
4. (Bonus): Riesgo de alucinaciones → Validar resultados con métodos alternativos

**Rúbrica**:
- **20 pts**: 3 limitaciones claras + 3 mitigaciones prácticas
- **15 pts**: 3 limitaciones + 2 mitigaciones
- **10 pts**: 2 limitaciones + 2 mitigaciones
- **5 pts**: 1-2 limitaciones + 1 mitigación vaga
- **0 pts**: No responde o respuesta superficial

**Nota**: Esta es la pregunta más importante - evalúa pensamiento crítico. Aceptar respuestas creativas siempre que demuestren comprensión.

---

## Escala de Calificaciones

| Puntaje | Calificación |
|---------|-------------|
| 90-100  | A (Excelente) |
| 80-89   | B (Bueno) |
| 70-79   | C (Satisfactorio) |
| 60-69   | D (Mínimo) |
| <60     | F (Insuficiente) |

---

## Notas Generales de Evaluación

### Instrucciones
- Tiempo recomendado: 30-45 minutos
- Los estudiantes pueden usar el notebook como referencia
- Aceptar respuestas en español

### Criterios Generales
- **Claridad**: La respuesta debe ser comprensible
- **Exactitud**: Debe demostrar comprensión correcta del concepto
- **Completitud**: Debe abordar todos los puntos de la pregunta
- **Variación**: Aceptar respuestas diferentes siempre que sean correctas

### Flexibilidad
- Preguntas 1-2: Respuestas más estructuradas (menos variación)
- Pregunta 3: Muchas variaciones válidas (cualquier mejora es aceptable)
- Pregunta 4: Orden flexible, solo importa el flujo correcto
- Pregunta 5: Muy flexible (múltiples respuestas válidas posibles)

### Problemas Comunes
- Si el estudiante confunde Positron con RStudio: aceptar si explica correctamente
- Si usa `vibe` o `mistral-code` en lugar de Claude Code: válido (alternativa correcta)
- Si el prompt de la Pregunta 3 es diferente pero más específico/reproducible: válido

---

**Documento guardado**: 2026-08-30
**Confidencialidad**: Solo profesor - No distribuir a estudiantes
**Distribución**: Mantener localmente, no subir a la web
