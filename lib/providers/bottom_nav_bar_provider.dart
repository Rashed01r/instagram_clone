import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int screenIndex = 0;

  // Move between pages
  int get fetchCurrentIndex {
    return screenIndex;
  }

  // The bottom bar changes according to the page

  void updateScreenIndex(int newINdex) {
    screenIndex = newINdex;
    notifyListeners();
  }
}
