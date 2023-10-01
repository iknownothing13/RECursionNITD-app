import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Domain/Model/about_us_model.dart';


class AboutUsApi {
  final String baseUrl;
  AboutUsApi(this.baseUrl);
  


    Future<AboutUs?> fetchData() async {
    // ignore: unnecessary_string_interpolations
    final Uri uri = Uri.parse('$baseUrl');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return AboutUs.fromJson(data);
      } else {
        throw ApiError(
          message: 'Failed to fetch data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ApiError(message: 'Failed to fetch data. Error: $e');
    }
  }
}
class ApiError implements Exception {
  final String message;

  ApiError({required this.message});
}
