import 'package:flutter/material.dart';

class AgreeTermsProvider with ChangeNotifier {
  bool isChecked = false;
  void changeChecked(bool? value) {
    isChecked = value!;
    notifyListeners();
  }
}
