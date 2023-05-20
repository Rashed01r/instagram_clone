import 'package:flutter/material.dart';

class NumFollowersAndPosts extends StatelessWidget {
  final int num;
  final String label;
  const NumFollowersAndPosts(
      {super.key, required this.num, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
