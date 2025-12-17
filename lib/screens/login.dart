import 'package:ecomerce_interfaz/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import 'forgot_password.dart';
import 'register.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final Color primaryColor = const Color(0xFF40BFFF);
  final Color textColor = const Color(0xFF223263);
  final Color greyColor = const Color(0xFF9098B1);
  final Color whiteColor = const Color(0xFFFFFFFF);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();

  // Función para login usando el backend
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final result = await AuthService.loginUser(
          nombre: _emailController.text.trim(),
          password: _contraseniaController.text,
        );
        // Guardar datos del usuario autenticado
        final prefs = await SharedPreferences.getInstance();
        final user = result['user'] ?? {};
        await prefs.setString('userId', user['id']?.toString() ?? '');
        await prefs.setString('userNombre', user['nombre'] ?? '');
        await prefs.setString('userCorreo', user['correo'] ?? '');
        await prefs.setString('userApellido', user['apellido'] ?? '');
        await prefs.setString('userTelefono', user['telefono'] ?? '');

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('¡Bienvenido!')));
        // Navegar al HomeScreen después de login exitoso
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainApp()),
          (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 40),

                // Logo/Bienvenida
                Column(
                  children: [
                    Text(
                      "Bienvenido a TiendaTech",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Inicia sesión para continuar",
                      style: TextStyle(fontSize: 14, color: greyColor),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Campo Nombre
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Ingresa tu nombre de usuario',
                    labelStyle: TextStyle(color: greyColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Ingresa tu nombre" : null,
                ),

                const SizedBox(height: 16),

                // Campo Contraseña
                TextFormField(
                  controller: _contraseniaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: greyColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: greyColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Ingresa tu contraseña" : null,
                ),

                const SizedBox(height: 16),

                // Botón Iniciar Sesión
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                    minimumSize: const Size(double.infinity, 57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),

                const SizedBox(height: 24),

                // Separador "O"
                Row(
                  children: [
                    Expanded(child: Divider(color: greyColor.withOpacity(0.5))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "O",
                        style: TextStyle(color: greyColor, fontSize: 14),
                      ),
                    ),
                    Expanded(child: Divider(color: greyColor.withOpacity(0.5))),
                  ],
                ),

                const SizedBox(height: 24),

                // Botón Google
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Iniciar sesión con Google no está habilitado aún',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 57),
                    side: BorderSide(color: greyColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.g_mobiledata, size: 24, color: Colors.red),
                      const SizedBox(width: 12),
                      Text(
                        'Iniciar con Google',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Botón Facebook,
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Iniciar sesión con Facebook no está habilitado aún',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 57),
                    side: BorderSide(color: greyColor.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, size: 24, color: Colors.blue),
                      const SizedBox(width: 12),
                      Text(
                        'Iniciar con Facebook',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Olvidé contraseña
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 32),

                // Registrarse
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿No tienes una cuenta? ",
                      style: TextStyle(color: greyColor, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => register()),
                        );
                      },
                      child: Text(
                        "Regístrate",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
