
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/helper.dart';
import '../const/wall_posts.dart';


class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final currentUser=FirebaseAuth.instance.currentUser!;

  //text controller
  final textController=TextEditingController();





  //post message
  void postMessage(){
    //only post if message is in the textField
    if(textController.text.isNotEmpty){
      //store to firebase
      FirebaseFirestore.instance.collection('User Posts').add({
        'UserEmail':currentUser.email,
        'Message':textController.text,
        'Timestamp':Timestamp.now(),
        'Likes':[],


      });
    }
    //clear textField
    setState(() {
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Text('Community Meet Up',
            style: GoogleFonts.aboreto(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("User Posts")
                  .orderBy(
                  "Timestamp",
                  descending: false).snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    //get the message
                    itemBuilder: (context, index){
                      final post=snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'],
                        user:post['UserEmail'],
                        postId: post.id,
                        likes: List<String>.from(post['Likes'] ?? []),
                        time: formatDate(post['Timestamp']) ,);
                    },

                  );
                } else if(snapshot.hasError){

                  return Center(
                    child: Text('Error: +${snapshot.error}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),


          //post message
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:const BorderSide(
                            color: Colors.black
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:const BorderSide(
                            color: Colors.black
                        ),
                      ),

                      hintText: 'Write somethimg...',

                    ),

                  ),
                ),

                //post Button
                IconButton(onPressed: postMessage, icon: Container(
                    height: 60,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: const Icon(Icons.send_outlined)))
              ],
            ),
          ),
          Center(child: Text("Logged in as:${currentUser.email!}")),


        ],
      ),
    );
  }
}
