// lib/presentation/screens/data_display_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AboutUsPage extends StatefulWidget {
  final FetchDataUseCase fetchDataUseCase;

  const AboutUsPage({super.key, required this.fetchDataUseCase});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late Future<AboutUs?> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<AboutUs?> fetchData() async {
    try {
      final data = await widget.fetchDataUseCase.execute();
      return data;
    } catch (e) {
      // Handle errors gracefully
      print('Error fetching data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: const [
            Text(
              "RECursion AboutUs Page",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      )),
    );
  }
}
