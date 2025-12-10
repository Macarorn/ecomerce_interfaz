import 'package:flutter/material.dart';
import 'delete_confirmation_screen.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController _controller = TextEditingController(
    text: 'Derlaxy@yahoo.com',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeEmail() {
    final newEmail = _controller.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Se ha enviado verificación a $newEmail')),
    );
    Navigator.maybePop(context);
  }

  Future<void> _confirmDelete() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const DeleteConfirmationScreen()),
    );
    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Correo eliminado')));
      Navigator.maybePop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderBlue = Colors.blue.shade200;
    return Scaffold(
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
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Correo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Body
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Cambiar correo',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enviaremos una verificación a tu nuevo correo',
                        style: TextStyle(color: Colors.blue.shade200),
                      ),
                      const SizedBox(height: 18),
                      TextButton(
                        onPressed: _confirmDelete,
                        child: const Text(
                          'Eliminar correo',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Bottom button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _changeEmail,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cambiar correo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
