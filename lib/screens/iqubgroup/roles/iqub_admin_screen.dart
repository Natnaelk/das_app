import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class iqubAdminScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> iqubId;

  iqubAdminScreen({this.iqubId});

  @override
  _iqubAdminScreenState createState() => _iqubAdminScreenState();
}

class _iqubAdminScreenState extends State<iqubAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Admin')));
  }
}
