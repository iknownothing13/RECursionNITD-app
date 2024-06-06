import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/event_api_use_case.dart';
import '../../../Domain/Model/events_model.dart';

class ContestPage extends StatefulWidget {
  List<Results?> eventsData;
  ContestPage({super.key, required this.eventsData});
  @override
  _ContestPageState createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  TextEditingController textController = TextEditingController();

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60, top: 50),
                          child: Text(
                            "Contest Page",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.eventsData != null)
                events(widget.eventsData)
              else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "No events available",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container events(List<Results?> eventsData) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(7),
            color: Colors.white,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 7),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 7, 4, 3),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${eventsData.elementAtOrNull(index)?.image}',
                                  height: 97,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  color: Colors.white.withOpacity(0.9),
                                  colorBlendMode: BlendMode.modulate,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Center(
                              child: Text(
                                '${eventsData.elementAtOrNull(index)?.title}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${eventsData.elementAtOrNull(index)?.venue}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Center(
                              child: Text(
                                '${eventsData.elementAtOrNull(index)?.targetYear}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(8, 28, 52, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
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
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              padding: EdgeInsets.all(20),
                                              height: height * 0.65,
                                              width: width * 0.85,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          '${eventsData.elementAtOrNull(index)?.image}',
                                                          height: 200,
                                                          width: 200,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  for (var item in [
                                                    [
                                                      "Event Category",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.eventType
                                                    ],
                                                    [
                                                      "Open To",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.targetYear
                                                    ],
                                                    [
                                                      "Start Time",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.startTime
                                                    ],
                                                    [
                                                      "End Time",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.endTime
                                                    ],
                                                    [
                                                      "Duration",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.duration
                                                    ],
                                                    [
                                                      "Venue",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.venue
                                                    ],
                                                    [
                                                      "Description",
                                                      eventsData
                                                          .elementAtOrNull(
                                                              index)
                                                          ?.description
                                                    ]
                                                  ])
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${item[0]} : ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${item[1]}",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  Spacer(),
                                                  Center(
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.blueAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () =>
                                                            DialogNavigator.of(
                                                                    context)
                                                                .close(),
                                                        child: const Text(
                                                          'Close',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
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
                                  'View Details',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
