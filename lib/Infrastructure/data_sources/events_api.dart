import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Domain/Model/events_model.dart';


class EventApi {
  String baseUrl;
  EventApi(this.baseUrl);

  Future<List<Results?>> fetchData() async {
    // ignore: unnecessary_string_interpolations
    baseUrl = 'https://recnitdgp.pythonanywhere.com/api/events/';
    final Uri uri = Uri.parse(baseUrl);
    List<Results?> post = [];
    try {
      final response = await http.get(uri);
    
      if (response.statusCode == 200) {
        
        var data = jsonDecode(response.body.toString());

        post.clear();
        for (Map<String, dynamic> i in data['results']) {
          post.add(Results.fromJson(i));
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
