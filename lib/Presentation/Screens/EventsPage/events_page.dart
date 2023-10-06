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
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text('Event Page',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[900],
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
        
            // Build your UI using the 'data' variable
            // final aboutUs = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.fromLTRB(10,30,10,0),
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return  Card(
                      color: Colors.grey[700],
                      child : Padding(
                        padding: const EdgeInsets.fromLTRB(10, 7, 4, 3),
                        child: Container(
                          child : Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('${data.elementAtOrNull(index)?.image}'),
                                  minRadius: 40.0,
                                  
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(2,2,2,2),
                                child: Column(
                                 
                                  children: <Widget>[
                                    // title
                         
                                      Center(
                                        child: Text(
                                          '${data.elementAtOrNull(index)?.title}',
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: const Color.fromARGB(244, 255, 255, 255),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            fontStyle: FontStyle.normal,
                                                            
                                            
                                          ),
                                        ),
                                      ),
                                    SizedBox(height:4),
                                    Row(
                                      children: <Widget>[
                                        // detail 1
                                        Text(
                                          '${data.elementAtOrNull(index)?.eventType}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.greenAccent,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        // detail 2
                                        SizedBox(width: 10,),
                                        Text(
                                          '${data.elementAtOrNull(index)?.venue}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,

                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          '${data.elementAtOrNull(index)?.targetYear}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.amberAccent,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                                  
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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
