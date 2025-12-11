const { v4: uuidv4 } = require('uuid');
const { productos, categorias } = require('../services/db');

exports.listar = (req, res) => {
  res.json(productos);
};

exports.obtener = (req, res) => {
  const { id } = req.params;
  const p = productos.find((p) => p.id === id);
  if (!p) return res.status(404).json({ error: 'Producto no encontrado' });
  res.json(p);
};

exports.crear = (req, res) => {
  const { nombre, descripcion, precio, categoriaId } = req.body;
  if (!nombre || precio == null) return res.status(400).json({ error: 'Campos requeridos: nombre, precio' });
  if (categoriaId && !categorias.find((c) => c.id === categoriaId)) return res.status(400).json({ error: 'categoriaId inválido' });
  const nuevo = { id: uuidv4(), nombre, descripcion: descripcion || '', precio: Number(precio), categoriaId: categoriaId || null };
  productos.push(nuevo);
  res.status(201).json(nuevo);
};

exports.actualizar = (req, res) => {
  const { id } = req.params;
  const { nombre, descripcion, precio, categoriaId } = req.body;
  const idx = productos.findIndex((p) => p.id === id);
  if (idx === -1) return res.status(404).json({ error: 'Producto no encontrado' });
  if (categoriaId && !categorias.find((c) => c.id === categoriaId)) return res.status(400).json({ error: 'categoriaId inválido' });
  productos[idx] = {
    ...productos[idx],
    nombre: nombre ?? productos[idx].nombre,
    descripcion: descripcion ?? productos[idx].descripcion,
    precio: precio == null ? productos[idx].precio : Number(precio),
    categoriaId: categoriaId ?? productos[idx].categoriaId,
  };
  res.json(productos[idx]);
};

exports.eliminar = (req, res) => {
  const { id } = req.params;
  const idx = productos.findIndex((p) => p.id === id);
  if (idx === -1) return res.status(404).json({ error: 'Producto no encontrado' });
  const removed = productos.splice(idx, 1)[0];
  res.json(removed);
};
