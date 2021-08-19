import 'package:das_app/screens/iqubgroup/roles/admin/iqub_drawer_navigation.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_drawer_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class iqubMemberScreen extends StatefulWidget {
  const iqubMemberScreen({Key key}) : super(key: key);

  @override
  _iqubMemberScreenState createState() => _iqubMemberScreenState();
}

class _iqubMemberScreenState extends State<iqubMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubMemberDrawer(),
      appBar: AppBar(
        title: Text('Members Page',
            style: TextStyle(
              color: kSecondaryColor,
            )),
      ),
    );
  }
}
