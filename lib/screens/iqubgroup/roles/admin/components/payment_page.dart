import 'package:flutter/material.dart';

import '../iqub_drawer_navigation.dart';

class AdminpaymentPage extends StatelessWidget {
  const AdminpaymentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubDrawer(),
      appBar: AppBar(
        title: Text("payment"),
      ),
      body: Center(child: Text('payment')),
    );
  }
}
