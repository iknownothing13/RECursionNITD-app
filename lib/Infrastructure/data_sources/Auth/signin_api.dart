import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  SigninApi({required this.baseurl});

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await secureStorage.write(key: 'accessToken', value: accessToken);
    await secureStorage.write(key: 'refreshToken', value: refreshToken);
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
      Uri.parse('https://api.recursionnitd.in/api/token/refresh/'),
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
      await _saveTokens(data['access'], refreshToken); // Save refreshed access token
      return data;
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> logout() async {
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');
  }
}
