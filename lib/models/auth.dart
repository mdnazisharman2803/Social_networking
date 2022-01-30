import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'storage.dart';
import 'userdata.dart' as mymodel;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // getting user details
  Future<mymodel.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return mymodel.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String about,
    required Uint8List file,
  }) async {
    String result = "Some Error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          about.isNotEmpty ||
          file != null) {
        // registering user in firebase auth with email and password
        UserCredential credentialz = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String imageUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        mymodel.User _user = mymodel.User(
          username: username,
          uid: credentialz.user!.uid,
          imageUrl: imageUrl,
          email: email,
          about: about,
          followers: [],
          following: [],
        );

        // adding user in  database
        await _firestore.collection("users").doc(credentialz.user!.uid).set(
              _user.toJson(),
            );

        result = "success";
      } else {
        result = "Please enter all the fields";
      }
    } catch (error) {
      return error.toString();
    }
    return result;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        result = "success";
      } else {
        result = "Please enter all the fields";
      }
    } catch (error) {
      return error.toString();
    }
    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
