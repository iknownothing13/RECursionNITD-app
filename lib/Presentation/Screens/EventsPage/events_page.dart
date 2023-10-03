// lib/presentation/screens/data_display_screen.dart

import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';

import '../../../Domain/Model/events_model.dart';

class EventPageScreen extends StatefulWidget {
  final FetchDataUseCaseEvent fetchDataUseCase;

  const EventPageScreen({super.key, required this.fetchDataUseCase});

  @override
  _EventPageScreenState createState() => _EventPageScreenState();
}

class _EventPageScreenState extends State<EventPageScreen> {
  late Future<List<Event?>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<List<Event?>> fetchData() async {
    try {
      final data = await widget.fetchDataUseCase.execute();
      return data;
    } catch (e) {
      // Handle errors gracefully
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Page'),
      ),
      body: FutureBuilder<List<Event?>>(
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
            // print("hello");
            // Build your UI using the 'data' variable
            // final aboutUs = snapshot.data!;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text("Event Name : }"),
                  );
                });
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
