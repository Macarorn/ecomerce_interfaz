import 'package:ecomerce_interfaz/screens/pago.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String coupon = '';

  double get subtotal => Cart.instance.subtotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de compra'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<CartItem>>(
                valueListenable: Cart.instance.items,
                builder: (context, list, _) {
                  if (list.isEmpty) {
                    return const Center(child: Text('Tu carrito está vacío'));
                  }
                  return ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, _) => const Divider(height: 20),
                    itemBuilder: (context, i) {
                      final it = list[i];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  _iconForTitle(it.product.title),
                                  size: 28,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  it.product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (it.options != null &&
                                    it.options!.isNotEmpty)
                                  Text(
                                    it.options!.entries
                                        .map((e) => '${e.key}: ${e.value}')
                                        .join(' • '),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 6),
                                Text(
                                  '\$${(it.selectedPrice ?? it.product.price).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      onPressed: () =>
                                          Cart.instance.updateQuantity(
                                            it,
                                            it.quantity > 1
                                                ? it.quantity - 1
                                                : 0,
                                          ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Text('${it.quantity}'),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                      onPressed: () => Cart.instance
                                          .updateQuantity(it, it.quantity + 1),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => Cart.instance.remove(it),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Introduce código de cupón',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => coupon = v,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _applyCoupon,
                  child: const Text('Aplicar'),
                ),
              ],
            ),

            const SizedBox(height: 12),
            ValueListenableBuilder<List<CartItem>>(
              valueListenable: Cart.instance.items,
              builder: (context, list, _) {
                final currentSubtotal = Cart.instance.subtotal;
                final totalPrice = currentSubtotal + 40 + 120;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _row(
                            'Artículos (${list.length})',
                            '\$${currentSubtotal.toStringAsFixed(2)}',
                          ),
                          _row('Envío', '\$40.00'),
                          _row('Cargos de importación', '\$120.00'),
                          const Divider(),
                          _row(
                            'Precio total',
                            '\$${totalPrice.toStringAsFixed(2)}',
                            bold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: list.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PagoPage(),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: Text(
                        list.isEmpty ? 'Carrito vacío' : 'Finalizar compra',
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _applyCoupon() {
    final snack = coupon == 'X10' ? 'Cupón aplicado' : 'El cupón no es válido';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snack)));
    setState(() {
      if (coupon == 'X10') {
        /*no-op for demo*/
      }
    });
  }

  Widget _row(String a, String b, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Text(
          a,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          b,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
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
