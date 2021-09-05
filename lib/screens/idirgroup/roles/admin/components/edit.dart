import 'package:flutter/material.dart';

import '../idir_drawer_navigation.dart';

class IdirAdmineditPage extends StatefulWidget {
  String idirId;
  List members;
  IdirAdmineditPage({this.idirId, this.members});

  @override
  State<IdirAdmineditPage> createState() => _IdirAdmineditPageState();
}

class _IdirAdmineditPageState extends State<IdirAdmineditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: idirDrawer(
        idir: widget.idirId,
        members: widget.members,
      ),
      appBar: AppBar(
        title: Text("edit"),
      ),
      body: Center(child: Text('edit')),
    );
  }
}
