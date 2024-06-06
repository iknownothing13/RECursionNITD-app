import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:recursion/Infrastructure/api_routes/api_routes.dart';
import 'package:recursion/Infrastructure/data_sources/team_api.dart';
import 'package:recursion/Presentation/Screens/HomePage/home_page.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:recursion/Presentation/Screens/LoginPage/login.dart';
import 'package:recursion/Presentation/Screens/LoginPage/register.dart';
import 'package:recursion/Presentation/Screens/LoginPage/welcome.dart';
import 'package:recursion/Presentation/Screens/TeamPage/team_page.dart';
import '../../../Application/api_interaction/about_us_api_use_case.dart';
import '../../../Infrastructure/data_sources/Events_api.dart';
import '../../../Infrastructure/data_sources/about_us_api.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _selectedIndex = 0;
  late final FetchDataUseCase fetchDataUseCase1;
  late final FetchDataUseCaseEvent fetchDataUseCase2;
  late final FetchDataUseCaseTeam fetchDataUseCase3;

  _HomePageState() {
    fetchDataUseCase1 = FetchDataUseCase(AboutUsApi(ApiRoutes.aboutusurl));
    fetchDataUseCase2 = FetchDataUseCaseEvent(EventApi(ApiRoutes.eventurl));
    fetchDataUseCase3 = FetchDataUseCaseTeam(TeamApi(ApiRoutes.teamurl));
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: appBar(),
        body: (() {
          switch (_selectedIndex) {
            case 0:
              return Homepage();
            case 1:
              return EventPageScreen(fetchDataUseCase: fetchDataUseCase2);
            case 2:
              return TeamPageScreen(fetchDataUseCase: fetchDataUseCase3);
            case 3:
              return WelcomePage();
            default:
              return null; // Handle other cases if needed
          }
        })(),
        bottomNavigationBar: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Color.fromRGBO(81, 65, 228, 1),
              tabBackgroundColor: Colors.white,
              padding: EdgeInsets.all(15),
              gap: 9,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: [
                // elements in the bottom Nav Bar
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  iconSize: 25,
                  textSize: 25,
                ),
                GButton(
                  icon: Icons.event,
                  text: 'Events',
                  iconSize: 25,
                  textSize: 25,
                ),
                GButton(
                  icon: Icons.people_alt,
                  text: 'Team',
                  iconSize: 27,
                  textSize: 25,
                ),
                GButton(
                  icon: Icons.pan_tool,
                  text: 'testing',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(backgroundColor: Colors.black);
}
