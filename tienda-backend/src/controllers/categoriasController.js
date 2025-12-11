const { v4: uuidv4 } = require('uuid');
const { categorias } = require('../services/db');

exports.listar = (req, res) => {
  res.json(categorias);
};

exports.obtener = (req, res) => {
  const { id } = req.params;
  const cat = categorias.find((c) => c.id === id);
  if (!cat) return res.status(404).json({ error: 'Categoría no encontrada' });
  res.json(cat);
};

exports.crear = (req, res) => {
  const { nombre, descripcion } = req.body;
  if (!nombre) return res.status(400).json({ error: 'El campo nombre es requerido' });
  const nueva = { id: uuidv4(), nombre, descripcion: descripcion || '' };
  categorias.push(nueva);
  res.status(201).json(nueva);
};

exports.actualizar = (req, res) => {
  const { id } = req.params;
  const { nombre, descripcion } = req.body;
  const idx = categorias.findIndex((c) => c.id === id);
  if (idx === -1) return res.status(404).json({ error: 'Categoría no encontrada' });
  categorias[idx] = { ...categorias[idx], nombre: nombre ?? categorias[idx].nombre, descripcion: descripcion ?? categorias[idx].descripcion };
  res.json(categorias[idx]);
};

exports.eliminar = (req, res) => {
  const { id } = req.params;
  const idx = categorias.findIndex((c) => c.id === id);
  if (idx === -1) return res.status(404).json({ error: 'Categoría no encontrada' });
  const removed = categorias.splice(idx, 1)[0];
  res.json(removed);
};
