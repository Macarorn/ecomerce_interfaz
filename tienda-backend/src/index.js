const express = require('express');
const cors = require('cors');
const categoriasRoutes = require('./routes/categorias');
const productosRoutes = require('./routes/productos');

const app = express();
app.use(cors());
app.use(express.json());

app.use('/rest/v1/categorias', categoriasRoutes);
app.use('/rest/v1/productos', productosRoutes);

app.get('/', (req, res) => res.json({ ok: true, version: '1.0.0' }));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`API running on http://localhost:${port}`));
