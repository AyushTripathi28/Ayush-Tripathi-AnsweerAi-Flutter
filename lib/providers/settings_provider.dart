import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool isDrawerOpen = false;

  double getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size.width / 1.2;
  }

  void toggleDrawer() {
    isDrawerOpen = !isDrawerOpen;
    notifyListeners();
  }
}
