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
  final CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('requests');

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
      'uid': uid,
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

  Future joinIqub(String iqubId, String uid, String requestId) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    DocumentReference requestDocRef = requestCollection.doc(requestId);

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
      await requestDocRef.delete();
      await userDocRef.update({
        'iqubs': FieldValue.arrayUnion([iqubId])
      });

      await iqubDocRef.update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
  }

  Future requestjoinIqub(String iqubId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    DocumentSnapshot iqubDocSnapshot = await iqubDocRef.get();
    String Admin = await iqubDocSnapshot.get('admin');
    String iqubName = await iqubDocSnapshot.get('iqubName');
    String SenderId = await userDocSnapshot.get('uid');
    String SenderName = await userDocSnapshot.get('firstName');
    DocumentReference requestDocRef = requestCollection.doc();
    DocumentSnapshot requestDocSnapshot = await requestDocRef.get();

    requestDocRef = await requestCollection.add({
      'iqubId': iqubId,
      'iqubIcon': '',
      'senderId': SenderId,
      'receiver': [],
      'senderName': SenderName,
      'requestId': [],
    });

    List<dynamic> iqubs = await userDocSnapshot.get('iqubs');

    String requests = await requestDocSnapshot.id;

    if (requests.contains(iqubId)) {
      //print('hey');
      await requestDocRef.update({
        'iqubId': FieldValue.arrayRemove([iqubId])
      });

      await requestDocRef.update({
        'senderId': FieldValue.arrayRemove([uid])
      });
    } else {
      await requestDocRef.update({'requestId': requestDocRef.id});
      await requestDocRef.update({
        'receiver': FieldValue.arrayUnion([Admin])
      });
    }
  }

  Future deleteIqub(String iqubId) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    List<dynamic> iqubs = await userDocSnapshot.get('iqubs');

    await userDocRef.update({
      'iqubs': FieldValue.arrayRemove([iqubId])
    });

    await iqubDocRef.update({
      'members': FieldValue.arrayRemove([uid])
    });

    await FirebaseFirestore.instance.collection('iqubs').doc(iqubId).delete();
  }

  Future addUserToIqub(String iqubId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    String retVal = 'none';
    List<dynamic> iqubs = await userDocSnapshot.get('iqubs');
    if (iqubs.contains(iqubId)) {
      //print('hey');
      retVal = 'error';
      // await userDocRef.update({
      //   'iqubs': FieldValue.arrayRemove([iqubId])
      // });

      // await iqubDocRef.update({
      //   'members': FieldValue.arrayRemove([uid])
      // });
    } else {
      retVal = 'success';
      await userDocRef.update({
        'iqubs': FieldValue.arrayUnion([iqubId])
      });

      await iqubDocRef.update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
    return retVal;
  }

  Future deleteUserFromIqub(String iqubId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    String retVal = 'none';
    List<dynamic> iqubs = await userDocSnapshot.get('iqubs');
    if (iqubs.contains(iqubId)) {
      //print('hey');
      retVal = 'success';
      await userDocRef.update({
        'iqubs': FieldValue.arrayRemove([iqubId])
      });

      await iqubDocRef.update({
        'members': FieldValue.arrayRemove([uid])
      });
    } else {
      retVal = 'error';
    }
    return retVal;
  }

  // IqubModel _iqubListFromSnapshot(DocumentSnapshot snapshot) {
  //   return IqubModel(
  //       id: uid,
  //       name: snapshot.get('iqubname'),
  //       members: List<String>.from(snapshot.get('members')),
  //       type: snapshot.get('type'),
  //       admin: snapshot.get('admin'),
  //       pooledAmount: snapshot.get('pooledAmount'));
  // }

  // Future<List<IqubModel>> get iqubs {
  //   return iqubsCollection
  //       .doc(uid)
  //       .snapshots()
  //       .map(_iqubListFromSnapshot)
  //       .toList();
  // }

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
