import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Domain/Model/events_model.dart';


class EventApi {
  final String baseUrl;
  EventApi(this.baseUrl);

  Future<List<Event?>> fetchData() async {
    // ignore: unnecessary_string_interpolations
    final Uri uri = Uri.parse('$baseUrl');
    List<Event?> post = [];
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = json.decode(response.body.toString());
        post.clear();
        for (Map<String, dynamic> i in data) {
          post.add(Event.fromJson(i));
        }
        return post;
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
