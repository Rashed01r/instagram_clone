import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/component/button_profile_screen.dart';
import 'package:instagram/component/column_followers_following_posts.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userData = Provider.of<UserDataProvider>(context, listen: false);
      userData.getDataUser(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, model, child) {
        return model.isLoadingProfile
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  automaticallyImplyLeading: false,
                  title: Text(
                    model.userData['username'].toString(),
                  ),
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                  model.userData['imageUrl'].toString(),
                                ),
                                radius: 40,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        NumFollowersAndPosts(
                                          label: "Posts",
                                          num: model.postLength,
                                        ),
                                        NumFollowersAndPosts(
                                          label: "Followers",
                                          num: model.followers,
                                        ),
                                        NumFollowersAndPosts(
                                          label: "Following",
                                          num: model.following,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FirebaseAuth.instance.currentUser!
                                                    .uid ==
                                                widget.uid
                                            ? ButtonProfileScreen(
                                                function: () {
                                                  model.signOut(context);
                                                },
                                                backgroundColor:
                                                    mobileBackgroundColor,
                                                borderColor: Colors.grey,
                                                text: "Sign Out",
                                                textColor: primaryColor,
                                              )
                                            : model.isFolowwing
                                                ? ButtonProfileScreen(
                                                    function: () async {
                                                      model.decreasefollowers();
                                                    },
                                                    backgroundColor:
                                                        Colors.white,
                                                    borderColor: Colors.grey,
                                                    text: "Unfollow",
                                                    textColor: Colors.black,
                                                  )
                                                : ButtonProfileScreen(
                                                    function: () {
                                                      model.increasefollowers();
                                                    },
                                                    backgroundColor:
                                                        Colors.blue,
                                                    borderColor: Colors.white,
                                                    text: "Follow",
                                                    textColor: Colors.white,
                                                  )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              model.userData["username"].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              model.userData["bio"].toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('uid', isEqualTo: widget.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 1.5,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap = snapshot.data!.docs[index];
                            return Container(
                              child: Image(
                                image: NetworkImage(
                                  snap['postUrl'].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              );
      },
    );
  }
}
