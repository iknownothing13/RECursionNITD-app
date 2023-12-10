import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:recursion/Presentation/Screens/AboutUsPage/notifications_card_class.dart';
import 'package:recursion/Presentation/Screens/AboutUsPage/upc_scroller_card_class.dart';
import 'package:url_launcher/url_launcher.dart';

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
      debugPrint('Error fetching data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 8, 8),
      appBar: AppBar(
        title: const Text('RECursion'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: FutureBuilder<AboutUs?>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //align the indicator to the center of the screen
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            print(data.mapUpcomingEvents?[0].eventType);
            List<upc_scroller_card_class> l = [];
            for (int i = 0; i < data.mapUpcomingEvents!.length; i++) {
              l.add(upc_scroller_card_class(
                image: data.mapUpcomingEvents![i].image,
                title: data.mapUpcomingEvents![i].title,
                description: data.mapUpcomingEvents![i].description,
                start_time: data.mapUpcomingEvents![i].startTime,
                end_time: data.mapUpcomingEvents![i].endTime,
                venue: data.mapUpcomingEvents![i].venue,
                link: data.mapUpcomingEvents![i].link,
                event_type: data.mapUpcomingEvents![i].eventType,
              ));
            }
            List<notifications_card_class> n = [
              notifications_card_class(
                  title: "Class Material",
                  description: "Material for Introduction to Graphs",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Event PDF",
                  description: "PDF for the ICPC Orientation 2023",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Class Material",
                  description: "Material for Introduction to Graphs",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Event PDF",
                  description: "PDF for the ICPC Orientation 2023",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Class Material",
                  description: "Material for Introduction to Graphs",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Event PDF",
                  description: "PDF for the ICPC Orientation 2023",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Class Material",
                  description: "Material for Introduction to Graphs",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Event PDF",
                  description: "PDF for the ICPC Orientation 2023",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
              notifications_card_class(
                  title: "Class Material",
                  description: "Material for Introduction to Graphs",
                  date: "07-10-2023",
                  link: "https://www.recursionnitd.in/"),
            ];
            // Build your UI using the 'data' variable
            // final aboutUs = snapshot.data!;
            return LiquidPullToRefresh(
              color: Colors.white,
              backgroundColor: Colors.black,

              onRefresh: () {
                setState(() {
                  _dataFuture = fetchData();
                });
                return _dataFuture; },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    top_sliding(l),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: const Icon(
                            Icons.circle_notifications_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    NotifiactionList(n),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ),
                    const Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text("About Us",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Expanded(child: Divider()),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 55, 58, 55),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: 250,
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 4),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.code,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  height: 1,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                                const Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'MISSION',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '\nWorking towards the improvement of in campus coding culture by organizing regular coding classes,coding contests and geeky sessions.',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 159, 170, 169),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        //end
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            )),
                        Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 55, 58, 55),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: 250,
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 4),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  height: 1,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                                const Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'VALUE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '\nWe believe that helping each other is the only way. We take care and always look to get the best out of everyone.',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 159, 170, 169),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        //end
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            )),
                        Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 55, 58, 55),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width / 3.2,
                            height: 250,
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 4),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                //straight white line
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  height: 1,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                                const Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'VISION',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '\nTo grow as a strong community in the world of coding, to make impact in various fields and uphold the integrity of NIT Durgapur as a technical institution.',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 159, 170, 169),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        //end
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                                //end
                              ],
                            )),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ),
                    const Row(children: <Widget>[
                      Expanded(child: Divider()),
                      Text("So far we have witnessed",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Expanded(child: Divider()),
                    ]),
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

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}

class top_sliding extends StatefulWidget {
  late List<upc_scroller_card_class> l;
  //use this list of urls for images....
  top_sliding(List<upc_scroller_card_class> l) {
    this.l = l;
  }

  @override
  _top_slidingState createState() => _top_slidingState(l);
}

class _top_slidingState extends State<top_sliding> {
  late List<upc_scroller_card_class> data;
  _top_slidingState(List<upc_scroller_card_class> l) {
    this.data = l;
  }
  int activePage = 0;
  late PageController _pageController;
  int active_view = 0;
  late PageController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activePage = index;
                    });
                  },
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                ),
                items: data.map((i) {
                  var btn_text = "";
                  if (i.event_type == "Class") {
                    btn_text = "CLASS DETAILS";
                  } else if (i.event_type == "Contest") {
                    btn_text = "CONTEST DETAILS";
                  } else {
                    btn_text = "EVENT DETAILS";
                  }
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                      image: Image.network(i.image!,
                                              fit: BoxFit.cover)
                                          .image),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${i.title}',
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${i.venue}',
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${i.start_time?.substring(0, 10)}',
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${i.end_time?.substring(0, 10)}',
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 32, 32, 32),
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        launchUrlStart(url: '${i.link}');
                                      },
                                      child: Text(btn_text),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        // child: Image.network(
                        //   i,
                        //   fit: BoxFit.cover,
                        // ),
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageIndicator(data.length, activePage),
              ),
            ])),
        //give straight white line
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
      ]),
    );
  }

  void launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

// Widget for showing image indicator
  List<Widget> imageIndicator(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.teal.shade400
              : const Color.fromARGB(66, 190, 176, 176),
          shape: BoxShape.circle,
        ),
      );
    });
  }
}

//top sliding 2

class NotifiactionList extends StatefulWidget {
  late List<notifications_card_class> l;
  NotifiactionList(List<notifications_card_class> l) {
    this.l = l;
  }

  @override
  _Notifiaction_listState createState() => _Notifiaction_listState(l);
}

class _Notifiaction_listState extends State<NotifiactionList> {
  late List<notifications_card_class> data;
  _Notifiaction_listState(List<notifications_card_class> data) {
    this.data = data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (int i = 0; i < data.length; i++)
            notification_card_widget(data[i]),
        ],
      ),
    );
  }
}

class notification_card_widget extends StatefulWidget {
  late notifications_card_class data;
  notification_card_widget(notifications_card_class data) {
    this.data = data;
  }
  @override
  _notification_card_widgetState createState() =>
      _notification_card_widgetState(data);
}

class _notification_card_widgetState extends State<notification_card_widget> {
  late notifications_card_class data;
  _notification_card_widgetState(notifications_card_class data) {
    this.data = data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 20, 20, 20),
      ),
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () {
                launchUrlStart(url: '${data.link}');
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${data.title}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${data.date}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${data.description}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }

  void launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
