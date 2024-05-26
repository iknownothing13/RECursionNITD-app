import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:recursion/Presentation/Screens/AskREC/askREC.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:transition/transition.dart';
import 'package:flutter/gestures.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List titles = ["Get Started", "Interview Experiences", "AskREC", "Blog"];
  List imgData = [
    "images/getStarted.png",
    "images/interview.png",
    "images/askREC.png",
    "images/blog.png",
  ];
  List routes = [
    Container(),
    AskREC(),
    AskREC(),
    Container(),
  ];
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(218, 222, 241, 1),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          // height: height,
          width: width,
          child: Column(
            children: [
              Container(
                height: height * 0.23,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15, top: 20, right: 5),
                          child: ClipRRect(
                            child: Image.asset(
                              'images/REC_logo.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 140, left: 5, top: 20),
                          child: Text(
                            "RECursion",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 10),
                          child: Icon(
                            //Icons.notifications_outlined,
                            Icons.six_mp_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
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
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  //height: height * 0.75,
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Quick Access',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      quick2(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 5,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      const Text.rich(
                        TextSpan(
                          text: 'Who We Are ?',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color.fromARGB(255, 173, 177, 202),
                        ),
                        margin: EdgeInsets.only(
                          right: 20,
                          left: 20,
                          top: 10,
                        ),
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 5,
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // CarouselSlider(
          //   items: [
          //     Slide_Section(img: 'images/1.png'),
          //     Slide_Section(img: 'images/2.png'),
          //     Slide_Section(img: 'images/3.png'),
          //     Slide_Section(img: 'images/4.png'),
          //     Slide_Section(img: 'images/5.png'),
          //   ],
          //   options: CarouselOptions(
          //     height: 250,
          //     autoPlay: true,
          //     enlargeCenterPage: true,
          //     enlargeStrategy: CenterPageEnlargeStrategy.height,
          //   ),
          // ),
        ),
      ),
    );
  }

  Container quick2() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      // height: height * 0.75,
      width: width,
      padding: EdgeInsets.only(bottom: 8),
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                Transition(
                    child: routes[index],
                    transitionEffect: TransitionEffect.FADE),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54, spreadRadius: 1, blurRadius: 6)
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
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      titles[index],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
//   Padding quick_access() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
//       child: Column(
//         children: [
//           GridView.builder(
//             itemCount: icon.length,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, childAspectRatio: 1.1),
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       routes[index];
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           color: catColor[index], shape: BoxShape.circle),
//                       child: Center(
//                         child: icon[index],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     names[index],
//                     style: const TextStyle(fontSize: 10),
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Slide_Section extends StatelessWidget {
//   Slide_Section({super.key, required this.img});
//   final String img;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.only(right: 15, left: 15, top: 3),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Image.asset(
//             img,
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     );
//   }
// }
