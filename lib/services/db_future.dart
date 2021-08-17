import 'package:cloud_firestore/cloud_firestore.dart';

class DbFuture {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = [];

    try {
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': userUid,
        'members': members,
        'groupCreated': Timestamp.now(),
      });
      await _firestore.collection("users").doc(userUid).update({
        'groupId': _docRef.id,
      });
    } catch (e) {
      print(e);
    }
  }
}
