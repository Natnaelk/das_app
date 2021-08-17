import 'package:cloud_firestore/cloud_firestore.dart';

class IqubModel {
  String id;
  String name;
  //Timestamp groupCreated;
  List members;
  String type;
  String admin;
  double pooledAmount;

  IqubModel(
      {this.id,
      this.name,
      this.members,
      this.type,
      this.admin,
      this.pooledAmount});
}
