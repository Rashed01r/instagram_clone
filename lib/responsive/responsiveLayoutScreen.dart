import 'package:flutter/material.dart';
import 'package:instagram/providers/user_data_provider.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userData = Provider.of<UserDataProvider>(context, listen: false);
      userData.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, model, child) {
        return model.isLoadingUser
            ? Center(
                child: CircularProgressIndicator(),
              )
            : LayoutBuilder(
                builder: (context, covariants) {
                  if (covariants.maxWidth > webScreenSize) {
                    // web screen
                    return widget.webScreenLayout;
                  }
                  // mobile screen
                  return widget.mobileScreenLayout;
                },
              );
      },
    );
  }
}
