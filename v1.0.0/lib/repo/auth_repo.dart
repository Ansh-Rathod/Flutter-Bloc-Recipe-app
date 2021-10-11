import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:racipi/models/failure.dart';

class AuthRepo {
  Future<bool> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "Id": FirebaseAuth.instance.currentUser.uid,
        "Email": email,
      });
      return true;
    } catch (e) {
      print(e.toString());
      throw Failure(code: 403, message: e.message);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      throw Failure(code: 403, message: e.message);
    }
  }
}
