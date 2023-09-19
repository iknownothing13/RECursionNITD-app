import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recursion/Presentation/Screens/AboutUsPage/who_are_we.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events_page.dart';
import 'package:recursion/Presentation/Screens/InterviewExpPage/interview_exp_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const InfoPage(),
    const EventPage(),
    const InterviewExpPage(),
    const InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
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


