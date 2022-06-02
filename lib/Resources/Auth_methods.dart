import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notetakingapp/Model/user.dart' as model;

class Auth_Methods {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; //create instance for firebase auth
  final FirebaseFirestore _firestore = FirebaseFirestore
      .instance; // createing instance of firestore  to save data like username or bio

//create a signup method

  Future<String> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        // creating user here and signup user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // cred.user.uid;

        model.User user = model.User(
          email: email,
          username: username,
          uid: cred.user!.uid,
        );

        //saving data into firestore
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "succes";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  //logging in method

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
