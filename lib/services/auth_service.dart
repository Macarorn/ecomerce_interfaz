import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static Future<void> updatePassword({
    required String id,
    required String nombre,
    required String correo,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la contraseña');
    }
  }

  static Future<bool> checkEmailExists(String correo) async {
    final url = Uri.parse('$baseUrl/users/check-email');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'correo': correo}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'] == true;
    } else {
      throw Exception('Error al verificar el correo');
    }
  }

  // Cambia la URL base según tu entorno
  static const String baseUrl = 'http://localhost:3000/rest/v1';

  static Future<Map<String, dynamic>> loginUser({
    required String nombre,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nombre': nombre, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Error de login');
    }
  }

  static Future<Map<String, dynamic>> registerUser({
    required String nombre,
    required String apellido,
    required String correo,
    required String telefono,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'apellido': apellido,
        'correo': correo,
        'telefono': telefono,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        jsonDecode(response.body)['message'] ?? 'Error de registro',
      );
    }
  }
}
