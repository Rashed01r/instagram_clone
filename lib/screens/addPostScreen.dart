import 'package:flutter/material.dart';
import 'package:instagram/component/topAddPostScreen.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController descConytoller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    descConytoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<PostProvider>(context);
    UserApp userApp = Provider.of<UserDataProvider>(context).getUser;
    return prov.file == null
        ? Center(
            child: IconButton(
              onPressed: () => prov.selectImageDialog(context),
              icon: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: const Text("Post to"),
              actions: [
                TextButton(
                  onPressed: () => prov.postImage(
                    userApp.uid,
                    userApp.username,
                    userApp.imageUrl,
                    descConytoller.text,
                    context,
                  ),
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                prov.isLoading
                    ? const LinearProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                        ),
                        child: Divider(),
                      ),
                TopAddPostScreen(
                  controller: descConytoller,
                ),
              ],
            ),
          );
  }
}
