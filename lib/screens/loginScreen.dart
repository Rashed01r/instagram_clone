import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/component/loginAndSigninbottom.dart';
import 'package:instagram/component/text_field_input.dart';
import 'package:instagram/providers/login_signin_provider.dart';
import 'package:instagram/screens/signScreen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var prov = Provider.of<InstaProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // svg image
            SvgPicture.asset(
              "images/ic_instagram.svg",
              height: 64,
              color: primaryColor,
            ),
            const SizedBox(
              height: 64,
            ),
            // text field input email
            TextFieldInput(
                controller: emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress),

            const SizedBox(
              height: 24,
            ),

            // text field input password
            TextFieldInput(
              controller: passController,
              hintText: "Enter your password",
              textInputType: TextInputType.emailAddress,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),

            // button login
            Consumer<LoginSigninProvider>(
              builder: (context, model, child) {
                return InkWell(
                  onTap: () => model.loginUser(
                    email: emailController.text,
                    password: passController.text,
                    context: context,
                  ),
                  child: Container(
                    child: model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Text("Log in"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: blueColor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),

            // button signing up
            LoginAndSigninBottom(
              title: "Do not have an a account?",
              namePage: "Sign up.",
              widget: SignScreen(),
            ),
          ],
        ),
      )),
    );
  }
}
