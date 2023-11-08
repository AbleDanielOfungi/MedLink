import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../mods/comment_button.dart';
import '../mods/comments.dart';
import 'helper.dart';
import 'like_button.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  //get user from firebase
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  final commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);
  }

  //toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //access the document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser!.email])
      });

      //
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  //add comment
  void addComment(String commentText) {
    //write the comment to firestaore under comment collection
    FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser!.email,
      'CommentTime': Timestamp.now() //remember to format it nicely
    });
  }

  //show dialogue to allow user put a comment
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Add Comment'),
              content: TextField(
                controller: commentTextController,
                decoration: const InputDecoration(hintText: 'Write a comment...'),
              ),
              actions: [
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      //clear textfield
                      commentTextController.clear();
                    },
                    child: const Text('Cancel')),

                //save button
                TextButton(
                    onPressed: () {
                      addComment(commentTextController.text);

                      Navigator.pop(context);

                      //clear controller
                      commentTextController.clear();
                    },
                    child: const Text('Post')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.white,
          //   ),
          //   child: Icon(Icons.person),
          // ),

          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //profile pic
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.message,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      widget.user,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    //user & time
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(widget.time),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //like
                        Column(
                          children: [
                            LikeButton(
                              isLiked: isLiked,
                              onTap: toggleLike,
                            ),
                            //counter
                            Text(widget.likes.length.toString()),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        //comment
                        Column(
                          children: [
                            CommentButton(
                              onTap: showCommentDialog,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            //counter
                            const Text(
                              'Comment',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),

          /*like and comment*/

          const SizedBox(
            height: 10,
          ),

          /*display commens*/
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .orderBy('CommentTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                //show loading circle
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  shrinkWrap: true, //for nested lists
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    //get commet from firebase
                    final commentData = doc.data() as Map<String, dynamic>;

                    //retunrn comment
                    return Comments(
                      text: commentData['CommentText'],
                      user: commentData['CommentedBy'],
                      time: formatDate(commentData['CommentTime']),
                    );
                  }).toList(),
                );
              })
        ],
      ),
    );
  }
}
