import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupApi {
  String baseurl;

  SignupApi({required this.baseurl});

  Future<bool?> signup(
      String username, String email, String password, String password2) async {
    final response = await http.post(
      Uri.parse(baseurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password,
          'password2': password2,
        },
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      // Optionally, handle different status codes here
      return false;
    }
  }
}
