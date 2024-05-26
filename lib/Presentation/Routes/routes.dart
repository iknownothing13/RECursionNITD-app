import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/about_us_api_use_case.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:recursion/Infrastructure/api_routes/api_routes.dart';
import 'package:recursion/Infrastructure/data_sources/Events_api.dart';
import 'package:recursion/Infrastructure/data_sources/about_us_api.dart';
import 'package:recursion/Presentation/Routes/app_routes.dart';
import 'package:recursion/Presentation/Screens/EventsPage/classes.dart';
import 'package:recursion/Presentation/Screens/EventsPage/contest.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:recursion/Presentation/Screens/NavBarPage/navbar_page.dart';
import 'package:recursion/Presentation/Screens/AskREC/askREC.dart';
import 'package:recursion/Presentation/Screens/TeamPage/team_page.dart';

import '../../Infrastructure/data_sources/team_api.dart';
import '../Screens/ErrorPage/error_page.dart';
import '../Screens/Splash_Screen/SplashScreen.dart';

late final FetchDataUseCase fetchDataUseCase1;
late final FetchDataUseCaseEvent fetchDataUseCase2;
late final FetchDataUseCaseTeam fetchDataUseCase3;

_HomePageState() {
  fetchDataUseCase1 = FetchDataUseCase(AboutUsApi(ApiRoutes.aboutusurl));
  fetchDataUseCase2 = FetchDataUseCaseEvent(EventApi(ApiRoutes.eventurl));
  fetchDataUseCase3 = FetchDataUseCaseTeam(TeamApi(ApiRoutes.teamurl));
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashScreen(),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
        );

      case AppRoutes.events:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EventPageScreen(fetchDataUseCase: fetchDataUseCase2),
          settings: settings,
        );

      case AppRoutes.ask:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AskREC(),
          settings: settings,
        );

      case AppRoutes.classes:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ClassesPage(fetchDataUseCase: fetchDataUseCase2),
          settings: settings,
        );

      case AppRoutes.event:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EventsPage(fetchDataUseCase: fetchDataUseCase2),
          settings: settings,
        );

      case AppRoutes.contest:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ContestPage(fetchDataUseCase: fetchDataUseCase2),
          settings: settings,
        );

      // case AppRoutes.team:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (_) =>
      //          TeamPageScreen(fetchDataUseCase: fetchDataUseCase3),
      //     settings: settings,
      //   );

      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ErrorPage(),
          settings: settings,
        );
    }
  }
}
