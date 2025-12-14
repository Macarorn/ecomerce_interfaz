import 'package:ecomerce_interfaz/screens/change_password.dart';
import 'package:flutter/material.dart';

import 'change_email.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Colors.blue.shade700;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        foregroundColor: Colors.white,
        backgroundColor: primary,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.blue.shade50,
                        child: const Icon(
                          Icons.person,
                          size: 36,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Maximus Gold',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28),
                  _ProfileOption(
                    title: 'Correo electrónico',
                    value: 'Derlaxy@yahoo.com',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangeEmailScreen(),
                      ),
                    ),
                  ),
                  _ProfileOption(title: 'Teléfono', value: '(307) 555-0133'),
                  _ProfileOption(
                    title: 'Cambiar contraseña',
                    value: '********',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChangePassword()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ProfileOption({required this.title, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
        const Divider(height: 1, indent: 16),
      ],
    );
  }
}
