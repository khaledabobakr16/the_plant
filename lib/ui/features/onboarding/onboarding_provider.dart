import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
