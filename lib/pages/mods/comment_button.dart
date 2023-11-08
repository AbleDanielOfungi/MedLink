import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // ignore: prefer_const_constructors
      child: Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}
