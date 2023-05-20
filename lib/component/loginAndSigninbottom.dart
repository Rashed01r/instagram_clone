import 'package:flutter/material.dart';


class LoginAndSigninBottom extends StatelessWidget {
  final String title;
  final String namePage;
  final Widget widget;
  const LoginAndSigninBottom(
      {super.key,
      required this.title,
      required this.namePage,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(title),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => widget,
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              namePage,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
