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
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    // Navigate to the LoginPage after 2 seconds
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
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
              const SizedBox(height: 5),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                RichText(
                    text: TextSpan(children: [
                  bodyTextSpan("REC", 30),
                  bodyTextSpan("ursion", 30),
                ])),
              ]),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                color: Colors.grey[400],
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: const Offset(1, 0),
                  ).animate(_controller),
                  child: Container(
                    width: 10,
                    height: 5,
                    color: Colors.black,
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