import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recursion/Infrastructure/data_sources/Auth/signin_api.dart';
import '../../Domain/Model/experience_model.dart';

class ExperienceApi {
  static const String baseurl =
      "https://recnitdgp.pythonanywhere.com/legacy/experience";
  final SigninApi signinApi = SigninApi();

  // Get the token, refreshing it if necessary
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    String? refreshToken = prefs.getString('refreshToken');

    // If no token or token needs refreshing, refresh it
    if (token == null || refreshToken == null) {
      throw Exception("No tokens found. Please log in again.");
    }

    if (_isTokenExpired(token)) {
      final newTokens = await signinApi.refreshToken(refreshToken);
      // Save the new tokens
      await prefs.setString('accessToken', newTokens['access']);
      await prefs.setString('refreshToken', newTokens['refresh']);
      token = newTokens['access'];
    }
    return token;
  }

  // Helper function to check if a token is expired
  bool _isTokenExpired(String token) {
    return false;
  }

  // Fetch experiences from the API
  Future<List<ExperienceModel>> getExperiences() async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse("$baseurl"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ExperienceModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load experiences: ${response.body}");
    }
  }
}
