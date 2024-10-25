import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Model/team_model.dart';

class TeamApi {
  final String baseUrl;
  TeamApi(this.baseUrl);

  Future<List<Team?>> fetchData() async {
    final Uri uri = Uri.parse(baseUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check for cached data
    String? cachedData = prefs.getString('teamData');
    if (cachedData != null) {
      return _parseData(json.decode(cachedData));
    } 

    // If no cache, fetch from API and cache the response
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      prefs.setString('teamData', response.body);
      return _parseData(json.decode(response.body));
    } else {
      throw ApiError('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  List<Team?> _parseData(dynamic data) {
    return (data as List).map((item) => Team.fromJson(item)).toList();
  }
}

class ApiError implements Exception {
  final String message;
  ApiError(this.message);
}
