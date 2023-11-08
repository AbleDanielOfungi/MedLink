import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Use pickImage instead of getImage
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


  Future<void> saveData() async {
    if (_image != null) {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('engineer_images/${DateTime.now().toString()}');
      final UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() async {
        final imageUrl = await storageReference.getDownloadURL();
        await FirebaseFirestore.instance.collection('Eng Profile').add({
          'name': nameController.text,
          'location': locationController.text,
          'contact': contactController.text,
          'gender': genderController.text,
          'experience': experienceController.text,
          'image_url': imageUrl,
        });
        // Optionally, you can show a success message or navigate to another screen.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              _image != null
                  ? Image.file(
                _image!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
                  : Container(),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Pick Image'),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
              ),
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                controller: experienceController,
                decoration: const InputDecoration(labelText: 'Experience'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: saveData,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
