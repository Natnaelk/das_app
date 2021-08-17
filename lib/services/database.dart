import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/iqub_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference iqubsCollection =
      FirebaseFirestore.instance.collection('iqubs');
  final CollectionReference idirsCollection =
      FirebaseFirestore.instance.collection('idirs');

  Future updateUserData(
    String email,
    String address,
    String phone,
    String firstName,
    String lastName,
  ) async {
    return await usersCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'idirs': [],
      'iqubs': [],
      'address': address,
      'phone': phone,
      // 'profilePic': ''
    });
  }

  Future createIqub(
    String uid,
    String iqubName,
  ) async {
    String retVal = "error";
    try {
      DocumentReference iqubDocRef = await iqubsCollection.add({
        'iqubName': iqubName,
        'iqubIcon': '',
        'admin': uid,
        'members': [],
        'iqubId': '',
      });

      await iqubDocRef.update({
        'members': FieldValue.arrayUnion([uid + '_admin']),
        'iqubId': iqubDocRef.id
      });

      DocumentReference userDocRef = usersCollection.doc(uid);
      return await userDocRef.update({
        'iqubs': FieldValue.arrayUnion([iqubDocRef.id + '_' + iqubName])
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future joinIqub(String iqubId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);

    List<dynamic> iqubs = await userDocSnapshot.get('iqubs');

    if (iqubs.contains(iqubId)) {
      //print('hey');
      await userDocRef.update({
        'iqubs': FieldValue.arrayRemove([iqubId])
      });

      await iqubDocRef.update({
        'members': FieldValue.arrayRemove([uid])
      });
    } else {
      await userDocRef.update({
        'iqubs': FieldValue.arrayUnion([iqubId])
      });

      await iqubDocRef.update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
  }

  List<IqubModel> _iqubListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((docs) {
      return IqubModel(
          id: docs.id,
          name: docs.get('iqubname'),
          members: List<String>.from(docs.get('members')),
          type: docs.get('type'),
          admin: docs.get('admin'),
          pooledAmount: docs.get('pooledAmount'));
    }).toList();
  }

  Stream<List<IqubModel>> get iqubs {
    return iqubsCollection.snapshots().map(_iqubListFromSnapshot);
  }

  Future createIdir(
    String uid,
    String idirName,
  ) async {
    String retVal = "error";
    try {
      DocumentReference idirDocRef = await idirsCollection.add({
        'idirName': idirName,
        'idirIcon': '',
        'admin': uid,
        'members': [],
        'idirId': '',
      });

      await idirDocRef.update({
        'members': FieldValue.arrayUnion([uid + '_admin']),
        'idirId': idirDocRef.id
      });

      DocumentReference userDocRef = usersCollection.doc(uid);
      return await userDocRef.update({
        'idirs': FieldValue.arrayUnion([idirDocRef.id + '_' + idirName])
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future joinIdir(String idirId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference idirDocRef = idirsCollection.doc(idirId);

    List<dynamic> idirs = await userDocSnapshot.get('idirs');

    if (idirs.contains(idirId)) {
      //print('hey');
      await userDocRef.update({
        'idirs': FieldValue.arrayRemove([idirId])
      });

      await idirDocRef.update({
        'members': FieldValue.arrayRemove([uid])
      });
    } else {
      await userDocRef.update({
        'idirs': FieldValue.arrayUnion([idirId])
      });

      await idirDocRef.update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
  }
}
