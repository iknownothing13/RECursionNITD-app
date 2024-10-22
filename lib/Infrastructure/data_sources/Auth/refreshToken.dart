import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiRoutes {
  static const refreshTokenUrl = 'https://api.recursionnitd.in/api/token/refresh/'; // replace with your API route
}

Future<Map<String, dynamic>> refresh(String refreshToken) async {
  print('refresh token api called : $refreshToken');

  final response = await http.post(
    Uri.parse(ApiRoutes.refreshTokenUrl),
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
    print('data: $data');
    return data;
  } else {
    throw Exception('Failed to refresh token');
  }
}