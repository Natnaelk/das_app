import 'package:flutter/material.dart';

import '../iqub_drawer_navigation.dart';

class AdmineditPage extends StatefulWidget {
  String iqubId;
  List members;
  AdmineditPage({this.iqubId, this.members});

  @override
  State<AdmineditPage> createState() => _AdmineditPageState();
}

class _AdmineditPageState extends State<AdmineditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubDrawer(
        iqub: widget.iqubId,
        members: widget.members,
      ),
      appBar: AppBar(
        title: Text("edit"),
      ),
      body: Center(child: Text('edit')),
    );
  }
}
