import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/about_us_api_use_case.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:recursion/Presentation/Routes/app_routes.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:recursion/Presentation/Screens/LoginPage/welcome.dart';
import 'package:recursion/Presentation/Screens/NavBarPage/navbar_page.dart';
import '../Screens/ErrorPage/error_page.dart';
import '../Screens/Splash_Screen/SplashScreen.dart';

late final FetchDataUseCase fetchDataUseCase1;
late final FetchDataUseCaseEvent fetchDataUseCase2;
late final FetchDataUseCaseTeam fetchDataUseCase3;

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute<dynamic>(
          builder: (_) => WelcomePage(),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
        );

      // Add any additional routes here if needed

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ErrorPage(),
          settings: settings,
        );
    }
  }
}
