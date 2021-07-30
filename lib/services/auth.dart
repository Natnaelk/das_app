import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'collections.dart';

// final FirebaseAuth _firebaseAuth;
// AuthService(this._firebaseAuth);
// Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> signUp(String email, String password, String firstName,
    String lastName, var phoneno, String address) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((signeduser) {
      usercollection.doc(signeduser.user.uid).set({
        'email': email,
        'password': password,
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(signeduser.user.uid)
          .set({
        'uid': signeduser.user.uid,
        'email': email,
        'firstname': firstName,
        'lastname': lastName,
        'phonenumber': phoneno,
        'address': address
      });
    });

    return true;
  } on FirebaseException catch (e) {
    if (e.code == 'Weak-password') {
      print("weak password");
    } else if (e.code == 'email-already-in-use') {
      print("email already in use");
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

// Future<bool> completeProfile(String firstName, String lastName, int phoneNumber, String address) async {
//   try {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(first Name: firstName, lastName: lastName)
//         .then((signeduser) {
//       usercollection.doc(signeduser.user.uid).set({
//         'email': email,
//         'password': password,
//         'uid': signeduser.user.uid,
//       });
//     });
//     return true;
//   } on FirebaseException catch (e) {
//     if (e.code == 'Weak-password') {
//       print("weak password");
//     } else if (e.code == 'email-already-in-use') {
//       print("email already in use");
//     }
//   } catch (e) {
//     print(e.toString());
//     return false;
//   }
// }

// sign in with email and password
// Future registerWithEmailandPassword(String email, String password) async {
//   try {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     User user = result.user;
//     return _userFromFirebaseUser(user);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }

// register with email and pasdowrd
// sign out
