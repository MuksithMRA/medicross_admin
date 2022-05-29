// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {

  String? email;
  String? password;
  
  bool isLoggedIn = false;

  void emailOnchanged(String? email) {
    this.email = email;
    notifyListeners();
  }

  void passwordOnchanged(String? password) {
    this.password = password;
    notifyListeners();
  }

  void setLoginState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
        notifyListeners();
      } else {
        isLoggedIn = true;
        notifyListeners();
      }
    });
  }
}
