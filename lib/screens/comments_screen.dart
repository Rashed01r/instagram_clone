import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/component/comment_card.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/comment_provider.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    UserApp userApp = Provider.of<UserDataProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Comments"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy(
              'datePublished',
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(right: 8, left: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userApp.imageUrl),
                radius: 18,
              ),
              Consumer<CommentProvider>(
                builder: (context, value, child) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 8),
                      child: TextField(
                        controller: value.commentController,
                        decoration: InputDecoration(
                          hintText: "comment as ${userApp.username}",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Consumer<CommentProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () async {
                      value.refreshComments(
                        widget.snap['postId'],
                        value.commentController.text,
                        userApp.username,
                        userApp.uid,
                        userApp.imageUrl,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
