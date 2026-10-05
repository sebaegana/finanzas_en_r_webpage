# Guía de Deploy a Netlify — Actividad 02 Reporte Interactivo

## Opción 1: Deploy con netlify-cli (Recomendado)

### Paso 1: Instalar netlify-cli

```bash
npm install -g netlify-cli
```

### Paso 2: Autenticarse

```bash
netlify login
```

Se abrirá el navegador para que inicies sesión con tu cuenta Netlify. Aprueba el acceso.

### Paso 3: Deploy (Staging/Preview)

```bash
cd netlify_actividad02
quarto render --to html  # Asegúrate de que _site/ está actualizado
netlify deploy --dir=_site
```

Netlify te pedirá que confirmes la carpeta de publicación (`_site`) y creará un **URL de draft** (ej: `https://xyz123--portafolios-fen.netlify.app`).

**Verifica que todo funciona**:
- Abre la URL en tu navegador
- Interactúa con los gráficos (hover en plotly)
- Prueba los sliders de la calculadora OJS
- Revisa la consola del navegador (F12) para errores

### Paso 4: Deploy a Producción (--prod)

Una vez verificado:

```bash
netlify deploy --dir=_site --prod
```

Esto publica en la **URL definitiva** (ej: `https://portafolios-fen.netlify.app`).

---

## Opción 2: Deploy Manual (Drag and Drop)

1. Ve a [app.netlify.com/drop](https://app.netlify.com/drop)
2. Inicia sesión con tu cuenta Netlify (o crea una)
3. Arrastra la carpeta `_site/` a la zona de drop
4. Netlify subirá y publicará automáticamente
5. Obtendrás una URL pública (ej: `https://random-name-12345.netlify.app`)

**Ventaja**: No necesitas instalar nada (solo navegador).  
**Desventaja**: Cada upload es un sitio nuevo (sin actualización automática).

---

## Configuración del Dominio Personalizado

Si tienes un dominio personalizado (ej: `portafolios.fen.uchile.cl`):

1. En [app.netlify.com](https://app.netlify.com), abre tu sitio
2. **Site settings** → **Domain management**
3. Agrega tu dominio personalizado
4. Sigue las instrucciones de DNS (apunta tu dominio a Netlify)

---

## Actualización Futura

Si realizas cambios al reporte:

```bash
# 1. Edita index.qmd o R/portafolio.R
# 2. Renderiza localmente
quarto render --to html

# 3. Deploy a producción (--prod para actualizar el sitio existente)
netlify deploy --dir=_site --prod
```

---

## Troubleshooting

### "netlify deploy falla: permiso denegado"
- Asegúrate de haber hecho `netlify login` exitosamente
- Inicia sesión nuevamente: `netlify logout && netlify login`

### "Los sliders no funcionan o faltan datos"
- Abre la consola (F12) y busca errores de JavaScript
- Verifica que `data/portafolio_retornos.csv` existe en `_site/`
- Verifica que `data/resultados.json` existe en `_site/`

### "El HTML es muy grande (>12 MB)"
- Es normal con `embed-resources: true` (todos los recursos incrustados)
- Netlify permite archivos hasta 50 MB sin problema

### "Los gráficos plotly no se cargan"
- Verifica que `embed-resources: true` está en `_quarto.yml`
- Recarga la página (Ctrl+Shift+R para borrar caché)

---

## URLs Importantes

- **Quarto Docs**: https://quarto.org/docs/websites/
- **Netlify Docs**: https://docs.netlify.com/
- **netlify-cli**: https://cli.netlify.com/
- **Observable JS en Quarto**: https://quarto.org/docs/interactive/ojs/

---

*Última actualización: 2026-10-04*
