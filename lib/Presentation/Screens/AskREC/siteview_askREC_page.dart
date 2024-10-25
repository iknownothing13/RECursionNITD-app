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
  bool canGoBack = false;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            updateCanGoBack();
          },
          onPageFinished: (String url) {
            updateCanGoBack();
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://recursionnitd.in/forum/'));
  }

  Future<void> updateCanGoBack() async {
    final canGoBack = await _webViewController.canGoBack();
    setState(() {
      this.canGoBack = canGoBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // Add AppBar with back button
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            if (await _webViewController.canGoBack()) {
              _webViewController.goBack();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        // Add some padding around the title
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Forum',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        // Add padding around the WebView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              // Add a linear progress indicator
              StreamBuilder<double>(
                stream: Stream.empty(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data! < 1.0) {
                    return LinearProgressIndicator(
                      value: snapshot.data,
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              // WebView takes remaining space
              Expanded(
                child: WebViewWidget(
                  controller: _webViewController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
