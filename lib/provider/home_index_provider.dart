import 'package:flutter/material.dart';

class HomeIndexProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setIndex(int currentIndex) {
    _selectedIndex = currentIndex;
    notifyListeners();
  }
}
