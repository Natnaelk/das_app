import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/user_model.dart';

class DbStream {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel> getcurrentUser(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(doc: docSnapshot));
  }
}
