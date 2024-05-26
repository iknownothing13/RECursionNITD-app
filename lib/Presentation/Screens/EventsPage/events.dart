// lib/presentation/screens/data_display_screen.dart

import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import '../../../Domain/Model/events_model.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class EventsPage extends StatefulWidget {
  final FetchDataUseCaseEvent fetchDataUseCase;

  const EventsPage({super.key, required this.fetchDataUseCase});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
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
                data.where((event) => event?.eventType == 'Event').toList();
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
                        color: Color.fromRGBO(12, 12, 12, 1.0),
                      ),
                      height: height * 0.14,
                      width: width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 50,
                                ),
                                child: BackButton(
                                  color: Colors.white,
                                  style: ButtonStyle(
                                    enableFeedback: true,
                                    iconSize: WidgetStatePropertyAll(26),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 60, top: 50),
                                child: Text(
                                  "Events Page",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10, right: 15),
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
                          //     //autoFocus: true,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    if (classesData.isNotEmpty) classes(classesData),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
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

  Container classes(List<Results?> classesData) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(7),
            color: Colors.white,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 7),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: classesData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 7, 4, 3),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.network(
                                  height: 70,
                                  '${classesData.elementAtOrNull(index)?.image}'),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: <Widget>[
                                // title
                                Center(
                                  child: Text(
                                    '${classesData.elementAtOrNull(index)?.title}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    // detail 1
                                    // Text(
                                    //   '${classesData.elementAtOrNull(index)?.eventType}',
                                    //   style: TextStyle(
                                    //     fontSize: 12,
                                    //     color: Colors.greenAccent,
                                    //     fontWeight: FontWeight.bold,
                                    //     letterSpacing: 1,
                                    //   ),
                                    // ),
                                    // detail 2

                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Text(
                                        '${classesData.elementAtOrNull(index)?.venue}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 15),
                                Text(
                                  '${classesData.elementAtOrNull(index)?.targetYear}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.amberAccent,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(242, 97, 63, 1.0),
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => FluidDialog(
                                          rootPage: FluidDialogPage(
                                              alignment: Alignment.center,
                                              builder: (context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  height: height * 0.50,
                                                  width: width * 0.75,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Image.network(
                                                            height: 200,
                                                            fit: BoxFit.fill,
                                                            width: 200,
                                                            '${classesData.elementAtOrNull(index)?.image}'),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Event Category  :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.eventType}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Open To  :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.targetYear}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Start Time  :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.startTime}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("End Time  :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.endTime}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Duration :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.duration}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("Venue :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.venue}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Description  :  "),
                                                          Text(
                                                            '${classesData.elementAtOrNull(index)?.description}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        color: Colors.black,
                                                        child: TextButton(
                                                          onPressed: () =>
                                                              DialogNavigator.of(
                                                                      context)
                                                                  .close(),
                                                          child: const Text(
                                                            'Close',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                // const SecondDialogPage(),
                                              }),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Konw More",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
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
}
