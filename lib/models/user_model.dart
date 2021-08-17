import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String address;
  String phone;
  String firstName;
  String lastName;
  //Timestamp accountCreated;
  //String fullName;
  String iqubs;
  String idirs;

  UserModel({
    this.uid,
    this.email,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.get('email');
    //accountCreated = doc.get('accountCreated');
    firstName = doc.get('firstName');
    lastName = doc.get('lastName');
    address = doc.get('address');
    phone = doc.get('phone');
    iqubs = doc.get('iqubs');
    idirs = doc.get('idirs');
  }
}
