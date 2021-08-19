import 'package:flutter/material.dart';

import '../iqub_drawer_navigation.dart';

class AdmineditPage extends StatelessWidget {
  const AdmineditPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: IqubDrawer(),
      appBar: AppBar(
        title: Text("edit"),
      ),
      body: Center(child: Text('edit')),
    );
  }
}
