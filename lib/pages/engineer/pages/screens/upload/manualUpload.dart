import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jonah/pages/engineer/pages/screens/upload/display_manual.dart';
import 'package:uuid/uuid.dart';

class UploadManualScreen extends StatefulWidget {
  @override
  _UploadManualScreenState createState() => _UploadManualScreenState();
}

class _UploadManualScreenState extends State<UploadManualScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _selectedFile;
  String _title = '';
  String _description = '';

  Future<void> _uploadManual() async {
    if (_selectedFile != null) {
      // Generate a unique filename for the manual using the UUID package
      final fileName = 'user_manual_${Uuid().v4()}.pdf';
      final Reference storageReference =
          _storage.ref().child('user_manuals/$fileName');

      final UploadTask uploadTask = storageReference.putFile(_selectedFile!);

      await uploadTask.whenComplete(() async {
        final manualUrl = await storageReference.getDownloadURL();
        // Save the manual data to your database (e.g., Firestore).
        FirebaseFirestore.instance.collection('manuals').add({
          'title': _title,
          'description': _description,
          'manualUrl': manualUrl,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Manual uploaded successfully.'),
        ));
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload User Manual'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Select Manual PDF'),
            ),
            if (_selectedFile != null)
              Text('Selected File: ${_selectedFile!.path}'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadManual,
              child: Text('Upload Manual'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserManualListScreen();
          }));
        },
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'View Manuals',
              style: TextStyle(color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
