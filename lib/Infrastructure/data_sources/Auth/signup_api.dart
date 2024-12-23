import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiError {
  final String message;

  ApiError(this.message);

  @override
  String toString() {
    return "ApiError: $message";
  }
}

class SignupApi {
  final String baseurl;

  SignupApi({required this.baseurl});

  Future<bool> signup(
      String username, String email, String password, String password2) async {
    try {
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
        final responseBody = jsonDecode(response.body);
        throw ApiError(
            'Failed to sign up: ${responseBody["username"] ?? responseBody["email"] ?? responseBody["password"] ?? responseBody["confirm_password"] ?? responseBody["password2"]}');
      }
    } catch (error) {
      if (error is ApiError) {
        print(error);
        throw error;
      } else {
        print(ApiError('An unexpected error occurred: $error'));
        throw ApiError('An unexpected error occurred');
      }
    }
  }
}
