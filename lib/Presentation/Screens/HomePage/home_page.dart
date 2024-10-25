import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recursion/Application/api_interaction/about_us_api_use_case.dart';
import 'package:recursion/Domain/Model/about_us_model.dart';
import 'package:recursion/Presentation/Screens/AskREC/siteview_askREC_page.dart';
import 'package:recursion/Presentation/Screens/Blog/siteview_blog_page.dart';
import 'package:recursion/Presentation/Screens/GetStarted/siteview_getStarted_page.dart';
import 'package:recursion/Presentation/Screens/Interview_experiences/siteview_interview_page.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class Homepage extends StatefulWidget {
  final FetchDataUseCase fetchDataUseCase;

  Homepage({super.key, required this.fetchDataUseCase});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late double height;
  late double width;
  late Future<AboutUs?> _dataFuture;

  // New minimalist color scheme
  final Color primaryColor = Colors.black;
  final Color accentColor = const Color(0xFF00BD6D); // Green
  final Color backgroundLight = Colors.white;
  final Color textDark = Colors.black;
  final Color cardShadow = Colors.black.withOpacity(0.1);

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  Future<AboutUs?> fetchData() async {
    try {
      return await widget.fetchDataUseCase.execute();
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  final List<dynamic> titles = [
    "Get Started",
    "Interview Experiences",
    "AskREC",
    "Blog"
  ];

  final List<dynamic> imgData = [
    "images/getStarted.png",
    "images/interview.png",
    "images/askREC.png",
    "images/blog.png",
  ];

  final List<Widget> routes = [
    SiteviewGetstartedPage(),
    SiteviewInterviewPage(),
    SiteViewAskRECPage(),
    SiteviewBlogPage(),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: FutureBuilder<AboutUs?>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SimpleCircularProgressBar(
                progressColors: [accentColor],
                backColor: Colors.white.withOpacity(0.2),
                size: 60,
                fullProgressColor: accentColor,
                animationDuration: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: backgroundLight),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
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
                        _buildSectionTitle('Quick Access'),
                        _buildQuickAccess(),
                        _buildSectionDivider(),
                        _buildSectionTitle('Who We Are?'),
                        _buildWhoWeAreDescription(),
                        _buildSectionDivider(),
                        _buildSectionTitle('Our Impact'),
                        _buildWitnessPart(data.contestCount, data.hoursTeaching,
                            data.yearsOfExperience),
                        _buildSectionDivider(),
                        _buildSectionTitle('Contact Us'),
                        _buildContactsSection(),
                        SizedBox(height: 32),
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
                style: TextStyle(color: backgroundLight),
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
                  color: backgroundLight,
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
                  color: backgroundLight,
                  size: 32,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "Programming Community of\nNIT Durgapur",
            style: TextStyle(
              color: backgroundLight,
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textDark,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: titles.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => routes[index]),
            );
          },
          child: Container(
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
                Image.asset(
                  imgData[index],
                  width: 56,
                  height: 56,
                ),
                SizedBox(height: 12),
                Text(
                  titles[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWhoWeAreDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: accentColor.withOpacity(0.1),
        border: Border.all(color: accentColor),
      ),
      child: Text(
        'We are programming community of NIT Durgapur, with focus on improving coding culture institute wide by conducting regular lectures from beginner to advance topics of programming. Our goal is to increase students participation in inter-collegiate contest like ACM-ICPC and help them get better.',
        style: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSectionDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        color: primaryColor.withOpacity(0.1),
      ),
    );
  }

  Widget _buildWitnessPart(
    int? contestCount,
    int? hoursTeaching,
    int? yearsOfExperience,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: EdgeInsets.all(24),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatisticItem(
                "images/bulb.png",
                "$yearsOfExperience+",
                "years of\nExperience",
              ),
              _buildStatisticItem(
                "images/code.png",
                "$contestCount+",
                "Online/Offline\nContests",
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildStatisticItem(
            "images/class.png",
            "$hoursTeaching+",
            "hours of Teaching",
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticItem(String imagePath, String value, String label) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 48,
          width: 48,
        ),
        SizedBox(height: 12),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: value + "\n",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              TextSpan(
                text: label,
                style: TextStyle(
                  fontSize: 14,
                  color: textDark.withOpacity(0.8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
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
        children: [
          _buildContactItem(
            Icons.map_outlined,
            "Address",
            "NIT Durgapur, Durgapur, W.B.",
          ),
          Divider(height: 1),
          _buildContactItem(
            Icons.email_outlined,
            "Email",
            "recursion.nit@gmail.com",
          ),
          Divider(height: 1),
          _buildContactItem(
            Icons.call_outlined,
            "Phone",
            "Ankit Maskara: +918420998766",
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: textDark.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
