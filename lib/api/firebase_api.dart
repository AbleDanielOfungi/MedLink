import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';


class FirebaseApi{
  //create instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
 Future<void> initNotifications() async {

   //request permission from user(will prompt user)
   await _firebaseMessaging.requestPermission();

   //fetch the FCM token for device
   final fCMToken= await _firebaseMessaging.getToken();

   //print the token
  // print('Token: $fCMToken');

   //initialize further settings for push notifications
   initNotifications();

 }

  //function to handle recieved messages
void hanleMessage(RemoteMessage? message){

   //if message is null, do nothing
   if(message==null) return;

   //navigate to new screen when message is received and use tap notifications
  navigatorKey.currentState?.pushNamed(
    '/notification_page',
    arguments: message
  );

}

  //function to initialize foreground and background settings

  Future initPushNotifications()async{
   //handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(hanleMessage);

    //attach event listeners for when a notification open
    FirebaseMessaging.onMessageOpenedApp.listen(hanleMessage);

}
}