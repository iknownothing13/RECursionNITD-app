import 'package:flutter/material.dart';
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
      print('Error fetching data: $e');
      return null;
    }
  }
  Future<void> _launchUrl({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RECursion'),
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
            // Build your UI using the 'data' variable
            // final aboutUs = snapshot.data!;
            return ListView(
              children: [
                ListTile(
                  title: Text('Years of Experience: ${data.yearsOfExperience ?? 'N/A'}'),
                  trailing: Text('Contest Count: ${data.contestCount ?? 'N/A'}'),
                  subtitle: Text('Hours Teaching: ${data.hoursTeaching ?? 'N/A'}'),
                ),
                //give a straigh line
                const Divider(),
                const Padding(padding: EdgeInsets.all(10.0),child: Text('UPCOMING CLASS'),),
                const ListTile(
                  title: Text('Introduction to Graphs'),//data.upcomingClass?.title ?? 'N/A'),
                  subtitle: Text('LG - 12'),//data.upcomingClass?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),//data.upcomingClass?.time ?? 'N/A'),
                ),
                const Divider(),
                const Padding(padding: EdgeInsets.all(10.0),child: Text('UPCOMING CONSTESTS'),),
                const Divider(),
                const ListTile(
                  title: Text('Beginner Contest UDIOS'),//data.upcomingContest?.title ?? 'N/A'),
                  subtitle: Text('Atcoder'),//data.upcomingContest?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),//data.upcomingContest?.time ?? 'N/A'),
                ),
                const Divider(),
                const Padding(padding: EdgeInsets.all(10.0),child: Text('Notifications'),),
                const Divider(),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                ListTile(
                  title: Text('The new Material for previous class is added'),//data.notifications?.title ?? 'N/A'),
                  subtitle: Text('Tap to view the material'),//data.notifications?.location ?? 'N/A'),
                  trailing: Text(' 30-02-2003\n18:00 - 20:00'),
                  onTap: () async{
                    launchUrlStart(url: 'https://www.recursionnitd.in/');
                    },//data.notifications?.time ?? 'N/A'),
                ),
                
              ]
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
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}