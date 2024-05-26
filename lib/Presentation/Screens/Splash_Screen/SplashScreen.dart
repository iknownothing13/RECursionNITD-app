import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recursion/Presentation/Routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: 1000), // this is the animation speed controller
      vsync: this,
    )..repeat(reverse: true);
    // Navingating to the HomePage
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes
          .home); // pushReplacement becuase this page will only be shown
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //  brackets with different sizes and different color opacity
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RichText(
                  text: TextSpan(
                    children: [
                      buildTextSpan('{', 50, 0.8),
                      buildTextSpan('{', 40, 0.6),
                      buildTextSpan('{   ', 35, 0.4),
                      buildTextSpan('}', 35, 0.4),
                      buildTextSpan('}', 40, 0.6),
                      buildTextSpan('}', 50, 0.8),
                    ],
                  ),
                ),
              ]),
              // Spacer
              const SizedBox(height: 5),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                RichText(
                    text: TextSpan(children: [
                  bodyTextSpan("REC", 30),
                  bodyTextSpan("ursion", 30),
                ])),
              ]),

              //adjusting gaph between RECursion and the loading bar
              const SizedBox(height: 20),

              // Loading horizontal bar
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                color: Colors.grey[400],
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: const Offset(1, 0),
                  ).animate(_controller),
                  child: Container(
                    width: 10, // Adjust the width as needed
                    height: 5, // Adjust the height as needed
                    color: Colors.black, // Adjust the color as needed

                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //generalize code for the Brackets partzz
  TextSpan buildTextSpan(String t, double size, double optacity) {
    return TextSpan(
      text: t,
      style: TextStyle(
        fontSize: size,
        fontFamily: AutofillHints.countryCode,
        fontWeight: FontWeight.w600,
        letterSpacing: 3.0,
        color: Colors.black.withOpacity(optacity),
      ),
    );
  }

  // generalize code for the "RECursion" wala part
  TextSpan bodyTextSpan(String t, double size) {
    return TextSpan(
      text: t,
      style: TextStyle(
          fontSize: size,
          fontFamily: AutofillHints.countryCode,
          fontWeight: FontWeight.w600,
          letterSpacing: 5.0,
          color: Colors.black),
    );
  }
}
