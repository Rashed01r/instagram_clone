import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.snap["profileImage"].toString(),
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "${widget.snap['name']} :  ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: widget.snap['text'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            child: Icon(Icons.favorite),
          )
        ],
      ),
    );
  }
}
