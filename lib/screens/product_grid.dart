import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail.dart';

class ProductGridScreen extends StatelessWidget {
  const ProductGridScreen({super.key});

  static const List<Product> products = <Product>[
    Product(
      id: 'p1',
      title: 'Teléfono X Pro',
      price: 999.00,
      oldPrice: 1099.00,
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800&q=80',
      specs: {
        'Pantalla': '6.5" OLED',
        'RAM': '8 GB',
        'Almacenamiento': '128 GB',
        'Batería': '4500 mAh',
        'Cámara': '108 MP',
      },
      options: {
        'RAM': [
          {'label': '4 GB', 'price': -100.0},
          {'label': '8 GB', 'price': 0.0},
          {'label': '12 GB', 'price': 100.0},
        ],
        'Almacenamiento': [
          {'label': '64 GB', 'price': -100.0},
          {'label': '128 GB', 'price': 0.0},
          {'label': '256 GB', 'price': 150.0},
        ],
        'Color': [
          {'label': 'Negro', 'price': 0.0},
          {'label': 'Blanco', 'price': 0.0},
          {'label': 'Azul', 'price': 0.0},
        ],
      },
    ),
    Product(
      id: 'p2',
      title: 'Portátil Ultra 14"',
      price: 1299.00,
      oldPrice: 1499.00,
      imageUrl:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800&q=80',
      specs: {
        'Procesador': 'Intel i7',
        'RAM': '16 GB',
        'Almacenamiento': '512 GB SSD',
        'Pantalla': '14" Retina',
        'Batería': '10 h',
      },
      options: {
        'Procesador': [
          {'label': 'Intel i5', 'price': -200.0},
          {'label': 'Intel i7', 'price': 0.0},
          {'label': 'Intel i9', 'price': 300.0},
        ],
        'RAM': [
          {'label': '8 GB', 'price': -200.0},
          {'label': '16 GB', 'price': 0.0},
          {'label': '32 GB', 'price': 300.0},
        ],
        'Almacenamiento': [
          {'label': '256 GB', 'price': -100.0},
          {'label': '512 GB', 'price': 0.0},
          {'label': '1 TB', 'price': 200.0},
        ],
      },
    ),
    Product(
      id: 'p3',
      title: 'Auriculares con cancelación de ruido',
      price: 199.99,
      oldPrice: 249.99,
      imageUrl:
          'https://images.unsplash.com/photo-1518444023750-ef4b7d9d5b2b?w=800&q=80',
      specs: {
        'Tipo': 'Circumaural',
        'Duración batería': '30 h',
        'Conectividad': 'Bluetooth 5.2',
        'Cancelación de ruido': 'Activa',
      },
      options: {
        'Color': [
          {'label': 'Negro', 'price': 0.0},
          {'label': 'Blanco', 'price': 0.0},
        ],
      },
    ),
    Product(
      id: 'p4',
      title: 'Reloj inteligente Series 7',
      price: 349.00,
      oldPrice: 399.00,
      imageUrl:
          'https://images.unsplash.com/photo-1516574187841-cb9cc2ca948b?w=800&q=80',
      specs: {
        'Pantalla': '1.78" AMOLED',
        'Batería': '18 h',
        'Resistencia al agua': '5 ATM',
        'Sensores': 'Frecuencia cardiaca, SpO2, GPS',
      },
      options: {
        'Correa': [
          {'label': 'Caucho', 'price': 0.0},
          {'label': 'Metal', 'price': 10.0},
        ],
        'Color': [
          {'label': 'Negro', 'price': 0.0},
          {'label': 'Plateado', 'price': 0.0},
        ],
      },
    ),
    Product(
      id: 'p5',
      title: 'Base de carga inalámbrica',
      price: 39.99,
      oldPrice: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1555617117-08fda34b35a8?w=800&q=80',
      specs: {
        'Salida': '15 W (Qi)',
        'Tipo': 'Base inalámbrica',
        'Compatibilidad': 'Dispositivos Qi compatibles',
      },
      options: {
        'Color': [
          {'label': 'Negro', 'price': 0.0},
          {'label': 'Blanco', 'price': 0.0},
        ],
      },
    ),
    Product(
      id: 'p6',
      title: 'Altavoz Bluetooth',
      price: 79.99,
      oldPrice: 99.99,
      imageUrl:
          'https://images.unsplash.com/photo-1570813090110-cb5a5d4b0f6d?w=800&q=80',
      specs: {
        'Potencia': '20 W',
        'Duración batería': '12 h',
        'Bluetooth': '5.1',
      },
      options: {
        'Color': [
          {'label': 'Negro', 'price': 0.0},
          {'label': 'Gris', 'price': 0.0},
        ],
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.66,
          children: products.map((p) => _ProductCard(product: p)).toList(),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Icon(
                      _iconForTitle(product.title),
                      size: 54,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${product.oldPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForTitle(String title) {
    final t = title.toLowerCase();
    if (t.contains('smartphone') ||
        t.contains('phone') ||
        t.contains('teléfono') ||
        t.contains('telefono') ||
        t.contains('móvil')) {
      return Icons.smartphone;
    }
    if (t.contains('laptop') ||
        t.contains('notebook') ||
        t.contains('portátil') ||
        t.contains('portatil')) {
      return Icons.laptop_mac;
    }
    if (t.contains('headphone') ||
        t.contains('headset') ||
        t.contains('auricular') ||
        t.contains('auriculares')) {
      return Icons.headphones;
    }
    if (t.contains('smartwatch') ||
        t.contains('watch') ||
        t.contains('reloj') ||
        t.contains('reloj inteligente')) {
      return Icons.watch;
    }
    if (t.contains('charger') ||
        t.contains('wireless charger') ||
        t.contains('carga') ||
        t.contains('cargador')) {
      return Icons.power;
    }
    if (t.contains('speaker') || t.contains('altavoz')) return Icons.speaker;
    return Icons.devices;
  }
}
