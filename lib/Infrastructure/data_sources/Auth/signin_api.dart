import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiError {
  final String message;

  ApiError(this.message);

  @override
  String toString() {
    return "ApiError: $message";
  }
}

class SigninApi {
  final String baseurl;

  SigninApi({
    this.baseurl = 'https://recnitdgp.pythonanywhere.com/api/token/',
  });

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<bool> signin(String username, String password) async {
    try {
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
        final responseBody = jsonDecode(response.body);
        final accessToken = responseBody['access'];
        final refreshToken = responseBody['refresh'];
        await _saveTokens(accessToken, refreshToken);
        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');
        print('Tokens saved successfully');
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        throw ApiError('Failed to sign in: ${responseBody["detail"]}');
      }
    } catch (error) {
      if (error is ApiError) {
        throw error;
      } else {
        throw ApiError('An unexpected error occurred');
      }
    }
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    final response = await http.post(
      //https://api.recursionnitd.in/api/token/refresh/
      Uri.parse('https://recnitdgp.pythonanywhere.com/api/token/refresh/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
      body: jsonEncode({
        'refresh': refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(
          data['access'], refreshToken); // Save refreshed access token
      return data;
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}
