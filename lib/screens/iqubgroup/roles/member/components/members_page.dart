import 'package:das_app/screens/iqubgroup/roles/admin/iqub_drawer_navigation.dart';
import 'package:flutter/material.dart';

import '../iqub_member_drawer_navigation.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubMemberDrawer(),
      appBar: AppBar(
        title: Text("members"),
      ),
      body: Center(child: Text('members')),
    );
  }
}
