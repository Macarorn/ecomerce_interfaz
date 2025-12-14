import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedSizeIndex = 0;
  int selectedColorIndex = 0;
  final Map<String, int> selectedOptionIndex = {};
  final List<double> sizes = [6, 6.5, 7, 7.5, 8, 8.5];
  final List<Color> colors = [
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de producto'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white,
                    child: Icon(
                      _iconForTitle(product.title),
                      size: 120,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _buildStars(4.5),
                  const SizedBox(width: 8),
                  const Text('(120)', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '\$${_currentPrice(product).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (product.specs != null && product.specs!.isNotEmpty) ...[
                const Text(
                  'Especificaciones',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: product.specs!.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              e.key,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              e.value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],

              if (product.options != null && product.options!.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Opciones',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: product.options!.entries.map((entry) {
                    final key = entry.key;
                    final values = entry.value; // List<Map<String,dynamic>>
                    selectedOptionIndex.putIfAbsent(key, () => 0);
                    final selected = selectedOptionIndex[key]!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(key, style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            children: List.generate(values.length, (i) {
                              final isSel = i == selected;
                              final label =
                                  values[i]['label']?.toString() ??
                                  values[i].toString();
                              return ChoiceChip(
                                label: Text(label),
                                selected: isSel,
                                onSelected: (_) => setState(
                                  () => selectedOptionIndex[key] = i,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ] else ...[
                const Text(
                  'Seleccionar talla',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(sizes.length, (i) {
                    final selected = i == selectedSizeIndex;
                    return GestureDetector(
                      onTap: () => setState(() => selectedSizeIndex = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: selected ? 14 : 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.blueAccent
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected
                                ? Colors.blueAccent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          '${sizes[i]}',
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(sizes.length, (i) {
                    final selected = i == selectedSizeIndex;
                    return GestureDetector(
                      onTap: () => setState(() => selectedSizeIndex = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: selected ? 14 : 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.blueAccent
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected
                                ? Colors.blueAccent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          '${sizes[i]}',
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Seleccionar color',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(colors.length, (i) {
                    final selected = i == selectedColorIndex;
                    return GestureDetector(
                      onTap: () => setState(() => selectedColorIndex = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: EdgeInsets.all(selected ? 3 : 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: selected
                              ? Border.all(color: Colors.blueAccent, width: 2)
                              : null,
                        ),
                        child: CircleAvatar(
                          backgroundColor: colors[i],
                          radius: 14,
                        ),
                      ),
                    );
                  }),
                ),
              ],

              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // add to shared cart with selected options when present
                        if (product.options != null &&
                            product.options!.isNotEmpty) {
                          final Map<String, String> chosen = {};
                          product.options!.forEach((k, v) {
                            final idx = selectedOptionIndex[k] ?? 0;
                            final label =
                                v[idx]['label']?.toString() ??
                                v[idx].toString();
                            chosen[k] = label;
                          });
                          final price = _currentPrice(product);
                          Cart.instance.add(
                            product,
                            quantity: 1,
                            options: chosen,
                            selectedPrice: price,
                          );
                        } else if (product.specs != null &&
                            product.specs!.isNotEmpty) {
                          Cart.instance.add(product, quantity: 1);
                        } else {
                          Cart.instance.add(
                            product,
                            quantity: 1,
                            size: sizes[selectedSizeIndex],
                            colorIndex: selectedColorIndex,
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Añadido al carrito')),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Añadir al carrito'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  double _currentPrice(Product product) {
    double p = product.price;
    if (product.options != null) {
      product.options!.forEach((k, v) {
        final idx = selectedOptionIndex[k] ?? 0;
        if (v.isNotEmpty) {
          final item = v[idx];
          final dyn = item['price'];
          if (dyn is num) p += dyn.toDouble();
        }
      });
    }
    return p;
  }

  Widget _buildStars(double rating) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < full) {
          return const Icon(Icons.star, size: 16, color: Colors.amber);
        }
        if (i == full && half) {
          return const Icon(Icons.star_half, size: 16, color: Colors.amber);
        }
        return const Icon(Icons.star_border, size: 16, color: Colors.amber);
      }),
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
