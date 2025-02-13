import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = "";

  String get userName => _userName;

  void setUsername(String username) {
    _userName = username; // Correctly update the private field
    notifyListeners(); // Notify listeners about the change
  }
}
