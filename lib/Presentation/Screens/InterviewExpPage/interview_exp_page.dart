import 'package:flutter/material.dart';

class InterviewExpPage extends StatefulWidget {
  const InterviewExpPage({super.key});

  @override
  State<InterviewExpPage> createState() => _InterviewExpPageState();
}

class _InterviewExpPageState extends State<InterviewExpPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "RECursion IE Page",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      )),
    );
  }
}
