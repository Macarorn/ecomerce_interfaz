# Endpoints — Categorías y Productos

## Categorías

### GET /rest/v1/categorias
Listar todas las categorías.

Response 200:
```json
[]
```

---

### GET /rest/v1/categorias/:id
Obtener categoría por id.

Response 200:
```json
{ "id": "uuid", "nombre": "Calzado", "descripcion": "Zapatos" }
```
Response 404:
```json
{ "error": "Categoría no encontrada" }
```

---

### POST /rest/v1/categorias
Crear categoría.

Request body:
```json
{ "nombre": "Ropa", "descripcion": "Vestimenta" }
```
Response 201:
```json
{ "id": "uuid", "nombre": "Ropa", "descripcion": "Vestimenta" }
```

---

### PUT /rest/v1/categorias/:id
Actualizar categoría.

Request body (parcial):
```json
{ "nombre": "Ropa Moderna" }
```
Response 200: objeto actualizado.

---

### DELETE /rest/v1/categorias/:id
Eliminar categoría.

Response 200: objeto eliminado.


## Productos

### GET /rest/v1/productos
Listar productos.

Response 200:
```json
[]
```

---

### GET /rest/v1/productos/:id
Obtener producto por id.

Response 404:
```json
{ "error": "Producto no encontrado" }
```

---

### POST /rest/v1/productos
Crear producto.

Request body:
```json
{ "nombre": "Zapato A", "precio": 29.9, "categoriaId": "uuid-category" }
```
Response 201: objeto creado.

---

### PUT /rest/v1/productos/:id
Actualizar producto.

---

### DELETE /rest/v1/productos/:id
Eliminar producto.


## Notas
- Actualmente el backend usa almacenamiento en memoria (arrays). Si reinicias el servidor, los datos se pierden.
- Para integración con Supabase, se implementará el uso de `@supabase/supabase-js` y consultas SQL/CRUD.
