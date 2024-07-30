import 'package:flutter/material.dart';

class VisibilityProvider extends ChangeNotifier {
  bool _visibility = true;
  bool get visibility => _visibility;
  setVisibility() {
    _visibility = !_visibility;
    notifyListeners();
  }
}
