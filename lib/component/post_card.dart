import 'package:flutter/material.dart';
import 'package:instagram/providers/comment_provider.dart';
import 'package:instagram/screens/comments_screen.dart';
import 'package:instagram/component/like_animation.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:instagram/resources/fireStoreMethod.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    super.initState();
    var prov = Provider.of<CommentProvider>(context, listen: false);
    prov.gitComment(widget.snap["postId"]);
  }

  @override
  Widget build(BuildContext context) {
    UserApp userApp = Provider.of<UserDataProvider>(context).getUser;
    var prov = Provider.of<CommentProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    bool isLikeAnimation = false;

    return Container(
      // Header Container
      decoration: BoxDecoration(
        border: Border.all(
            color:
                width > webScreenSize ? Colors.white : mobileBackgroundColor),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['username'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                "Delete",
                              ]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () async {
                                        FireStoreMethod()
                                            .deletePost(widget.snap['postId']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_vert))
              ],
            ),
          ),

          // Body container

          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethod().likePosts(
                widget.snap["postId"].toString(),
                userApp.uid,
                widget.snap["likes"],
              );
              setState(() {
                isLikeAnimation = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimation ? 1 : 0,
                  child: LikeAnimation(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 100,
                    ),
                    isAnimation: isLikeAnimation,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimation = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Like comment section

          Row(
            children: [
              LikeAnimation(
                isAnimation: widget.snap['likes'].contains(userApp.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FireStoreMethod().likePosts(
                        widget.snap["postId"],
                        userApp.uid,
                        widget.snap["likes"],
                      );
                    },
                    icon: widget.snap['likes'].contains(userApp.uid)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                          )),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentsScreen(
                    snap: widget.snap,
                  ),
                )),
                icon: Icon(Icons.comment_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_border),
                  ),
                ),
              ),
            ],
          ),

          // Descraption and number of comment

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.snap['likes'].length} likes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: primaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: "${widget.snap['username']} : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.snap['description'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "View all ${prov.commnetLength} comments",
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap['detePublished'].toDate(),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
