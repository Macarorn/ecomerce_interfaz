import 'package:flutter/material.dart';

import 'product_grid.dart';
import 'products_by_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'label': 'Teléfonos',
      'icon': Icons.phone_iphone,
      'color': Colors.indigo,
      'id': 1,
    },
    {
      'label': 'Portátiles',
      'icon': Icons.laptop_mac,
      'color': Colors.deepPurple,
      'id': 2,
    },
    {
      'label': 'Auriculares',
      'icon': Icons.headset,
      'color': Colors.teal,
      'id': 3,
    },
    {
      'label': 'Smartwatches',
      'icon': Icons.watch_outlined,
      'color': Colors.green,
      'id': 4,
    },
    {
      'label': 'Accesorios',
      'icon': Icons.watch,
      'color': Colors.orange,
      'id': 5,
    },
    {
      'label': 'Tablets',
      'icon': Icons.tablet_mac,
      'color': Colors.purple,
      'id': 6,
    },
    {
      'label': 'Cameras',
      'icon': Icons.camera_alt,
      'color': Colors.redAccent,
      'id': 7,
    },
    {'label': 'Drones', 'icon': Icons.flight, 'color': Colors.cyan, 'id': 8},
    {
      'label': 'Gaming',
      'icon': Icons.sports_esports,
      'color': Colors.deepOrange,
      'id': 9,
    },
    {
      'label': 'Monitores',
      'icon': Icons.monitor,
      'color': Colors.blue,
      'id': 10,
    },
    {'label': 'Printers', 'icon': Icons.print, 'color': Colors.brown, 'id': 11},
    {
      'label': 'Networking',
      'icon': Icons.router,
      'color': Colors.blueGrey,
      'id': 12,
    },
    {
      'label': 'Smart Home',
      'icon': Icons.home,
      'color': Colors.lightBlue,
      'id': 13,
    },
    {
      'label': 'Wearables',
      'icon': Icons.fitness_center,
      'color': Colors.pink,
      'id': 14,
    },
    {
      'label': 'Components',
      'icon': Icons.memory,
      'color': Colors.amber,
      'id': 15,
    },
  ];

  final int _selectedIndex = -1;
  String _search = '';

  List<Map<String, dynamic>> get _filtered => _categories
      .where(
        (c) => (c['label'] as String).toLowerCase().contains(
          _search.toLowerCase(),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 6),
                      const Text(
                        'Categorías',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      // Search bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Buscar categorías tecnológicas',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onChanged: (v) => setState(() => _search = v),
                              ),
                            ),
                            if (_search.isNotEmpty)
                              GestureDetector(
                                onTap: () => setState(() => _search = ''),
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Grid de categorías scrolleable
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: GridView.builder(
                      itemCount: _filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 3 / 2,
                          ),
                      itemBuilder: (context, i) {
                        final item = _filtered[i];
                        final idx = _categories.indexOf(item);
                        final selected = idx == _selectedIndex;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.blue.shade50
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: selected
                                  ? Colors.blue.shade300
                                  : Colors.grey.shade100,
                              width: selected ? 1.6 : 1,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              final label = item['label'] as String;
                              final Map<String, List<String>> categoryKeywords =
                                  {
                                    'Teléfonos': ['teléfono', 'phone'],
                                    'Portátiles': [
                                      'portátil',
                                      'laptop',
                                      'notebook',
                                    ],
                                    'Auriculares': [
                                      'auricular',
                                      'auriculares',
                                      'headphone',
                                      'headset',
                                    ],
                                    'Smartwatches': ['reloj', 'smartwatch'],
                                    'Accesorios': [
                                      'accesorio',
                                      'carga',
                                      'base',
                                      'charger',
                                    ],
                                    'Tablets': ['tablet'],
                                    'Cameras': ['cámara', 'camera'],
                                    'Drones': ['drone'],
                                    'Gaming': ['gaming'],
                                    'Monitores': ['monitor'],
                                    'Printers': ['printer'],
                                    'Networking': ['router', 'network'],
                                    'Smart Home': ['home'],
                                    'Wearables': ['wearable'],
                                    'Components': ['component'],
                                  };
                              final keywords =
                                  categoryKeywords[label] ??
                                  [label.toLowerCase()];
                              final filteredProducts = ProductGridScreen
                                  .products
                                  .where((p) {
                                    final title = p.title.toLowerCase();
                                    return keywords.any(
                                      (k) => title.contains(k),
                                    );
                                  })
                                  .toList();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductsByCategoryScreen(
                                    category: label,
                                    products: filteredProducts,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: (item['color'] as Color)
                                          // ignore: deprecated_member_use
                                          .withOpacity(0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        item['icon'] as IconData,
                                        color: item['color'] as Color,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    item['label'] as String,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: selected
                                          ? Colors.blue.shade900
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
