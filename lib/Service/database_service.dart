import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<QuerySnapshot> getItems(
      String collectionName, String? searchText) async* {
    yield* _firestore
        .collection(collectionName)
        .where('fullName', isGreaterThanOrEqualTo: searchText)
        .snapshots();
  }

  static Future<void> updateFullName(String fullName) async {
    await _auth.currentUser?.updateDisplayName(fullName).then((value) {
      _firestore
          .collection("admins")
          .doc("NygBQ6t2AZO0BqauzZIY")
          .update({"fullName": fullName}).catchError((error, stackrace) {
        debugPrint(stackrace);
      });
    }).catchError((error, stackrace) {
      debugPrint(stackrace);
    });
  }

  static Future<bool?> isAdmin() async {
    bool? isAdmin = await _firestore
        .collection('admins')
        .get()
        .then((QuerySnapshot snapshot) {
      for (var a in snapshot.docs) {
        if (a.get('uid') == _auth.currentUser?.uid) {
          return true;
        } else {
          return false;
        }
      }
      return null;
    }).catchError((error, stackrace) {
      debugPrint(stackrace);
      return false;
    });

    return isAdmin;
  }

 
}
