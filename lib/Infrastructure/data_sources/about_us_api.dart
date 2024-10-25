import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Model/about_us_model.dart';

class AboutUsApi {
  final String baseUrl;
  AboutUsApi(this.baseUrl);

  Future<AboutUs?> fetchData() async {
    final Uri uri = Uri.parse(baseUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check for cached data
    String? cachedData = prefs.getString('aboutUsData');
    if (cachedData != null) {
      return AboutUs.fromJson(json.decode(cachedData));
    }

    // Fetch data from API and cache it
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      prefs.setString('aboutUsData', response.body); // Cache the response
      return AboutUs.fromJson(json.decode(response.body));
    } else {
      throw ApiError(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  }
}

class ApiError implements Exception {
  final String message;
  ApiError(this.message);
}
