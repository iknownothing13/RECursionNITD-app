import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:recursion/Infrastructure/api_routes/api_routes.dart';
import 'package:recursion/Infrastructure/data_sources/team_api.dart';
import 'package:recursion/Presentation/Screens/HomePage/home_page.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:recursion/Presentation/Screens/TeamPage/team_page.dart';
import '../../../Application/api_interaction/about_us_api_use_case.dart';
import '../../../Application/api_interaction/getting_started_api_use_case.dart';
import '../../../Infrastructure/data_sources/Events_api.dart';
import '../../../Infrastructure/data_sources/about_us_api.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../../Infrastructure/data_sources/getting_started_api.dart';

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
  late final FetchDataUseCaseGetting_started fetchDataUseCase4;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  // Define colors
  final Color primaryColor = Colors.black;
  final Color accentColor = const Color(0xFF00BD6D); // Green
  final Color backgroundLight = Colors.white;

  // Define icon sizes based on screen size
  double _getIconSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 35; // Larger icons for tablets/desktop
    }
    return 30; // Default size for phones
  }

  // Define navigation bar height based on screen size
  double _getNavBarHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight > 800) {
      return 65; // Taller nav bar for larger screens
    }
    return 55; // Default height for smaller screens
  }

  _HomePageState() {
    fetchDataUseCase1 = FetchDataUseCase(AboutUsApi(ApiRoutes.aboutusurl));
    fetchDataUseCase2 = FetchDataUseCaseEvent(EventApi(ApiRoutes.eventurl));
    fetchDataUseCase3 = FetchDataUseCaseTeam(TeamApi(ApiRoutes.teamurl));
    fetchDataUseCase4 = FetchDataUseCaseGetting_started(
        Getting_startedApi(ApiRoutes.gettingstartedurl));
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    final iconSize = _getIconSize(context);
    final navBarHeight = _getNavBarHeight(context);

    // Create navigation items
    final navItems = [
      Icon(Icons.home, size: iconSize, color: accentColor),
      Icon(Icons.event, size: iconSize, color: accentColor),
      //Icon(Icons.airplanemode_on, size: iconSize, color: accentColor),
      Icon(Icons.account_circle_outlined, size: iconSize, color: accentColor),
    ];

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // Side navigation for landscape tablets and desktop
            if (isLandscape && screenSize.width > 900)
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.selected,
                destinations: navItems.map((icon) {
                  return NavigationRailDestination(
                    icon: icon,
                    label: Text(''),
                  );
                }).toList(),
                backgroundColor: backgroundLight,
                selectedIconTheme: IconThemeData(color: primaryColor),
                unselectedIconTheme: IconThemeData(color: accentColor),
              ),
            Expanded(
              child: Scaffold(
                body: (() {
                  switch (_selectedIndex) {
                    case 0:
                      return Homepage(
                        fetchDataUseCase1: fetchDataUseCase1,
                        fetchDataUseCase4: fetchDataUseCase4,
                      );
                    case 1:
                      return EventPageScreen(
                          fetchDataUseCase: fetchDataUseCase2);
                    case 2:
                      return TeamPageScreen(
                          fetchDataUseCase: fetchDataUseCase3);
                    // case 3:
                    //   return GettingStartedPage(
                    //       fetchDataUseCase: fetchDataUseCase4);
                    default:
                      return null;
                  }
                })(),
              ),
            ),
          ],
        ),
        // Bottom navigation for portrait mode and smaller screens
        bottomNavigationBar: (isLandscape && screenSize.width > 900)
            ? null
            : CurvedNavigationBar(
                key: _bottomNavigationKey,
                index: _selectedIndex,
                items: navItems,
                color: backgroundLight,
                backgroundColor: primaryColor,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 500),
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                height: navBarHeight,
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
