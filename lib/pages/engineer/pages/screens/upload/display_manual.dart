import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class UserManualListScreen extends StatefulWidget {
  @override
  _UserManualListScreenState createState() => _UserManualListScreenState();
}

class _UserManualListScreenState extends State<UserManualListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserManual> _manuals = [];

  @override
  void initState() {
    super.initState();
    _loadUserManuals();
  }

  void _loadUserManuals() async {
    final manualsSnapshot = await _firestore.collection('manuals').get();
    final manuals = manualsSnapshot.docs
        .map((doc) => UserManual.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    setState(() {
      _manuals = manuals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manuals'),
      ),
      body: ListView.builder(
        itemCount: _manuals.length,
        itemBuilder: (context, index) {
          final manual = _manuals[index];
          return ListTile(
            leading: GestureDetector(
                onTap: () {
                  //displaying pdf
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserManualViewerScreen(
                        manualUrl: manual.manualUrl,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.library_books_rounded)),
            title: Text(manual.title),
            subtitle: GestureDetector(
                onTap: () {
                  //displaying pdf
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserManualViewerScreen(
                        manualUrl: manual.manualUrl,
                      ),
                    ),
                  );
                },
                child: Text(manual.description)),
            trailing: GestureDetector(
                onTap: () async {
                  final url = manual.manualUrl;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Could not open the PDF.'),
                    ));
                  }
                },
                child: Icon(Icons.file_download)),
          );
        },
      ),
    );
  }
}

class UserManual {
  final String title;
  final String description;
  final String manualUrl;

  UserManual({
    required this.title,
    required this.description,
    required this.manualUrl,
  });

  factory UserManual.fromMap(Map<String, dynamic> map) {
    return UserManual(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      manualUrl: map['manualUrl'] ?? '',
    );
  }
}

//display user manuals

class UserManualViewerScreen extends StatelessWidget {
  final String manualUrl;

  UserManualViewerScreen({required this.manualUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manual'),
      ),
      body: PDFView(
        filePath: manualUrl, // Provide the URL of the PDF file here
      ),
    );
  }
}
