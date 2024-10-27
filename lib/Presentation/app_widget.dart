import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Presentation/Routes/app_routes.dart';
import '../../Presentation/Routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = AppRoutes.splashScreen;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      initialRoute = isLoggedIn
          ? AppRoutes.home
          : AppRoutes.login; // Set initial route based on login status
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        onGenerateRoute: AppRouter.onGenerateRoute);
  }
}
