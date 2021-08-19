import 'package:flutter/material.dart';

class iqubDetailsScreen extends StatelessWidget {
  String iqubid;
  iqubDetailsScreen({this.iqubid});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(iqubid),
    );
  }
}
