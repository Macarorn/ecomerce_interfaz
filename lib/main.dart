import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login.dart';
import 'screens/genero.dart';
import 'screens/orden_compra.dart';
import 'screens/categorias.dart';
import 'screens/prefil.dart';
import 'screens/product_grid.dart';
import 'screens/cart_screen.dart';

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
      home: const AuthWrapper(), // Cambiado de HomeScreen a AuthWrapper
    );
  }
}

// Widget que verifica el estado de autenticación
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Función para verificar si el usuario ya inició sesión
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail');
    final savedPassword = prefs.getString('userPassword');

    // Verifica si hay credenciales guardadas
    final isLoggedIn =
        savedEmail != null &&
        savedEmail.isNotEmpty &&
        savedPassword != null &&
        savedPassword.isNotEmpty;

    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Muestra un loading mientras verifica
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Verificando sesión...'),
            ],
          ),
        ),
      );
    }

    // Decide qué pantalla mostrar
    return _isLoggedIn ? HomeScreen() : login();
  }
}

// El resto del código de HomeScreen permanece igual
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Cerrar sesión
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('userEmail');
              await prefs.remove('userPassword');

              // Regresar al login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => login()),
                (route) => false,
              );
            },
          ),
        ],
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
              () {
                // Debug: confirmar que el tap se recibe
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Abriendo Perfil de usuario...'),
                  ),
                );
                print('DEBUG: Perfil de usuario tapped');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              'Productos',
              Icons.shopping_bag,
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductGridScreen(),
                ),
              ),
            ),
            _buildMenuItem(
              context,
              'Categorias',
              Icons.category,
              Colors.red,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const categorias()),
              ),
            ),
            _buildMenuItem(
              context,
              'Carrito de compra',
              Icons.shopping_cart,
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              ),
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
