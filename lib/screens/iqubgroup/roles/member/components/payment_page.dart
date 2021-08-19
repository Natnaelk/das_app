import 'package:flutter/material.dart';
import '../iqub_member_drawer_navigation.dart';

class MemberpaymentPage extends StatelessWidget {
  const MemberpaymentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubMemberDrawer(),
      appBar: AppBar(
        title: Text("payment"),
      ),
      body: Center(child: Text('payment')),
    );
  }
}
