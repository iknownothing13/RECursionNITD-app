// lib/presentation/screens/data_display_screen.dart

import 'package:flutter/material.dart';

import '../../../Application/api_interaction/about_us_api_use_case.dart';
import '../../../Domain/Model/about_us_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: FutureBuilder<AboutUs?>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            // Build your UI using the 'data' variable
            // final aboutUs = snapshot.data!;
            return ListTile(
              title: Text(
                  'Years of Experience: ${data.yearsOfExperience ?? 'N/A'}'),
              trailing: Text('Contest Count: ${data.contestCount ?? 'N/A'}'),
              subtitle: Text('Hours Teaching: ${data.hoursTeaching ?? 'N/A'}'),
            );
          } else {
            // Handle other cases, e.g., when there is no data
            return const Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
