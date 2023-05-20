import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/providers/bottom_nav_bar_provider.dart';
import 'package:instagram/providers/comment_provider.dart';
import 'package:instagram/providers/login_signin_provider.dart';
import 'package:instagram/providers/post_provider.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:instagram/responsive/mobileScreenLayout.dart';
import 'package:instagram/responsive/responsiveLayoutScreen.dart';
import 'package:instagram/responsive/webScreenLayout.dart';
import 'package:instagram/screens/loginScreen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginSigninProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ),
      ),
    );
  }
}
