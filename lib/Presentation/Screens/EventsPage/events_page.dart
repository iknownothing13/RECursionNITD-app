// lib/presentation/screens/data_display_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import 'package:recursion/Presentation/Screens/EventsPage/classes.dart';
import 'package:recursion/Presentation/Screens/EventsPage/contest.dart';
import 'package:recursion/Presentation/Screens/EventsPage/events.dart';
import '../../../Domain/Model/events_model.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../Infrastructure/api_routes/api_routes.dart';
import '../../../Infrastructure/data_sources/Events_api.dart';

class EventPageScreen extends StatefulWidget {
  final FetchDataUseCaseEvent fetchDataUseCase;

  EventPageScreen({super.key, required this.fetchDataUseCase});

  @override
  _EventPageScreenState createState() => _EventPageScreenState();
}

class _EventPageScreenState extends State<EventPageScreen> {
  late Future<List<Results?>> _dataFuture;
  late final FetchDataUseCaseEvent fetchDataUseCase2;

  _EventPageScreenState() {
    fetchDataUseCase2 = FetchDataUseCaseEvent(EventApi(ApiRoutes.eventurl));
  }

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

  TextEditingController textController = TextEditingController();

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Results?>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SimpleCircularProgressBar(
                progressColors: [Colors.orange, Colors.red],
                backColor: Colors.black,
                size: 100,
                fullProgressColor: Colors.green,
                animationDuration: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final classesData =
                data.where((event) => event?.eventType == 'Class').toList();
            final eventsData =
                data.where((event) => event?.eventType == 'Event').toList();
            final contestData =
                data.where((event) => event?.eventType == 'Contest').toList();

            // Build your UI using the 'data' variable
            // final aboutUs = snapshot.data!;
            return SingleChildScrollView(
              //physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: Colors.indigo,
                      ),
                      height: height * 0.27,
                      width: width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15, top: 20, right: 5),
                                child: ClipRRect(
                                  child: Image.asset(
                                    'images/REC_logo.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: 140, left: 5, top: 20),
                                child: Text(
                                  "RECursion",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          // Text(
                          //   "Events Page",
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: 20),
                          // ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 20),
                            child: Text(
                              "We don't remember the dates, we remember events!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 18),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 10, right: 15),
                          //   // child: showSearch(
                          //   //   context: context,
                          //   //   delegate: customSearch(),
                          //   // ),9
                          //   child: AnimSearchBar(
                          //     width: 370,
                          //     textController: textController,
                          //     onSuffixTap: () {
                          //       setState(() {
                          //         textController.clear();
                          //       });
                          //     },
                          //     onSubmitted: (p0) {},
                          //     helpText: "Search Events",
                          //     closeSearchOnSuffixTap: false,
                          //     prefixIcon: Icon(IconlyLight.search),
                          //     style: TextStyle(
                          //       fontFamily: 'Poppins',
                          //     ),
                          //     rtl: true,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (classesData.isNotEmpty) classes(classesData),
                    //classes(data),
                    SizedBox(
                      height: 15,
                    ),
                    //events(data),
                    if (eventsData.isNotEmpty) events(eventsData),
                    SizedBox(
                      height: 15,
                    ),
                    //contest(data),
                    if (contestData.isNotEmpty) contest(contestData),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Handle other cases, e.g., when there is no data
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }

  Container classes(List<Results?> classesData) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Classes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: width * 0.50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ClassesPage(eventsData: classesData)),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_outlined,
                size: 17,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(5),
            color: Colors.white,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  //mainAxisSpacing: 7,
                  //crossAxisSpacing: 7
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    ///Here replace Card Widget with Container
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.indigo.shade300,
                            spreadRadius: 1,
                            blurRadius: 6)
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Image.network(
                                  height: 80,
                                  '${classesData.elementAtOrNull(index)?.image}'),
                            ),
                            // title
                            Center(
                              child: Text(
                                '${classesData.elementAtOrNull(index)?.title}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Text(
                              '${classesData.elementAtOrNull(index)?.venue}',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '${classesData.elementAtOrNull(index)?.targetYear}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Container events(List<Results?> eventsData) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Events",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: width * 0.50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            EventsPage(eventsData: eventsData)),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_outlined,
                size: 17,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  //mainAxisSpacing: 7,
                  //crossAxisSpacing: 7
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  return Container(
                    ///Previous there is a Card Widgest I replace with Container for shadow
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.indigo.shade300,
                            spreadRadius: 1,
                            blurRadius: 6)
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Image.network(
                                  height: 80,
                                  '${eventsData.elementAtOrNull(index)?.image}'),
                            ),
                            // title
                            Center(
                              child: Text(
                                '${eventsData.elementAtOrNull(index)?.title}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Text(
                              '${eventsData.elementAtOrNull(index)?.venue}',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '${eventsData.elementAtOrNull(index)?.targetYear}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Container contest(List<Results?> contestData) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Contest",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: width * 0.50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ContestPage(eventsData: contestData)),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_forward_outlined,
                size: 17,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  //mainAxisSpacing: 7,
                  //crossAxisSpacing: 7
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contestData.length,
                itemBuilder: (context, index) {
                  return Container(
                    ///Previous there is a Card Widgest I replace with Container for shadow
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.indigo.shade300,
                            spreadRadius: 1,
                            blurRadius: 6)
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Image.network(
                                  height: 80,
                                  '${contestData.elementAtOrNull(index)?.image}'),
                            ),
                            // title
                            Center(
                              child: Text(
                                '${contestData.elementAtOrNull(index)?.title}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Text(
                              '${contestData.elementAtOrNull(index)?.venue}',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            SizedBox(width: 15),
                            Text(
                              '${contestData.elementAtOrNull(index)?.targetYear}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  customSearch() {
    return Container();
  }
}
