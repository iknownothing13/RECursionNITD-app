import 'package:flutter/material.dart';
import '../Presentation/app_widget.dart';

void main() {
  runApp(const MyApp());
}
// void main() async {
//   final signinApi = SigninApi();

//   // Simulate fetching the refresh token from storage
//   final prefs = await SharedPreferences.getInstance();
//   final refreshToken = prefs.getString('refreshToken');

//   if (refreshToken != null) {
//     try {
//       print('Attempting to refresh token using refresh token: $refreshToken');
//       print('Old Access Token: ${prefs.getString('accessToken')}');
//       final newTokens = await signinApi.refreshToken(refreshToken);
//       print('New Access Token: ${newTokens['access']}');
//       print('Refresh token used successfully');
//     } catch (e) {
//       print('Error refreshing token: $e');
//     }
//   } else {
//     print('No refresh token found.');
//   }
// }
