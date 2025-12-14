import 'package:flutter/material.dart';
import 'delete_confirmation.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController(
    text: 'Derlaxy@yahoo.com',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeEmail() {
    if (!_formKey.currentState!.validate()) return;
    final newEmail = _controller.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Se ha enviado verificación a $newEmail')),
    );
    Navigator.maybePop(context, true);
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
      Navigator.maybePop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Colors.blue.shade700;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar correo'),
        backgroundColor: primary,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Correo electrónico',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _controller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'ejemplo@dominio.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty)
                              return 'Ingresa un correo';
                            final email = v.trim();
                            if (!RegExp(
                              r"^[\w-.]+@[\w-]+\.[a-zA-Z]{2,}",
                            ).hasMatch(email)) {
                              return 'Correo inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Se enviará un correo de verificación al nuevo correo.',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _changeEmail,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Guardar cambios'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: _confirmDelete,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Eliminar correo'),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.maybePop(context),
                            child: const Text('Cancelar'),
                          ),
                        ),
                      ],
                    ),
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
