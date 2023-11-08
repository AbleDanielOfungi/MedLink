import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
        centerTitle: true,
      ),
      body: const VideoList(),
    );
  }
}

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Search by Name, Title, or Upload Time',
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('videos').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final videos = snapshot.data!.docs;
              List<VideoItem> videoItems = [];

              for (var video in videos) {
                final videoUrl = video['videoUrl'];
                final title = video['title'];
                final description = video['description'];
                final uploaderName = video['uploaderName'];
                final timestamp = video['timestamp'] as Timestamp;
                final formattedTimestamp =
                    DateFormat('yyyy-MM-dd HH:mm').format(timestamp.toDate());

                // Check if the video item matches the search query
                if (uploaderName.contains(_searchQuery) ||
                    title.contains(_searchQuery) ||
                    formattedTimestamp.contains(_searchQuery)) {
                  videoItems.add(VideoItem(
                    videoUrl: videoUrl,
                    title: title,
                    description: description,
                    uploaderName: uploaderName,
                    uploadTime: formattedTimestamp,
                  ));
                }
              }

              return ListView(
                children: videoItems,
              );
            },
          ),
        ),
      ],
    );
  }
}

class VideoItem extends StatelessWidget {
  final String videoUrl;
  final String title;
  final String description;
  final String uploaderName;
  final String uploadTime;

  const VideoItem({super.key, 
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.uploaderName,
    required this.uploadTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Uploader: ',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Eng. $uploaderName',
                  style: const TextStyle(
                      color: Colors.brown, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              'Upload Time: $uploadTime',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8.0),
            const Text('Description'),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return VideoDialog(videoUrl: videoUrl);
            },
          );
        },
      ),
    );
  }
}

class VideoDialog extends StatefulWidget {
  final String videoUrl;

  const VideoDialog({super.key, required this.videoUrl});

  @override
  _VideoDialogState createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_controller!.value.isInitialized)
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
