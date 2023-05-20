import 'package:flutter/material.dart';
import 'package:instagram/providers/bottom_nav_bar_provider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/globalVaraible.dart';
import 'package:provider/provider.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, model, child) {
        int currentIndex = model.fetchCurrentIndex;

        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              selectedItemColor: blueColor,
              showSelectedLabels: false,
              elevation: 1.5,
              currentIndex: currentIndex,
              onTap: (value) => model.updateScreenIndex(value),
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                      (currentIndex == 0) ? Icons.home : Icons.home_outlined),
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon((currentIndex == 1)
                      ? Icons.search
                      : Icons.search_outlined),
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    (currentIndex == 2)
                        ? Icons.add_circle
                        : Icons.add_circle_outline_outlined,
                  ),
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    (currentIndex == 3)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                  ),
                  backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(
                    (currentIndex == 4)
                        ? Icons.person
                        : Icons.person_outline_outlined,
                  ),
                  backgroundColor: mobileBackgroundColor,
                ),
              ]),
          body: screens[currentIndex],
        );
      },
    );
  }
}
