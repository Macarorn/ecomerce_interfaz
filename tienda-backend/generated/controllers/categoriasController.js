import { v4 as uuid } from "uuid";

let categorias = [];

export const getCategorias = (req, res) => {
  res.json(categorias);
};

export const getCategoriaById = (req, res) => {
  const categoria = categorias.find(c => c.id === req.params.id);
  if (!categoria) {
    return res.status(404).json({ error: "Categoría no encontrada" });
  }
  res.json(categoria);
};

export const createCategoria = (req, res) => {
  const { nombre, descripcion } = req.body;

  const nueva = {
    id: uuid(),
    nombre,
    descripcion
  };

  categorias.push(nueva);
  res.status(201).json(nueva);
};

export const updateCategoria = (req, res) => {
  const categoria = categorias.find(c => c.id === req.params.id);
  if (!categoria) {
    return res.status(404).json({ error: "Categoría no encontrada" });
  }

  categoria.nombre = req.body.nombre ?? categoria.nombre;
  categoria.descripcion = req.body.descripcion ?? categoria.descripcion;

  res.json(categoria);
};

export const deleteCategoria = (req, res) => {
  categorias = categorias.filter(c => c.id !== req.params.id);
  res.json({ message: "Categoría eliminada" });
};
