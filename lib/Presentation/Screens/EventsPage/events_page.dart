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
  late Future<List<Results?>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<List<Results?>> fetchData() async {
    try {
      final data = await widget.fetchDataUseCase.execute();
      print(data.elementAt(1));
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
      body: FutureBuilder<List<Results?>>(
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
                  return  ListTile(
                    onTap: () {
                      
                    },
                    title: Text(
                      " ${data.elementAtOrNull(index)?.title }",
                      style : TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,

                      ),
                      ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('${data.elementAtOrNull(index)?.image}'),
                    ),
                    trailing: Column(
                      children: <Widget>[
                        Text(
                          ' ${data.elementAtOrNull(index)?.eventType}'
                        ),
                        Text(
                          'Venue: ${data.elementAtOrNull(index)?.venue}',
                        ),
                      ],
                    ),

                    
                    
                  
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
