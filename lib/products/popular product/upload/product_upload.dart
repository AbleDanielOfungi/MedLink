import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddPopularProductScreen extends StatefulWidget {
  const AddPopularProductScreen({super.key});

  @override
  _AddPopularProductScreenState createState() => _AddPopularProductScreenState();
}

class _AddPopularProductScreenState extends State<AddPopularProductScreen> {
  final _picker = ImagePicker();

  // Product model
  XFile? _image;
  String _selectedCategory = 'Storage';
  String _productName = '';
  double _productPrice = 0.0;
  String _productDetails = '';
  String _productQuantity = ''; // Changed from _productRating to _productQuantity

  final _formkey = GlobalKey<FormState>();

  Future<void> pickImage() async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> uploadImage() async {
    if (_image != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('$_selectedCategory/${DateTime.now()}.png');
      UploadTask uploadTask = storageRef.putFile(File(_image!.path));

      await uploadTask.whenComplete(() async {
        try {
          // Getting the download URL for the uploaded image
          String imageURL = await storageRef.getDownloadURL();

          // Creating a new document in Firestore
          FirebaseFirestore.instance.collection('products').add({
            'name': _productName,
            'price': _productPrice,
            'details': _productDetails,
            'quantity': _productQuantity, // Updated to quantity
            'imageURL': imageURL,
            'category': _selectedCategory,
          });

          print('Image uploaded with details');

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: const Text('Image uploaded with details'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.done),
                  ),
                ],
              );
            },
          );
        } catch (error) {
          // Handle Firebase Firestore error
          _showFailureDialog('Firestore error: $error');
        }
      }).catchError((error) {
        // Handle Firebase Storage error
        _showFailureDialog('Storage error: $error');
      });
    } else {
      _showFailureDialog('Please select an image.');
    }
  }

  void _showFailureDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upload Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Map<String, String> categoryImages = {
    'Storage': 'assets/treatment.jpg',
    'Transport': 'assets/treatment.jpg',
    'Diagnostic': 'assets/treatment.jpg',
    'Electronic': 'assets/treatment.jpg',
    'Surgical': 'assets/treatment.jpg',
    'Acute Care': 'assets/treatment.jpg',
    ' Procedural Medical Equipment': 'assets/treatment.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Upload Product'),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _image != null
                      ? Image.file(
                    File(_image!.path),
                    height: 150,
                  )
                      : Container(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 10),
                  const Text('Product Categories'),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: categoryImages.keys
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                categoryImages[value]!,
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Name'),
                    onChanged: (value) {
                      setState(() {
                        _productName = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _productPrice = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Details'),
                    onChanged: (value) {
                      setState(() {
                        _productDetails = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Product Quantity'), // Updated to quantity
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        _productQuantity = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  _image != null
                      ? Column(
                    children: [
                      const Text(
                        'Selected Image:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.file(
                        File(_image!.path),
                        height: 150,
                      ),
                    ],
                  )
                      : Container(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: uploadImage,
                    child: const Text('Upload Image with Details'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),



    );
  }
}
