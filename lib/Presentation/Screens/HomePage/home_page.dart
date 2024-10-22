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
      print('Error fetching data: $e');
      return null;
    }
  }

  List<dynamic> titles = [
    "Get Started",
    "Interview Experiences",
    "AskREC",
    "Blog"
  ];
  List<dynamic> imgData = [
    "images/getStarted.png",
    "images/interview.png",
    "images/askREC.png",
    "images/blog.png",
  ];
  List<Widget> routes = [
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
      backgroundColor: Colors.black,
      body: FutureBuilder<AboutUs?>(
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
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Colors.black,
                width: width,
                child: Column(
                  children: [
                    _buildHeader(),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          _buildSectionTitle('Quick Access',
                              fontSize: 25, fontWeight: FontWeight.w500),
                          SizedBox(height: 20),
                          _buildQuickAccess(),
                          SizedBox(height: 10),
                          _buildDivider(),
                          SizedBox(height: 15),
                          _buildSectionTitle('Who We Are ?',
                              fontSize: 25, fontWeight: FontWeight.w500),
                          SizedBox(height: 10),
                          _buildWhoWeAreDescription(),
                          SizedBox(height: 20),
                          _buildDivider(),
                          SizedBox(height: 10),
                          _buildSectionTitle('So far we have witnessed',
                              fontSize: 25, fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10,
                          ),
                          _buildWitnessPart(data.contestCount,
                              data.hoursTeaching, data.yearsOfExperience),
                          SizedBox(height: 20),
                          _buildDivider(),
                          SizedBox(height: 10),
                          _buildSectionTitle('Contacts',
                              fontSize: 25, fontWeight: FontWeight.w500),
                          SizedBox(
                            height: 10,
                          ),
                          _buildContactsSection(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildDivider(),
                        ],
                      ),
                    ),
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

  Widget _buildHeader() {
    return Container(
      height: height * 0.23,
      width: width,
      padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'images/REC_logo.png',
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "RECursion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  // Handle account icon press
                },
                icon: Icon(Icons.account_circle_outlined,
                    color: Colors.white, size: 30),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Programming Community of NIT Durgapur",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title,
      {double fontSize = 18, FontWeight fontWeight = FontWeight.normal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    return GridView.builder(
      itemCount: titles.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => routes[index]));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black54, spreadRadius: 1, blurRadius: 6),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imgData[index],
                  width: 65,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    titles[index],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Color.fromARGB(255, 173, 177, 202),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Text(
          'We are programming community of NIT Durgapur, with focus on improving coding culture institute wide by conducting regular lectures from beginner to advance topics of programming. Our goal is to increase students participation in inter-collegiate contest like ACM-ICPC and help them get better.',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 5,
      decoration: BoxDecoration(color: Colors.black),
    );
  }

  Widget _buildWitnessPart(
    int? contestCount,
    int? hoursTeaching,
    int? yearsOfExperience,
  ) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  ClipRect(
                    child: Image.asset(
                      "images/bulb.png",
                      height: 55,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "$yearsOfExperience+ years of\nExperience",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  ClipRect(
                    child: Image.asset(
                      "images/code.png",
                      height: 50,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text.rich(
                    TextSpan(
                      text: "$contestCount+ Online / Offline\nContests",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Center(
            child: Column(
              children: [
                ClipRect(
                  child: Image.asset(
                    "images/class.png",
                    height: 50,
                  ),
                ),
                SizedBox(height: 8.0),
                Text.rich(
                  TextSpan(
                    text: "$hoursTeaching+ hours of Teaching",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.map_outlined, color: Colors.blue),
            title:
                Text("Address:", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("NIT Durgapur, Durgapur, W.B."),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email_outlined, color: Colors.blue),
            title:
                Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("recursion.nit@gmail.com"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.call_outlined, color: Colors.blue),
            title:
                Text("Phones:", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Ankit Maskara: +918420998766"),
          ),
        ],
      ),
    );
  }
}
