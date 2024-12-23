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

  // Enhanced color scheme
  final Color primaryColor = Color(0xFF1A237E); // Deep Indigo
  final Color accentColor = Color(0xFF4CAF50); // Material Green
  final Color backgroundLight = Colors.white;
  final Color cardBackground = Color(0xFFF5F5F5);
  final Color textDark = Colors.black87;

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
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: FutureBuilder<List<Results?>>(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red),
                    SizedBox(height: 16),
                    Text('Error loading data',
                        style: TextStyle(color: textDark, fontSize: 16)),
                  ],
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
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Events & Activities',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 24),
                      _buildEventSections(classesData, eventsData, contestData),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text('No data available.',
                    style: TextStyle(color: textDark)),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildEventSections(List<Results?> classesData,
      List<Results?> eventsData, List<Results?> contestData) {
    return Column(
      children: [
        if (classesData.isNotEmpty) ...[
          _buildSection(
            "Classes",
            "Upcoming learning sessions",
            classesData,
            () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ClassesPage(eventsData: classesData)),
            ),
          ),
          SizedBox(height: 32),
        ],
        if (eventsData.isNotEmpty) ...[
          _buildSection(
            "Events",
            "Latest activities and meetups",
            eventsData,
            () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => EventsPage(eventsData: eventsData)),
            ),
          ),
          SizedBox(height: 32),
        ],
        if (contestData.isNotEmpty)
          _buildSection(
            "Contests",
            "Test your skills",
            contestData,
            () => Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => ContestPage(eventsData: contestData)),
            ),
          ),
      ],
    );
  }

  Widget _buildSection(String title, String subtitle, List<Results?> data,
      VoidCallback onViewAll) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: textDark.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onViewAll,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, color: accentColor, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildEventGrid(data),
      ],
    );
  }

  Widget _buildEventGrid(List<Results?> data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                // Handle event tap
              },
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            '${item?.image}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                width: 100,
                                color: cardBackground,
                                child: Icon(Icons.event,
                                    color: textDark.withOpacity(0.5)),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${item?.title}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${item?.venue}',
                      style: TextStyle(
                        fontSize: 14,
                        color: textDark.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${item?.targetYear}',
                        style: TextStyle(
                          fontSize: 12,
                          color: accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
