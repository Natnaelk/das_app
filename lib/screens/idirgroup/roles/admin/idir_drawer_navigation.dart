import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/members_page.dart';
import 'package:flutter/material.dart';
import '../member/components/payment_page.dart';
import 'components/delete.dart';
import 'components/edit.dart';
import 'components/payment_page.dart';
import 'components/requests_page.dart';
import 'idir_admin_screen.dart';

class idirDrawer extends StatefulWidget {
  String idir;
  List members;

  idirDrawer({this.idir, this.members});

  initState() {
    String idirs = idir;
    List member = members;
  }

  @override
  State<idirDrawer> createState() => _idirDrawerState();
}

class _idirDrawerState extends State<idirDrawer> {
  @override
  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance.collection('users');
    });
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        AppBar(title: Text('Hello Admin!')),
        Divider(),
        buildMenuItem(
          text: 'Home',
          icon: Icons.home,
          press: () => SelectedItem(context, 0, widget.idir, widget.members),
        ),
        buildMenuItem(
          text: 'members',
          icon: Icons.people,
          press: () => SelectedItem(context, 1, widget.idir, widget.members),
        ),
        buildMenuItem(
          text: 'requests',
          icon: Icons.message,
          press: () => SelectedItem(context, 2, widget.idir, widget.members),
        ),
        buildMenuItem(
          text: 'payment',
          icon: Icons.payment,
          press: () => SelectedItem(context, 3, widget.idir, widget.members),
        ),
        buildMenuItem(
          text: 'edit',
          icon: Icons.edit,
          press: () => SelectedItem(context, 4, widget.idir, widget.members),
        ),
        buildMenuItem(
          text: 'delete idir',
          icon: Icons.delete,
          press: () => SelectedItem(context, 5, widget.idir, widget.members),
        ),
      ]),
    ));
  }
}

Widget buildMenuItem(
    {@required String text, @required IconData icon, VoidCallback press}) {
  final color = kPrimaryColor;
  final hovercolor = kPrimaryColor;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hovercolor,
    onTap: press,
  );
}

void SelectedItem(BuildContext context, int index, String idir, List members) {
  Navigator.pop(context);

  switch (index) {
    case 0:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => idirAdminScreen(
                idir: idir,
                members: members,
              )));
      break;
    case 1:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              IdirAdminmembersPage(idirId: idir, members: members)));
      break;
    case 2:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AdminrequestsPage(
                idirId: idir,
                members: members,
              )));
      break;

    case 3:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              IdirAdminpaymentPage(idirId: idir, members: members)));
      break;

    case 4:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              IdirAdmineditPage(idirId: idir, members: members)));
      break;
    case 5:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              IdirAdmindeletePage(idirId: idir, members: members)));
      break;
  }
}
