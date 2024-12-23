// getting_started_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Model/getting_started_model.dart';

class Getting_startedApi {
  final String baseUrl;
  Getting_startedApi(this.baseUrl);

  Future<GettingStartedModel> fetchData() async {
    final Uri uri = Uri.parse(baseUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? cachedData = prefs.getString('gettingstartedData');
      if (cachedData != null) {
        return GettingStartedModel.fromJson(json.decode(cachedData));
      }

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = response.body;
        prefs.setString('gettingstartedData', jsonData);
        return GettingStartedModel.fromJson(json.decode(jsonData));
      } else {
        throw ApiError('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ApiError('Error processing data: $e');
    }
  }
}

class ApiError implements Exception {
  final String message;
  ApiError(this.message);
}