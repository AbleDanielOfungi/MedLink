import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({super.key});

  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  File? _videoFile;
  String _title = '';
  String _description = '';
  String _uploaderName = ''; // New field for the uploader's name
  String _uploadMessage = '';

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _videoFile = File(result.files.first.path!);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) {
      setState(() {
        _uploadMessage = 'Please select a video to upload.';
      });
      return;
    }

    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('videos/${DateTime.now()}.mp4');
      final UploadTask uploadTask = storageReference.putFile(_videoFile!);

      await uploadTask.whenComplete(() => null);

      final downloadURL = await storageReference.getDownloadURL();

      // Now, include the uploader's name when storing video metadata in Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'videoUrl': downloadURL,
        'title': _title,
        'description': _description,
        'uploaderName': _uploaderName, // Include the uploader's name
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _uploadMessage = 'Video uploaded successfully!';
      });

      // Clear the input fields after successful upload
      setState(() {
        _title = '';
        _description = '';
        _uploaderName = ''; // Clear the uploader's name field
      });
    } catch (error) {
      setState(() {
        _uploadMessage = 'Error uploading video: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video to Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_videoFile != null) VideoPlayerWidget(videoFile: _videoFile!),
              ElevatedButton(
                onPressed: _pickVideo,
                child: const Text('Pick a Video'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                    labelText:
                        'Uploader Name'), // Add a field for the uploader's name
                onChanged: (value) {
                  setState(() {
                    _uploaderName = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadVideo,
                child: const Text('Upload Video'),
              ),
              Text(_uploadMessage),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({super.key, required this.videoFile});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (_controller!.value.isPlaying) {
                _controller!.pause();
              } else {
                _controller!.play();
              }
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
