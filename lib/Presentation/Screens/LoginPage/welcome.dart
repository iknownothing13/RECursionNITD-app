import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recursion/Presentation/Screens/LoginPage/login.dart';
import 'package:recursion/Presentation/Screens/LoginPage/register.dart';
import 'package:recursion/Presentation/Screens/NavBarPage/navbar_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.05,
          ),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: width * 0.7,
                        height: height * 0.3,
                        child: Image.asset('images/REC_logo.png'),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Text(
                      "Enterprise team\ncollaboration.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width * 0.8,
                      child: Text(
                        "Bring together your files, your tools, project and people. Including a new mobile and desktop application.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height *
                            0.08, // Adjust button height based on screen height
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.resolveWith(
                              (states) => Colors.black12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: width *
                                  0.04, // Adjust font size based on width
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Container(
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.resolveWith(
                              (states) => Colors.black12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
