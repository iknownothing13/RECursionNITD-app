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
  late double height;
  late double width;
  late final FetchDataUseCaseEvent fetchDataUseCase2;

  // Updated minimalist color scheme with black, white and green
  final Color primaryColor = Colors.black;
  final Color accentColor = Color(0xFF00C853); // Material Green
  final Color backgroundLight = Colors.white;
  final Color textDark = Colors.black87;
  final Color cardShadow = Colors.black12;

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
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: FutureBuilder<List<Results?>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SimpleCircularProgressBar(
                progressColors: [accentColor],
                backColor: Colors.white24,
                size: 60,
                fullProgressColor: accentColor,
                animationDuration: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final classesData =
                data.where((event) => event?.eventType == 'Class').toList();
            final eventsData =
                data.where((event) => event?.eventType == 'Event').toList();
            final contestData =
                data.where((event) => event?.eventType == 'Contest').toList();

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildHeader(),
                  Container(
                    decoration: BoxDecoration(
                      color: backgroundLight,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        _buildContent(
                            classesData, eventsData, contestData, width),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'No data available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: height * 0.25,
      padding: EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'images/REC_logo.png',
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(width: 16),
              Text(
                "RECursion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "Programming Community of\nNIT Durgapur",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<Results?> classesData, List<Results?> eventsData,
      List<Results?> contestData, double width) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          if (classesData.isNotEmpty)
            _buildSection(
                "Classes",
                classesData,
                width,
                () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ClassesPage(eventsData: classesData)))),
          SizedBox(height: 24),
          if (eventsData.isNotEmpty)
            _buildSection(
                "Events",
                eventsData,
                width,
                () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            EventsPage(eventsData: eventsData)))),
          SizedBox(height: 24),
          if (contestData.isNotEmpty)
            _buildSection(
                "Contests",
                contestData,
                width,
                () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            ContestPage(eventsData: contestData)))),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title, List<Results?> data, double width, VoidCallback onViewAll) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textDark,
                letterSpacing: 0.5,
              ),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 16,
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: accentColor, size: 20),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildGrid(data),
      ],
    );
  }

  Widget _buildGrid(List<Results?> data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length > 4 ? 4 : data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: cardShadow,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '${item?.image}',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      '${item?.title}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${item?.venue}',
                      style: TextStyle(
                        fontSize: 14,
                        color: textDark.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${item?.targetYear}',
                      style: TextStyle(
                        fontSize: 14,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
