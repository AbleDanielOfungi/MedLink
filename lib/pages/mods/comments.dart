import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  const Comments(
      {super.key, required this.text, required this.user, required this.time});
  final String text;
  final String user;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          //comment
          Row(
            children: [
              Text(
                user,
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
              Text(time),
            ],
          ),
        ],
      ),
    );
  }
}
