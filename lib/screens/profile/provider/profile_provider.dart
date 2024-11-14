import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  bool darkMode = false;

  void isDark(bool val) {
    darkMode = val;
    notifyListeners();
  }
}
