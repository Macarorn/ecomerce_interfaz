import { v4 as uuid } from "uuid";

let productos = [];

export const getProductos = (req, res) => {
  res.json(productos);
};

export const getProductoById = (req, res) => {
  const producto = productos.find(p => p.id === req.params.id);

  if (!producto) {
    return res.status(404).json({ error: "Producto no encontrado" });
  }

  res.json(producto);
};

export const createProducto = (req, res) => {
  const { nombre, precio, categoriaId } = req.body;

  const nuevo = {
    id: uuid(),
    nombre,
    precio,
    categoriaId
  };

  productos.push(nuevo);
  res.status(201).json(nuevo);
};

export const updateProducto = (req, res) => {
  const producto = productos.find(p => p.id === req.params.id);

  if (!producto) {
    return res.status(404).json({ error: "Producto no encontrado" });
  }

  producto.nombre = req.body.nombre ?? producto.nombre;
  producto.precio = req.body.precio ?? producto.precio;
  producto.categoriaId = req.body.categoriaId ?? producto.categoriaId;

  res.json(producto);
};

export const deleteProducto = (req, res) => {
  productos = productos.filter(p => p.id !== req.params.id);
  res.json({ message: "Producto eliminado" });
};
