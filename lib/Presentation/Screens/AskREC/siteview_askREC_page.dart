import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SiteViewAskRECPage extends StatefulWidget {
  const SiteViewAskRECPage({super.key});

  @override
  State<SiteViewAskRECPage> createState() => _SiteViewAskRECPageState();
}

class _SiteViewAskRECPageState extends State<SiteViewAskRECPage> {
  late double height, width;
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 45),
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
            ..loadRequest(Uri.parse('https://www.recursionnitd.in/forum/')),
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
