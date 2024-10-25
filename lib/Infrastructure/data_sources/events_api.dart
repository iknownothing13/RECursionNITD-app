import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Model/events_model.dart';

class EventApi {
  final String baseUrl;
  EventApi(this.baseUrl);

  Future<List<Results?>> fetchData() async {
    final Uri uri = Uri.parse(baseUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check for cached data
    String? cachedData = prefs.getString('eventData');
    if (cachedData != null) {
      return _parseData(json.decode(cachedData));
    }

    // Fetch data from API and cache it
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      prefs.setString('eventData', response.body); // Fixed key to 'eventData'
      return _parseData(json.decode(response.body));
    } else {
      throw ApiError(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  List<Results?> _parseData(dynamic data) {
    // Assuming data['results'] contains the list of events
    return (data['results'] as List)
        .map((item) => Results.fromJson(item))
        .toList();
  }
}

class ApiError implements Exception {
  final String message;
  ApiError(this.message);
}
