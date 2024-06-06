import 'dart:convert';
import 'package:http/http.dart' as http;

class SigninApi {
  String baseurl;

  SigninApi({required this.baseurl});

  Future<bool?> signin(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    );

    if (response.statusCode == 200) {
      // Login successful
      return true;
    } else {
      // Login failed
      return false;
    }
  }
}
