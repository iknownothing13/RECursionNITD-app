import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/team_api_use_case.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../Domain/Model/team_model.dart';

class TeamPageScreen extends StatefulWidget {
  final FetchDataUseCaseTeam fetchDataUseCase;

  TeamPageScreen({super.key, required this.fetchDataUseCase});

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
      print('Error fetching data: $e');
      return [
      ];
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
      body: FutureBuilder<List<Team?>>(
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
            final data26 =
                data.where((team) => team?.batchYear == 2026).toList();
            final data25 =
                data.where((team) => team?.batchYear == 2025).toList();
            final data24 =
                data.where((team) => team?.batchYear == 2024).toList();
            final dataAlumni = data
                .where((team) =>
                    team?.batchYear != 2024 &&
                    team?.batchYear != 2025 &&
                    team?.batchYear != 2026)
                .toList();

            return DefaultTabController(
              length: 4,
              initialIndex: 1,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: height * 0.15,
                  backgroundColor: Colors.black,
                  title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.black,
                    ),
                    height: height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  'images/REC_logo.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "RECursion",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Meet the Team RECursion",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.white,
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              tabs: [
                                Tab(text: "Alumni"),
                                Tab(text: "2024"),
                                Tab(text: "2025"),
                                Tab(text: "2026"),
                              ],
                              isScrollable: true,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black45,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                          Container(
                            height: 10,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    AlumniList(dataAlumni),
                    TeamList(data24),
                    TeamList(data25),
                    TeamList(data26),
                  ],
                ),
              ),
            );
          } else {
            return Center(
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
//----------------------------------------------Flip Card Team List View
// SingleChildScrollView TeamList(List<Team?> data) {
//   return SingleChildScrollView(
//     child: Container(
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               //borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1.0,
//                     mainAxisSpacing: 7,
//                     crossAxisSpacing: 7),
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   return FlipCard(
//                       flipOnTouch: true,
//                       fill: Fill
//                           .fillFront, // Fill the back side of the card to make in the same size as the front.
//                       direction: FlipDirection.HORIZONTAL, // default
//                       side: CardSide.FRONT,
//                       front: Stack(
//                         children: <Widget>[
//                           // CircleAvatar(
//                           //   backgroundImage: NetworkImage(
//                           //     data[index]!.image!.toString(),
//                           //   ),
//                           // ),
//                           Container(
//                             child: Image.network(
//                               "${data[index]!.image!.toString()}",
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   'images/profile.png',

//                                   fit: BoxFit.cover,
//                                 );
//                               },
//                             ),
//                           ),
//                           Container(
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 133,
//                                 ),
//                                 Container(
//                                   height: 50,
//                                   color: Colors.black54,
//                                   child: Center(
//                                     child: Text.rich(TextSpan(
//                                         text: "${data[index]!.name}",
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600))),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       back: Container(
//                         color: Colors.white,
//                         child: Column(
//                           children: [
//                             Text.rich(
//                               TextSpan(
//                                   text:
//                                       "Phone Number : ${data[index]!.mobile!.toString()}"),
//                             ),
//                             Text.rich(
//                               TextSpan(
//                                   text:
//                                       "B.Tech. in ${data[index]!.branch!.toString()}"),
//                             ),
//                             Text.rich(
//                               TextSpan(
//                                   text:
//                                       "Designation : ${data[index]!.designation!.toString()}"),
//                             ),
//                             Text.rich(
//                               TextSpan(
//                                   text:
//                                       "LinkedIn : ${data[index]!.urlLinkedIn!.toString()}"),
//                             ),
//                           ],
//                         ),
//                       ));
//                 }),
//           )
//         ],
//       ),
//     ),
//   );
// }

//---------------------------------------avatar team list view
SingleChildScrollView TeamList(List<Team?> data) {
  return SingleChildScrollView(
    child: Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0.0,
                  shadowColor: Colors.red,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String uri =
                              ("${data[index]!.urlLinkedIn!.toString()}");
                          launchUrl(Uri.parse(uri),
                              mode: LaunchMode.externalApplication);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "${data[index]!.image!.toString()}",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'images/profile.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${data[index]!.name!.toString()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url1 =
                                        "${data[index]!.urlLinkedIn!.toString()}";
                                    if (await canLaunchUrlString(url1)) {
                                      await launchUrlString(url1);
                                    } else {
                                      throw 'Could not launch $url1';
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

SingleChildScrollView AlumniList(List<Team?> data) {
  final List<int> batchYears = [2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016];
  return SingleChildScrollView(
    child: Column(
      children: batchYears.map((year) {
        final yearData = data.where((team) => team?.batchYear == year).toList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Batch of : $year",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            alumnilist(yearData),
          ],
        );
      }).toList(),
    ),
  );
}

Container alumnilist(List<Team?> data) {
  return Container(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0.0,
                shadowColor: Colors.red,
                color: Colors.transparent,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String uri =
                            ("${data[index]!.urlLinkedIn!.toString()}");
                        launchUrl(Uri.parse(uri),
                            mode: LaunchMode.externalApplication);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          "${data[index]!.image!.toString()}",
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/profile.png',
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${data[index]!.name!.toString()}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  var url1 =
                                      "${data[index]!.urlLinkedIn!.toString()}";
                                  if (await canLaunchUrlString(url1)) {
                                    await launchUrlString(url1);
                                  } else {
                                    throw 'Could not launch $url1';
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
