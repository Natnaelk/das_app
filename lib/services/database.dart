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
  final CollectionReference paymentCollection =
      FirebaseFirestore.instance.collection('payment');
  final CollectionReference IdirpaymentCollection =
      FirebaseFirestore.instance.collection('Idirpayment');
// update user data to database
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

  Future editUserData(
    String uid,
    String email,
    String address,
    String phone,
    String firstName,
    String lastName,
  ) async {
    String retVal = 'error';
    DocumentReference userDocRef = usersCollection.doc(uid);
    try {
      retVal = 'success';

      await userDocRef.update({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'address': address,
        'phone': phone,
        'paidList': []
        // 'profilePic': ''
      });
    } catch (e) {}

    return retVal;
  }

  Future createIqub(
      String uid,
      String iqubName,
      String poolAmount,
      String bankAccount,
      String maxNoOfMembers,
      String address,
      String type) async {
    String retVal = "error";
    try {
      retVal = "success";
      DocumentReference iqubDocRef = await iqubsCollection.add({
        'iqubName': iqubName,
        'iqubIcon': '',
        'admin': uid,
        'members': [],
        'iqubId': '',
        'poolAmount': poolAmount,
        'startingDate': Timestamp.now(),
        'maximum no of members': maxNoOfMembers,
        'address': address,
        'bank Account': bankAccount,
        'Type': type,
        'paidList': []
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
      retVal = "error";
    }
    return retVal;
  }

  // Future addDataToIqub(String iqubId) async {
  //   DocumentReference iqubDocRef = usersCollection.doc(iqubId);
  //   DocumentSnapshot iqubDocSnapshot = await iqubDocRef.get();
  //   await iqubDocRef.update({});
  // }

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
      requestDocRef.delete();
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

  Future<bool> isUserJoined(String iqubId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    List<dynamic> iqubs = await userDocSnapshot.get('iqubs');

    if (iqubs.contains(iqubId)) {
      //print('he');
      return true;
    } else {
      //print('ne');
      return false;
    }
  }

  Future<bool> isUserAdmin(String iqubId, String admin) async {
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    DocumentSnapshot iqubDocSnapshot = await iqubDocRef.get();
    String iqubAdmin = await iqubDocSnapshot.get('admin');

    if (iqubAdmin == admin) {
      //print('he');
      print(iqubAdmin);
      print(admin);
      return true;
    } else {
      //print('ne');
      return false;
    }
  }

  searchByName(String iqubName) {
    return FirebaseFirestore.instance
        .collection("iqubs")
        .where('iqubName', isEqualTo: iqubName)
        .get();
  }

  Future leaveIqub(String iqubId, String currentUser) async {
    DocumentReference userDocRef = usersCollection.doc(currentUser);
    // DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    DocumentSnapshot iqubDocSnapshot = await iqubDocRef.get();
    List<dynamic> iqubs = await iqubDocSnapshot.get('members');

    if (iqubs.contains(currentUser)) {
      await userDocRef.update({
        'iqubs': FieldValue.arrayRemove([iqubId])
      });
      await iqubDocRef.update({
        'members': FieldValue.arrayRemove([currentUser])
      });
    } else {
      print('error');
    }
  }

  Future deleteIqub(String iqubId) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    // DocumentSnapshot userDocSnapshot = await userDocRef.get();
    var docref = FirebaseFirestore.instance.collection('iqubs').doc(iqubId);
    // List<dynamic> iqubs = await userDocSnapshot.get('iqubs');
    docref.delete();
    // if (iqubs.contains(iqubId)) {
    //   await userDocRef.update({
    //     'iqubs': FieldValue.arrayRemove([iqubId])
    //   });
    // } else {
    //   print('user not found');
    // }
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

  Future saveIqubPaymentInfo(
      String iqubId, String uid, String downloadUrl) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    DocumentSnapshot iqubDocSnapshot = await iqubDocRef.get();
    String Admin = await iqubDocSnapshot.get('admin');
    String iqubName = await iqubDocSnapshot.get('iqubName');
    String SenderId = await userDocSnapshot.get('uid');
    String SenderName = await userDocSnapshot.get('firstName');
    DocumentReference paymentDocRef = paymentCollection.doc();
    DocumentSnapshot paymentDocSnapshot = await paymentDocRef.get();
    int accepted = 0;
    paymentDocRef = await paymentCollection.add({
      'iqubId': iqubId,
      'accepted': accepted,
      'senderId': SenderId,
      'receiver': '',
      'image': downloadUrl,
      'senderName': SenderName,
      'paymentId': [],
    });

    String payments = await paymentDocSnapshot.id;

    if (payments.contains(iqubId)) {
      //print('hey');
      await paymentDocRef.update({
        'iqubId': FieldValue.arrayRemove([iqubId])
      });

      await paymentDocRef.update({
        'senderId': FieldValue.arrayRemove([uid])
      });
    } else {
      await paymentDocRef.update({'paymentId': paymentDocRef.id});
      await paymentDocRef.update({'receiver': Admin});
    }
  }

  Future acceptPayment(String paymentId) async {
    DocumentReference paymentDocRef = paymentCollection.doc(paymentId);
    await paymentDocRef.update({'accepted': 1});
  }

  Future addToPaidList(String senderId, String paymentId, String iqubid) async {
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubid);
    DocumentReference userDocRef = usersCollection.doc(senderId);
    await iqubDocRef.update({
      'paidList': FieldValue.arrayUnion([senderId])
    });
    await userDocRef.update({
      'paidList': FieldValue.arrayUnion([iqubid])
    });
  }

  Future<bool> isIqubPaid(String iqubId, String uid) async {
    DocumentReference iqubDocRef = iqubsCollection.doc(iqubId);
    DocumentSnapshot iqubDocSnapshot = await iqubDocRef.get();

    List<dynamic> paidlists = await iqubDocSnapshot.get('paidList');

    if (paidlists.contains(uid)) {
      //print('he');
      return true;
    } else {
      //print('ne');
      return false;
    }
  }

  Future rejectPayment(String paymentId) async {
    DocumentReference paymentDocRef = paymentCollection.doc(paymentId);
    await paymentDocRef.update({'accepted': 2});
  }

  Future createIdir(
    String uid,
    String idirName,
    String poolAmount,
    String bankAccount,
    String maxNoOfMembers,
    String address,
  ) async {
    String retVal = "error";
    try {
      retVal = "success";
      DocumentReference idirDocRef = await idirsCollection.add({
        'idirName': idirName,
        'idirIcon': '',
        'admin': uid,
        'members': [],
        'idirId': '',
        'poolAmount': poolAmount,
        'startingDate': Timestamp.now(),
        'maximum no of members': maxNoOfMembers,
        'address': address,
        'bank Account': bankAccount,
        'paidList': []
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
      retVal = "error";
    }
    return retVal;
  }

  Future joinIdir(String idirId, String uid, String requestId) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference idirDocRef = idirsCollection.doc(idirId);
    DocumentReference requestDocRef = requestCollection.doc(requestId);

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
      requestDocRef.delete();
      await userDocRef.update({
        'idirs': FieldValue.arrayUnion([idirId])
      });

      await idirDocRef.update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
  }

  Future requestjoinIdir(String idirId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference idirDocRef = idirsCollection.doc(idirId);
    DocumentSnapshot idirDocSnapshot = await idirDocRef.get();
    String Admin = await idirDocSnapshot.get('admin');
    String idirName = await idirDocSnapshot.get('idirName');
    String SenderId = await userDocSnapshot.get('uid');
    String SenderName = await userDocSnapshot.get('firstName');
    DocumentReference requestDocRef = requestCollection.doc();
    DocumentSnapshot requestDocSnapshot = await requestDocRef.get();

    requestDocRef = await requestCollection.add({
      'idirId': idirId,
      'idirIcon': '',
      'senderId': SenderId,
      'receiver': [],
      'senderName': SenderName,
      'requestId': [],
    });

    List<dynamic> idirs = await userDocSnapshot.get('idirs');

    String requests = await requestDocSnapshot.id;

    if (requests.contains(idirId)) {
      //print('hey');
      await requestDocRef.update({
        'idirId': FieldValue.arrayRemove([idirId])
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

  Future<bool> isUserJoinedIdir(String idirId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    List<dynamic> idirs = await userDocSnapshot.get('idirs');

    if (idirs.contains(idirId)) {
      //print('he');
      return true;
    } else {
      //print('ne');
      return false;
    }
  }

  searchIdirByName(String idirName) {
    return FirebaseFirestore.instance
        .collection("idirs")
        .where('idirName', isEqualTo: idirName)
        .get();
  }

  Future leaveIdir(String idirId, String currentUser) async {
    DocumentReference userDocRef = usersCollection.doc(currentUser);
    // DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference idirDocRef = idirsCollection.doc(idirId);
    DocumentSnapshot idirDocSnapshot = await idirDocRef.get();
    List<dynamic> idirs = await idirDocSnapshot.get('members');

    if (idirs.contains(currentUser)) {
      await userDocRef.update({
        'idirs': FieldValue.arrayRemove([idirId])
      });
      await idirDocRef.update({
        'members': FieldValue.arrayRemove([currentUser])
      });
    } else {
      print('error');
    }
  }

  Future deleteIdir(String idirId) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    // DocumentSnapshot userDocSnapshot = await userDocRef.get();
    var docref = FirebaseFirestore.instance.collection('idirs').doc(idirId);
    // List<dynamic> idirs = await userDocSnapshot.get('idirs');
    docref.delete();
    // if (idirs.contains(idirId)) {
    //   await userDocRef.update({
    //     'idirs': FieldValue.arrayRemove([idirId])
    //   });
    // } else {
    //   print('user not found');
    // }
  }

  Future addUserToIdir(String idirId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference idirDocRef = idirsCollection.doc(idirId);
    String retVal = 'none';
    List<dynamic> idirs = await userDocSnapshot.get('idirs');
    if (idirs.contains(idirId)) {
      //print('hey');
      retVal = 'error';
      // await userDocRef.update({
      //   'idirs': FieldValue.arrayRemove([idirId])
      // });

      // await idirDocRef.update({
      //   'members': FieldValue.arrayRemove([uid])
      // });
    } else {
      retVal = 'success';
      await userDocRef.update({
        'idirs': FieldValue.arrayUnion([idirId])
      });

      await idirDocRef.update({
        'members': FieldValue.arrayUnion([uid])
      });
    }
    return retVal;
  }

  Future deleteUserFromIdir(String idirId, String uid) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference idirDocRef = idirsCollection.doc(idirId);
    String retVal = 'none';
    List<dynamic> idirs = await userDocSnapshot.get('idirs');
    if (idirs.contains(idirId)) {
      //print('hey');
      retVal = 'success';
      await userDocRef.update({
        'idirs': FieldValue.arrayRemove([idirId])
      });

      await idirDocRef.update({
        'members': FieldValue.arrayRemove([uid])
      });
    } else {
      retVal = 'error';
    }
    return retVal;
  }

  Future saveIdirPaymentInfo(
      String idirId, String uid, String downloadUrl) async {
    DocumentReference userDocRef = usersCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    DocumentReference idirDocRef = idirsCollection.doc(idirId);
    DocumentSnapshot idirDocSnapshot = await idirDocRef.get();
    String Admin = await idirDocSnapshot.get('admin');
    String idirName = await idirDocSnapshot.get('idirName');
    String SenderId = await userDocSnapshot.get('uid');
    String SenderName = await userDocSnapshot.get('firstName');
    DocumentReference paymentDocRef = IdirpaymentCollection.doc();
    DocumentSnapshot paymentDocSnapshot = await paymentDocRef.get();
    int accepted = 0;
    paymentDocRef = await paymentCollection.add({
      'idirId': idirId,
      'accepted': accepted,
      'senderId': SenderId,
      'receiver': '',
      'image': downloadUrl,
      'senderName': SenderName,
      'paymentId': [],
    });

    String payments = paymentDocSnapshot.id;

    if (payments.contains(idirId)) {
      //print('hey');
      await paymentDocRef.update({
        'idirId': FieldValue.arrayRemove([idirId])
      });

      await paymentDocRef.update({
        'senderId': FieldValue.arrayRemove([uid])
      });
    } else {
      await paymentDocRef.update({'paymentId': paymentDocRef.id});
      await paymentDocRef.update({'receiver': Admin});
    }
  }

  Future addIdirToPaidList(
      String senderId, String paymentId, String idirid) async {
    DocumentReference idirDocRef = idirsCollection.doc(idirid);
    DocumentReference userDocRef = usersCollection.doc(senderId);
    await idirDocRef.update({
      'paidList': FieldValue.arrayUnion([senderId])
    });
    await userDocRef.update({
      'paidList': FieldValue.arrayUnion([idirid])
    });
  }

  Future acceptIdirPayment(String paymentId) async {
    DocumentReference paymentDocRef = paymentCollection.doc(paymentId);
    await paymentDocRef.update({'accepted': 1});
  }

  Future rejectIdirPayment(String paymentId) async {
    DocumentReference paymentDocRef = paymentCollection.doc(paymentId);
    await paymentDocRef.update({'accepted': 2});
  }
}
