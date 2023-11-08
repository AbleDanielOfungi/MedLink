// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sukali_care/users/patient/pages/wall/components/text_box.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   final currentUser=FirebaseAuth.instance.currentUser!;
//
//   Future<void> editField(String field)async{
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         centerTitle: true,
//         backgroundColor: Colors.grey.shade300,
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance.collection('Users').doc(currentUser.email).snapshots(),
//         builder: (context, snapshot){
//           //get user data
//           if(snapshot.hasData){
//             final userData=snapshot.data!.data() as Map<String, dynamic>;
//             return ListView(
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 Column(
//
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //profile pic
//                     Center(
//                       child: Icon(Icons.person,
//                         size: 75,),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//
//                     //email
//                     Center(child: Text("Email: ${currentUser.email!}")),
//
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 25.0),
//                       child: Text('My Details',
//                         style: TextStyle(
//                             color: Colors.grey.shade600
//                         ),),
//                     ),
//
//                     //username
//                     TextBox(
//                       text: userData['name'],
//                       sectionName: userData['bio'],
//                       // onPressed:()=>editField('UserName') ,
//                     ),
//
//                     //edit bio
//                     TextBox(
//                       text: 'Empty bio',
//                       sectionName: 'bio',
//                       // onPressed:()=>editField('bio') ,
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.only(left: 25.0),
//                       child: Text('My Posts',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),),
//                     ),
//
//                 ],
//                 )
//               ],
//             );
//           }
//           else if(snapshot.hasError){
//             return Center(
//               child: Text('Error:' +snapshot.hasError.toString()),
//             );
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       )
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final currentUser=FirebaseAuth.instance.currentUser!;

  User? _user;
  String _displayName = '';
  String _email = '';
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      DocumentSnapshot userData =
      await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _displayName = userData['displayName'];
        _email = _user!.email ?? '';
        _profileImage = null; // Reset profile image to trigger reload
      });
    }
  }

  Future<void> _updateProfileData(String newDisplayName) async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).update({
        'displayName': newDisplayName,
      });

      setState(() {
        _displayName = newDisplayName;
      });
    }
  }

  Future<void> _updateProfilePicture(File newImage) async {
    if (_user != null) {
      Reference storageReference =
      _storage.ref().child('profile_images/${_user!.uid}.jpg');

      UploadTask uploadTask = storageReference.putFile(newImage);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await _firestore.collection('users').doc(_user!.uid).update({
        'profileImage': imageUrl,
      });

      setState(() {
        _profileImage = newImage;
      });
    }
  }

  Future<void> _selectImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File pickedFile = File(pickedImage.path);
      await _updateProfilePicture(pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          children: [
            const SizedBox(
              height: 50,
            ),

            GestureDetector(
                onTap: _selectImage,
                child:CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : _user?.photoURL != null
                      ? NetworkImage(_user!.photoURL!) as ImageProvider<Object>?
                      : const AssetImage('assets/default_profile_image.png'),
                )


            ),
            const SizedBox(height: 20),
            Text('Display Name: $_displayName',
              style: GoogleFonts.roboto(

              ),),
            const SizedBox(height: 10),
            Text("Email: ${currentUser.email!}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String newName = '';
                    return AlertDialog(
                      title: const Text('Update Display Name'),
                      content: TextField(
                        onChanged: (value) {
                          newName = value;
                        },
                        decoration: const InputDecoration(hintText: 'New Display Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (newName.isNotEmpty) {
                              await _updateProfileData(newName);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Update Display Name'),
            ),
          ],
        ),
      ),
    );
  }
}
