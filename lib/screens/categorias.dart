import 'package:flutter/material.dart';
import 'pago.dart';

class categorias extends StatefulWidget {
  const categorias({super.key});

  @override
  State<categorias> createState() => _categoriasState();
}

class _categoriasState extends State<categorias> {
  final Color primaryColor = const Color(0xFF40BFFF);
  final Color textColor = const Color(0xFF223263);
  final Color greyColor = const Color(0xFF9098B1);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color bgColor = const Color(0xFFFAFAFA);

  int _selectedIndex = 1; // Explore seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar producto',
                    hintStyle: TextStyle(color: greyColor, fontSize: 12),
                    prefixIcon: Icon(Icons.search, color: greyColor, size: 20),

                    // 👇 Íconos eliminados
                    suffixIcon: null,

                    filled: true,
                    fillColor: bgColor,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Moda Hombre',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.85,
                children: [
                  _buildCategoryItem('Camisas', Icons.checkroom),
                  _buildCategoryItem('Pantalonetas', Icons.checkroom),
                  _buildCategoryItem('Zapatos', Icons.shopping_bag),
                  _buildCategoryItem('Chaquetas', Icons.checkroom),
                  _buildCategoryItem('Ropa interior', Icons.checkroom),
                  _buildCategoryItem('Accesorios', Icons.shopping_bag),
                ],
              ),

              const SizedBox(height: 28),

              Text(
                'Moda Mujer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.85,
                children: [
                  _buildCategoryItem('Camisas', Icons.checkroom),
                  _buildCategoryItem('Blusas', Icons.checkroom),
                  _buildCategoryItem('Faldas', Icons.checkroom),
                  _buildCategoryItem('Chaquetas', Icons.checkroom),
                  _buildCategoryItem('Zapatos', Icons.shopping_bag),
                  _buildCategoryItem('Vestidos', Icons.checkroom),
                  _buildCategoryItem('Ropa interior', Icons.checkroom),
                  _buildCategoryItem('Bolsos', Icons.shopping_bag),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PagoPage()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        elevation: 8,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: ''),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: greyColor.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Icon(icon, size: 36, color: primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
