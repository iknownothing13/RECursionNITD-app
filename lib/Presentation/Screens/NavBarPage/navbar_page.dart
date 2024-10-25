import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:recursion/Infrastructure/api_routes/api_routes.dart';
import 'package:recursion/Infrastructure/data_sources/team_api.dart';
import 'package:recursion/Presentation/Screens/HomePage/home_page.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:recursion/Presentation/Screens/TeamPage/team_page.dart';
import '../../../Application/api_interaction/about_us_api_use_case.dart';
import '../../../Infrastructure/data_sources/Events_api.dart';
import '../../../Infrastructure/data_sources/about_us_api.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final FetchDataUseCase fetchDataUseCase1;
  late final FetchDataUseCaseEvent fetchDataUseCase2;
  late final FetchDataUseCaseTeam fetchDataUseCase3;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // Define colors
  final Color primaryColor = Colors.black;
  final Color accentColor = const Color(0xFF00BD6D); // Green
  final Color backgroundLight = Colors.white;

  _HomePageState() {
    fetchDataUseCase1 = FetchDataUseCase(AboutUsApi(ApiRoutes.aboutusurl));
    fetchDataUseCase2 = FetchDataUseCaseEvent(EventApi(ApiRoutes.eventurl));
    fetchDataUseCase3 = FetchDataUseCaseTeam(TeamApi(ApiRoutes.teamurl));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (() {
          switch (_selectedIndex) {
            case 0:
              return Homepage(
                fetchDataUseCase: fetchDataUseCase1,
              );
            case 1:
              return EventPageScreen(fetchDataUseCase: fetchDataUseCase2);
            case 2:
              return TeamPageScreen(fetchDataUseCase: fetchDataUseCase3);
            default:
              return null;
          }
        })(),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: [
            Icon(Icons.home, size: 30, color: accentColor),
            Icon(Icons.event, size: 30, color: accentColor),
            Icon(Icons.account_circle_outlined, size: 30, color: accentColor),
          ],
          color: backgroundLight,
          //buttonBackgroundColor: accentColor,
          backgroundColor: primaryColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 500),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 0,
  );
}
