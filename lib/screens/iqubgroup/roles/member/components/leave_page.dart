import 'package:flutter/material.dart';

import '../iqub_member_drawer_navigation.dart';

class MemberLeavePage extends StatelessWidget {
  const MemberLeavePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubMemberDrawer(),
      appBar: AppBar(
        title: Text("Leave"),
      ),
      body: Center(child: Text('Leave')),
    );
  }
}
