class Product {
  final String id;
  final String title;
  final double price;
  final double oldPrice;
  final String imageUrl;
  final Map<String, String>? specs;
  // options: map from option name to a list of choices, each choice is a map
  // with keys 'label' (String) and 'price' (double) representing price delta
  final Map<String, List<Map<String, dynamic>>>? options;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
    this.specs,
    this.options,
  });
}
