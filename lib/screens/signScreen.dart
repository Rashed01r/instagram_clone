import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/component/loginAndSigninbottom.dart';
import 'package:instagram/component/text_field_input.dart';
import 'package:instagram/providers/login_signin_provider.dart';
import 'package:instagram/screens/loginScreen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
    bioController.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
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

            Consumer<LoginSigninProvider>(
              builder: (context, model, child) {
                return Stack(
                  children: [
                    model.image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(model.image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                "https://twirpz.files.wordpress.com/2015/06/twitter-avi-gender-balanced-figure.png"),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 79,
                      child: IconButton(
                        onPressed: () => model.pickImage(),
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            // text field input username
            TextFieldInput(
              controller: userNameController,
              hintText: "Enter your username",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            // text field input email
            TextFieldInput(
              controller: emailController,
              hintText: "Enter your email",
              textInputType: TextInputType.emailAddress,
            ),

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

            // text field input bio
            TextFieldInput(
              controller: bioController,
              hintText: "Enter your bio",
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),
            // button login
            Consumer<LoginSigninProvider>(
              builder: (context, model, child) {
                return InkWell(
                  onTap: () => model.signUp(
                    context: context,
                    bio: bioController.text,
                    email: emailController.text,
                    file: model.image!,
                    password: passController.text,
                    username: userNameController.text,
                  ),
                  child: Container(
                    child: model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : Text("Sign Up"),
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

            LoginAndSigninBottom(
              title: "Do you already have an account?",
              namePage: "Login.",
              widget: LoginScreen(),
            )
          ],
        ),
      )),
    );
  }
}
