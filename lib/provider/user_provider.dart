import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _username;
  String? _role;
  String? _authToken;

  String? get username => _username;
  String? get role => _role;
  String? get authToken => _authToken;

  void setUser(
      {required String username,
      required String role,
      required String authToken}) {
    _username = username;
    _role = role;
    _authToken = authToken;
    notifyListeners();
  }

  void clearUser() {
    _username = null;
    _role = null;
    _authToken = null;
    notifyListeners();
  }
}
