import 'package:flutter/material.dart';
import 'package:recursion/Presentation/Routes/app_routes.dart';
import 'package:recursion/Presentation/Screens/NavBarPage/navbar_page.dart';
import 'package:recursion/Presentation/Screens/InterviewExpPage/interview_exp_page.dart';

import '../Screens/ErrorPage/error_page.dart';
import '../Screens/Splash_Screen/SplashScreen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      // case AppRoutes.events:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) => const EventPageScreen(),
      //     settings: settings,
      //   );

      case AppRoutes.interviewExperience:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const InterviewExpPage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ErrorPage(),
          settings: settings,
        );
    }
  }
}
