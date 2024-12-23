import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Domain/Model/subtopic_detail_model.dart';

class SubtopicDetailPage extends StatefulWidget {
  final int subtopic;

  SubtopicDetailPage({super.key, required this.subtopic});

  @override
  State<SubtopicDetailPage> createState() => _SubtopicDetailPageState();
}

Future<SubtopicDetailModel> fetchData(int subtopic) async {
  final Uri uri = Uri.parse(
      'https://recnitdgp.pythonanywhere.com/api/getting_started/$subtopic');
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    String cacheKey = 'gettingstarted_data_$subtopic';
    String? cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      return SubtopicDetailModel.fromJson(json.decode(cachedData));
    }

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = response.body;
      prefs.setString(cacheKey, jsonData);
      return SubtopicDetailModel.fromJson(json.decode(jsonData));
    } else {
      throw ApiError(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw ApiError('Error processing data: $e');
  }
}

class _SubtopicDetailPageState extends State<SubtopicDetailPage> {
  late Future<SubtopicDetailModel> _dataFuture;

  final Color primaryColor = Colors.black;
  final Color accentColor = Color(0xFF00C853);
  final Color backgroundLight = Colors.white;
  final Color textDark = Colors.black87;
  final Color cardShadow = Colors.black12;
  final Color codeBg = Color(0xFFF5F5F5);
  final Color linkColor = Color(0xFF1976D2);

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData(widget.subtopic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        title: Text(
          'Subtopic Details',
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: backgroundLight,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: cardShadow,
            height: 1.0,
          ),
        ),
      ),
      body: FutureBuilder<SubtopicDetailModel>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading content...',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 56, color: Colors.red[400]),
                    SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textDark.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _dataFuture = fetchData(widget.subtopic);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: backgroundLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.subTopic != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        border: Border(
                          bottom: BorderSide(color: cardShadow, width: 1),
                        ),
                      ),
                      child: Text(
                        data.subTopic!,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Notes Section
                        if (data.note != null && data.note!.isNotEmpty) ...[
                          Row(
                            children: [
                              Icon(Icons.notes, color: accentColor, size: 24),
                              SizedBox(width: 8),
                              Text(
                                'Notes',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          ...data.note!.map((note) => Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: backgroundLight,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cardShadow.withOpacity(0.1),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (note.notesTopic != null)
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: accentColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Text(
                                          note.notesTopic!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (note.description != null)
                                            Text(
                                              note.description!,
                                              style: TextStyle(
                                                color: textDark,
                                                fontSize: 16,
                                                height: 1.5,
                                              ),
                                            ),
                                          if (note.codeSnippet != null) ...[
                                            SizedBox(height: 16),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: codeBg,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: cardShadow,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                note.codeSnippet!,
                                                style: TextStyle(
                                                  fontFamily: 'monospace',
                                                  fontSize: 14,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],

                        // Files Section
                        if (data.file != null && data.file!.isNotEmpty) ...[
                          SizedBox(height: 32),
                          Row(
                            children: [
                              Icon(Icons.folder_open,
                                  color: accentColor, size: 24),
                              SizedBox(width: 8),
                              Text(
                                'Files',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          ...data.file!.map((file) => Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: backgroundLight,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cardShadow.withOpacity(0.1),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (file.heading != null)
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: accentColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Text(
                                          file.heading!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                          ),
                                        ),
                                      ),
                                    if (file.link != null)
                                      ...file.link!.map((link) => Column(
                                            children: [
                                              if (link.link1 != null &&
                                                  link.urlLink1 != null)
                                                _buildLinkTile(link.link1!,
                                                    link.urlLink1!),
                                              if (link.link2 != null &&
                                                  link.urlLink2 != null)
                                                _buildLinkTile(link.link2!,
                                                    link.urlLink2!),
                                              if (link.link3 != null &&
                                                  link.urlLink3 != null)
                                                _buildLinkTile(link.link3!,
                                                    link.urlLink3!),
                                              if (link.link4 != null &&
                                                  link.urlLink4 != null)
                                                _buildLinkTile(link.link4!,
                                                    link.urlLink4!),
                                            ],
                                          )),
                                  ],
                                ),
                              )),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline,
                      size: 56, color: textDark.withOpacity(0.5)),
                  SizedBox(height: 16),
                  Text(
                    'No content available',
                    style: TextStyle(
                      color: textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLinkTile(String title, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: cardShadow, width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.link, color: linkColor, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: linkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.open_in_new,
                color: linkColor.withOpacity(0.5), size: 18),
          ],
        ),
      ),
    );
  }
}

class ApiError implements Exception {
  final String message;
  ApiError(this.message);

  @override
  String toString() => message;
}
