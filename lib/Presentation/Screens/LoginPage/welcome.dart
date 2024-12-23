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

    // Calculate responsive font sizes
    final headingFontSize =
        width * 0.06; // Increased from 0.05 for better visibility
    final bodyFontSize =
        width * 0.035; // Increased from 0.03 for better readability
    final buttonFontSize = width * 0.04; // Kept the same as it works well

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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Enterprise team\ncollaboration.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: headingFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width * 0.8,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Bring together your files, your tools, project and people. Including a new mobile and desktop application.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: bodyFontSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: buttonFontSize,
                                fontWeight: FontWeight.bold,
                              ),
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
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: buttonFontSize,
                                fontWeight: FontWeight.bold,
                              ),
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
