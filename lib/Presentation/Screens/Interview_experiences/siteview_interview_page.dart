import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SiteviewInterviewPage extends StatefulWidget {
  const SiteviewInterviewPage({super.key});

  @override
  State<SiteviewInterviewPage> createState() => _SiteviewInterviewPageState();
}

class _SiteviewInterviewPageState extends State<SiteviewInterviewPage> {
  late double height, width;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  CircularProgressIndicator();
                },
              ),
            )
            ..loadRequest(Uri.parse(
                'https://www.recursionnitd.in/login/?next=/experience/')),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
