// lib/presentation/screens/data_display_screen.dart

import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Domain/Model/team_model.dart';

class TeamPageScreen extends StatefulWidget {
  final FetchDataUseCaseTeam fetchDataUseCase;

  const TeamPageScreen({super.key, required this.fetchDataUseCase});

  @override
  // ignore: library_private_types_in_public_api
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
      // ignore: avoid_print
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Our Team',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize:30 ),),
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
                  return Card(
                    color:Colors.grey[700],
                      child: Column(
                    children: <Widget>[
                      GestureDetector(
                        //onTap: _launchURL(data[index]!.urlLinkedIn!.toString()),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                            data[index]!.image!.toString(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          Text('Name : ${data[index]!.name!.toString()}',style: TextStyle(color: Colors.white),),
                          const SizedBox(height:2.5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "Year : ${data[index]!.batchYear!.toString()}",style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 10),
                              Text(
                                  "Phone Number : ${data[index]!.mobile!.toString()}",style: TextStyle(color: Colors.white)),
                            ],
                          )
                        ],
                      )
                    ],
                  ));
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

_launchURL(text) async {
  if (await canLaunch(text)) {
    await launch(text);
  } else {
    throw 'Could not launch $text';
  }
}
