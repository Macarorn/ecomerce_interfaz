import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final double? size;
  final int? colorIndex;
  final Map<String, String>? options;
  final double? selectedPrice;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.size,
    this.colorIndex,
    this.options,
    this.selectedPrice,
  });

  bool sameVariant(CartItem other) {
    if (product.id != other.product.id) return false;
    if (size != other.size) return false;
    if (colorIndex != other.colorIndex) return false;
    if ((options == null) != (other.options == null)) return false;
    if (options != null && other.options != null) {
      if (options!.length != other.options!.length) return false;
      for (final k in options!.keys) {
        if (!other.options!.containsKey(k) || other.options![k] != options![k]) {
          return false;
        }
      }
    }
    return true;
  }
}

class Cart {
  Cart._private();
  static final Cart instance = Cart._private();

  final ValueNotifier<List<CartItem>> items = ValueNotifier<List<CartItem>>([]);

  void add(
    Product p, {
    int quantity = 1,
    double? size,
    int? colorIndex,
    Map<String, String>? options,
    double? selectedPrice,
  }) {
    final list = List<CartItem>.from(items.value);
    final newItem = CartItem(
      product: p,
      quantity: quantity,
      size: size,
      colorIndex: colorIndex,
      options: options,
      selectedPrice: selectedPrice,
    );
    for (final it in list) {
      if (it.sameVariant(newItem)) {
        it.quantity += quantity;
        items.value = List<CartItem>.from(list);
        return;
      }
    }
    list.add(newItem);
    items.value = list;
  }

  void remove(CartItem item) {
    final list = List<CartItem>.from(items.value)
      ..removeWhere((it) => it.sameVariant(item));
    items.value = list;
  }

  void updateQuantity(CartItem item, int quantity) {
    final list = List<CartItem>.from(items.value);
    for (final it in list) {
      if (it.sameVariant(item)) {
        if (quantity <= 0) {
          list.remove(it);
        } else {
          it.quantity = quantity;
        }
        break;
      }
    }
    items.value = list;
  }

  double get subtotal => items.value.fold(0.0, (s, it) {
    final price = it.selectedPrice ?? it.product.price;
    return s + price * it.quantity;
  });
}
