import 'package:flutter/material.dart';

import 'package:instagram/models/user.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:provider/provider.dart';

class TopAddPostScreen extends StatelessWidget {
  final TextEditingController controller;
  TopAddPostScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    UserApp userApp = Provider.of<UserDataProvider>(context).getUser;
    var prov = Provider.of<PostProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userApp.imageUrl.toString()),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Write a caption...",
              border: InputBorder.none,
            ),
            maxLines: 8,
          ),
        ),
        SizedBox(
          width: 45,
          height: 45,
          child: AspectRatio(
            aspectRatio: 487 / 451,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(prov.file!),
                  fit: BoxFit.fill,
                  alignment: FractionalOffset.topCenter,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
