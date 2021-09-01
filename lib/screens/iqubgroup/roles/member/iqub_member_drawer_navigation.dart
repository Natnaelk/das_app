import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/roles/member/components/leave_page.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_screen.dart';
import 'package:flutter/material.dart';
import '../member/components/payment_page.dart';
import 'components/members_page.dart';
import 'components/payment_page.dart';

class IqubMemberDrawer extends StatefulWidget {
  String iqub;
  List members;

  IqubMemberDrawer({this.iqub, this.members});

  @override
  State<IqubMemberDrawer> createState() => _IqubDrawerState();
}

class _IqubDrawerState extends State<IqubMemberDrawer> {
  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        AppBar(title: Text('Hello Member!')),
        Divider(),
        buildMenuItem(
          text: 'Home',
          icon: Icons.home,
          press: () => SelectedItem(context, 0, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'members',
          icon: Icons.people,
          press: () => SelectedItem(context, 1, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'payment',
          icon: Icons.message,
          press: () => SelectedItem(context, 2, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'leave',
          icon: Icons.payment,
          press: () => SelectedItem(context, 3, widget.iqub, widget.members),
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

void SelectedItem(BuildContext context, int index, String iqub, List members) {
  Navigator.pop(context);

  switch (index) {
    case 0:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => iqubMemberScreen(
                iqub: iqub,
                members: members,
              )));
      break;
    case 1:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ViewMembersPage(iqubId: iqub, members: members)));
      break;

    case 2:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              MemberpaymentPage(iqubId: iqub, members: members)));
      break;

    case 3:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              MemberLeavePage(iqubId: iqub, members: members)));
      break;
  }
}
