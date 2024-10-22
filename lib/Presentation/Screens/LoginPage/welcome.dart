import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recursion/Presentation/Screens/LoginPage/login.dart';
import 'package:recursion/Presentation/Screens/LoginPage/register.dart';
import 'package:recursion/Presentation/Screens/NavBarPage/navbar_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Image(
                          image: AssetImage('images/REC_logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Enterprise team\ncollaboration.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Bring together your files, your tools, project and people. Including a new mobile and desktop application.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        width: double.infinity,
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
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 60,
                        width: double.infinity,
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
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
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
