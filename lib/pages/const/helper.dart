import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp){
  //TimesStamp the object we retrieve from the firebase
  //we display n conert it to string

  DateTime dateTime=timestamp.toDate();

  //get year
  String year=dateTime.year.toString();

  //get month
  String month=dateTime.month.toString();

  //get day
  String day=dateTime.day.toString();

  //final formated date
  String formattedDate='$day/$month/$year';
  return formattedDate;

}