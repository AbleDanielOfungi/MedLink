import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('EngProfile');
  final picker = ImagePicker();

  User? _user;
  File? _image;
  String _name = '';
  String _location = '';
  String _gender = '';
  String _occupation = '';
  String _contact = '';
  String _experience = '';

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      final userData = await _userCollection.doc(_user!.uid).get();
      if (userData.exists) {
        final data = userData.data() as Map<String, dynamic>;
        setState(() {
          _name = data['name'] ?? '';
          _location = data['location'] ?? '';
          _gender = data['gender'] ?? '';
          _occupation = data['occupation'] ?? '';
          _contact = data['contact'] ?? '';
          _experience = data['experience'] ?? '';
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    try {
      await _userCollection.doc(_user!.uid).set({
        'name': _name,
        'location': _location,
        'gender': _gender,
        'occupation': _occupation,
        'contact': _contact,
        'experience': _experience,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      print('Error saving user data: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error updating profile')));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : _user?.photoURL != null
                        ? NetworkImage(_user!.photoURL!) as ImageProvider
                        : null,
                child: _image == null && _user?.photoURL == null
                    ? const Icon(Icons.camera_alt, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            TextFormField(
              initialValue: _location,
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            TextFormField(
              initialValue: _gender,
              decoration: const InputDecoration(labelText: 'Gender'),
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            TextFormField(
              initialValue: _occupation,
              decoration: const InputDecoration(labelText: 'Occupation'),
              onChanged: (value) {
                setState(() {
                  _occupation = value;
                });
              },
            ),
            TextFormField(
              initialValue: _contact,
              decoration: const InputDecoration(labelText: 'Contact'),
              onChanged: (value) {
                setState(() {
                  _contact = value;
                });
              },
            ),
            TextFormField(
              initialValue: _experience,
              decoration: const InputDecoration(labelText: 'Years of Experience'),
              onChanged: (value) {
                setState(() {
                  _experience = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _saveUserData();
                // Upload the image to Firebase Storage here if _image is not null.
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 20.0),
            // Display User Profile Details
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              backgroundImage: _user?.photoURL != null
                  ? NetworkImage(_user!.photoURL!)
                  : null,
            ),
            const SizedBox(height: 10.0),
            Text('Email: ${_user?.email ?? 'N/A'}'), // Display user's email
            Text('Name: $_name'),
            Text('Location: $_location'),
            Text('Gender: $_gender'),
            Text('Occupation: $_occupation'),
            Text('Contact: $_contact'),
            Text('Years of Experience: $_experience'),
          ],
        ),
      ),
    );
  }
}
