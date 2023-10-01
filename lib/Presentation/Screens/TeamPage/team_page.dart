// lib/presentation/screens/data_display_screen.dart

import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';

import '../../../Domain/Model/team_model.dart';

class TeamPageScreen extends StatefulWidget {
  final FetchDataUseCaseTeam fetchDataUseCase;

  const TeamPageScreen({super.key, required this.fetchDataUseCase});

  @override
  _TeamPageScreenState createState() => _TeamPageScreenState();
}

class _TeamPageScreenState extends State<TeamPageScreen> {
  late Future<List<Team?>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<List<Team?>> fetchData() async {
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
        title: const Text('Our Team'),
      ),
      body: FutureBuilder<List<Team?>>(
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
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius:
                          25.0, // Set the radius to control the size of the circular photo
                      backgroundImage: NetworkImage(
                        data[index]!
                            .image!
                            .toString(), // Replace with your image URL
                      ),
                    ),
                    title: Text('Name : ${data[index]!.name!.toString()}'),
                    trailing:
                        Text("Year : ${data[index]!.batchYear!.toString()}"),
                    subtitle: Text(
                        "Phone Number : ${data[index]!.mobile!.toString()}"),
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
