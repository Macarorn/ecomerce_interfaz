Archivos generados por el asistente para copiar al backend real.

Ruta de generación: `tienda-backend/generated/`

Pasos para integrar:
1. Copiar los archivos de `generated/controllers/*.js` a `src/controllers/`.
2. Copiar los archivos de `generated/routes/*.js` a `src/routes/`.
3. Registrar rutas en `src/index.js` o `src/app.js`:

```js
import categoriasRoutes from './routes/categorias.js';
import productosRoutes from './routes/productos.js';

app.use('/rest/v1/categorias', categoriasRoutes);
app.use('/rest/v1/productos', productosRoutes);
```

Notas:
- Los ficheros usan sintaxis ES Modules (`import`/`export`). Si tu proyecto usa CommonJS (require/module.exports), puedes:
  - Cambiar `package.json` con `"type": "module"` para habilitar ES modules, o
  - Convertir los `import`/`export` a `require`/`module.exports` antes de pegar.

- Actualmente estos controladores usan almacenamiento en memoria; para persistencia debes integrarlos con Supabase o la base de datos del equipo.
