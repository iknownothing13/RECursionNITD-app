import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:recursion/Infrastructure/api_routes/api_routes.dart';
import 'package:recursion/Infrastructure/data_sources/team_api.dart';
import 'package:recursion/Presentation/Screens/AboutUsPage/who_are_we.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:recursion/Presentation/Screens/InterviewExpPage/interview_exp_page.dart';
import 'package:recursion/Presentation/Screens/TeamPage/team_page.dart';

import '../../../Application/api_interaction/about_us_api_use_case.dart';
import '../../../Infrastructure/data_sources/Events_api.dart';
import '../../../Infrastructure/data_sources/about_us_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: (() {
          switch (_selectedIndex) {
            case 0:
              return AboutUsPage(fetchDataUseCase: fetchDataUseCase1);
            case 1:
              return const InterviewExpPage();
            case 2:
              return TeamPageScreen(fetchDataUseCase: fetchDataUseCase3);
            case 3:
              return EventPageScreen(fetchDataUseCase: fetchDataUseCase2);
            default:
              return null; // Handle other cases if needed
          }
        })(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Adjust the radius as needed
              topRight: Radius.circular(20.0), // Adjust the radius as needed
            ),
            color: Colors.black, // Specify your desired background color
          ),
          // color: Colors.black,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.all(17),
              gap: 5,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                // elements in the bottom Nav Bar
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.event,
                  text: 'Events',
                ),
                GButton(
                  icon: Icons.pending,
                  text: 'IE',
                ),
                GButton(icon: Icons.settings, text: 'About'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
