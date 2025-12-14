import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, dynamic>> _categories = [
    {'label': 'Teléfonos', 'icon': Icons.phone_iphone, 'color': Colors.indigo},
    {
      'label': 'Portátiles',
      'icon': Icons.laptop_mac,
      'color': Colors.deepPurple,
    },
    {'label': 'Auriculares', 'icon': Icons.headset, 'color': Colors.teal},
    {'label': 'Monitores', 'icon': Icons.monitor, 'color': Colors.blue},
    {'label': 'Accesorios', 'icon': Icons.watch, 'color': Colors.orange},
    {
      'label': 'Smartwatches',
      'icon': Icons.watch_outlined,
      'color': Colors.green,
    },
    {'label': 'Tablets', 'icon': Icons.tablet_mac, 'color': Colors.purple},
    {'label': 'Cameras', 'icon': Icons.camera_alt, 'color': Colors.redAccent},
    {'label': 'Drones', 'icon': Icons.flight, 'color': Colors.cyan},
    {
      'label': 'Gaming',
      'icon': Icons.sports_esports,
      'color': Colors.deepOrange,
    },
    {'label': 'Printers', 'icon': Icons.print, 'color': Colors.brown},
    {'label': 'Networking', 'icon': Icons.router, 'color': Colors.blueGrey},
    {'label': 'Smart Home', 'icon': Icons.home, 'color': Colors.lightBlue},
    {'label': 'Wearables', 'icon': Icons.fitness_center, 'color': Colors.pink},
    {'label': 'Components', 'icon': Icons.memory, 'color': Colors.amber},
  ];

  int _selectedIndex = -1;
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
    final borderBlue = Colors.blue.shade200;
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
              border: Border.all(color: borderBlue, width: 2.2),
            ),
            child: ListView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Categorías',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.black54),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Body
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
                            color: Colors.blue.shade100,
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
                      const SizedBox(height: 14),
                      // Card with grid
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1.6,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue.shade300,
                                          Colors.blue.shade500,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.grid_view,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Tecnología',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${_filtered.length} elementos',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(height: 1),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
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
                                      duration: const Duration(
                                        milliseconds: 220,
                                      ),
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
                                          setState(() {
                                            _selectedIndex = selected
                                                ? -1
                                                : idx;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 44,
                                                height: 44,
                                                decoration: BoxDecoration(
                                                  color:
                                                      (item['color'] as Color)
                                                          .withOpacity(0.12),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    item['icon'] as IconData,
                                                    color:
                                                        item['color'] as Color,
                                                    size: 22,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
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
                                              const SizedBox(height: 4),
                                              Text(
                                                'Ver productos',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w600,
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
                          ],
                        ),
                      ),
                    ],
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
