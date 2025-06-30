import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = 'https://dummyjson.com/auth/login';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
