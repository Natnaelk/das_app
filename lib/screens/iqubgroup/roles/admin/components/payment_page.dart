import 'package:flutter/material.dart';

import '../iqub_drawer_navigation.dart';

class AdminpaymentPage extends StatefulWidget {
  String iqubId;
  List members;
  AdminpaymentPage({this.iqubId, this.members});

  @override
  State<AdminpaymentPage> createState() => _AdminpaymentPageState();
}

class _AdminpaymentPageState extends State<AdminpaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubDrawer(
        iqub: widget.iqubId,
        members: widget.members,
      ),
      appBar: AppBar(
        title: Text("payment"),
      ),
      body: Center(child: Text('payment')),
    );
  }
}
