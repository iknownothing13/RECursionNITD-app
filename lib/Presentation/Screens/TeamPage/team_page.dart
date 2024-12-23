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
  _TeamPageScreenState createState() => _TeamPageScreenState();
}

class _TeamPageScreenState extends State<TeamPageScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Team?>> _dataFuture;
  late TabController _tabController;

  // Enhanced color scheme
  final Color primaryColor = Color(0xFF1A237E); // Deep Indigo
  final Color accentColor = Color(0xFF4CAF50); // Material Green
  final Color backgroundLight = Colors.white;
  final Color cardBackground = Color(0xFFF5F5F5);
  final Color textDark = Colors.black87;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _dataFuture = fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Team?>> fetchData() async {
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
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: backgroundLight,
        body: SafeArea(
          child: FutureBuilder<List<Team?>>(
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

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our Team',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: cardBackground,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: textDark,
                              padding: EdgeInsets.all(4),
                              tabs: [
                                Tab(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text('Alumni'),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('2024'),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('2025'),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('2026'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AlumniList(dataAlumni),
                          EnhancedTeamList(data24),
                          EnhancedTeamList(data25),
                          EnhancedTeamList(data26),
                        ],
                      ),
                    ),
                  ],
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
      ),
    );
  }
}

Widget EnhancedTeamList(List<Team?> data) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  String uri = data[index]!.urlLinkedIn!.toString();
                  launchUrl(Uri.parse(uri),
                      mode: LaunchMode.externalApplication);
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            "${data[index]!.image!}",
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
                      SizedBox(height: 16),
                      Text(
                        "${data[index]!.name!}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

Widget AlumniList(List<Team?> data) {
  final List<int> batchYears = [2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016];

  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: batchYears.map((year) {
          final yearData =
              data.where((team) => team?.batchYear == year).toList();
          if (yearData.isEmpty) return SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Class of $year",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: yearData.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () async {
                          String uri = yearData[index]!.urlLinkedIn!.toString();
                          launchUrl(Uri.parse(uri),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  "${yearData[index]!.image!}",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'images/profile.png',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${yearData[index]!.name!}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
    ),
  );
}
