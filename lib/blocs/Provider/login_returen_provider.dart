import 'package:flutter/material.dart';

class LoginReturn {
  Widget _currentScreen;
  Widget get prevScreen => _currentScreen;

  set setCurrentScreen(Widget currentScreen) {
    _currentScreen = currentScreen;
  }
}
