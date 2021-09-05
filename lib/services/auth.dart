import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/services/database.dart';
import 'package:das_app/services/db_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'collections.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<AuthModel> get user {
    return _auth.authStateChanges().map(
          (User firebaseUser) => (firebaseUser != null)
              ? AuthModel.fromFirebseUser(user: firebaseUser)
              : null,
        );
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUp(String email, String password, String address,
      String phone, String firstname, String lastname) async {
    String retVal = "error";
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(
        email,
        address,
        phone,
        firstname,
        lastname,
      );
      retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message;
      print("hello");
    } catch (e) {
      retVal = e;
      print(e);
    }
    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      retVal = e.message;
      print(e);
    }
    return retVal;
  }

  Future<String> resetPassword(String email) async {
    String retVal = "error";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      retVal = e.message;
      print(e);
    }
    return retVal;
  }

  Future verifyPhone(String phoneno) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneno,
          verificationCompleted: (PhoneAuthCredential) async {},
          verificationFailed: (verificationFailed) async {},
          codeSent: (verifiacatoinId, resendingToken) {},
          codeAutoRetrievalTimeout: (verifiacatoinId) {});
    } catch (e) {}
  }
}
