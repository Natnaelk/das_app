import 'package:flutter/material.dart';

import '../iqub_drawer_navigation.dart';

class AdmindeletePage extends StatelessWidget {
  const AdmindeletePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubDrawer(),
      appBar: AppBar(
        title: Text("delete"),
      ),
      body: Center(child: Text('delete')),
    );
  }
}
