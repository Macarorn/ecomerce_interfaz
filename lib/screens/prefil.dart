import 'package:flutter/material.dart';
import 'change_email.dart';
import 'category_s.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Colors.blue.shade700;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
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
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '@derlaxy',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.category_outlined),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CategoryScreen(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 28),
                      _ProfileOption(
                        icon: Icons.email_outlined,
                        title: 'Correo electrónico',
                        value: 'Derlaxy@yahoo.com',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChangeEmailScreen(),
                          ),
                        ),
                      ),
                      _ProfileOption(
                        icon: Icons.wc_outlined,
                        title: 'Género',
                        value: 'Masculino',
                      ),
                      _ProfileOption(
                        icon: Icons.cake_outlined,
                        title: 'Cumpleaños',
                        value: '12-12-2000',
                      ),
                      _ProfileOption(
                        icon: Icons.phone_outlined,
                        title: 'Teléfono',
                        value: '(307) 555-0133',
                      ),
                      _ProfileOption(
                        icon: Icons.lock_outline,
                        title: 'Cambiar contraseña',
                        value: '********',
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          // ejemplo: cerrar sesión
                          Navigator.maybePop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text('Volver'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
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
        const Divider(height: 1, indent: 72),
      ],
    );
  }
}
