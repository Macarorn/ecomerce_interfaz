import 'package:flutter/material.dart';

import 'screens/genero.dart';
import 'screens/orden_compra.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMenuItem(
              context,
              'Inicio',
              Icons.home,
              Colors.blue,
              () => _showPendingScreen(context, 'Inicio'),
            ),
            _buildMenuItem(
              context,
              'Perfil de usuario',
              Icons.person,
              Colors.green,
              () => _showPendingScreen(context, 'Perfil de usuario'),
            ),
            _buildMenuItem(
              context,
              'Productos',
              Icons.shopping_bag,
              Colors.orange,
              () => _showPendingScreen(context, 'Productos'),
            ),
            _buildMenuItem(
              context,
              'Categorias',
              Icons.category,
              Colors.red,
              () => _showPendingScreen(context, 'Categorias'),
            ),
            _buildMenuItem(
              context,
              'Carrito de compra',
              Icons.shopping_cart,
              Colors.teal,
              () => _showPendingScreen(context, 'Carrito de compra'),
            ),
            _buildMenuItem(
              context,
              'Orden de compra',
              Icons.receipt_long,
              Colors.indigo,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdenCompraScreen(),
                ),
              ),
            ),
            _buildMenuItem(
              context,
              'Genero',
              Icons.wc,
              Colors.purple,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GeneroScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _showPendingScreen(BuildContext context, String screenName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(screenName), backgroundColor: Colors.blue),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.construction, size: 80, color: Colors.grey),
                const SizedBox(height: 20),
                Text(
                  screenName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Pantalla pendiente de implementación',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
