import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/draw_lot.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/members_page.dart';
import 'package:flutter/material.dart';
import '../member/components/payment_page.dart';
import 'components/delete.dart';
import 'components/edit.dart';
import 'components/payment_page.dart';
import 'components/requests_page.dart';
import 'iqub_admin_screen.dart';

class IqubDrawer extends StatefulWidget {
  String iqub;
  List members;
  List paidMembers;
  IqubDrawer({this.iqub, this.members, this.paidMembers});

  // initState() {
  //   String iqubs = iqub;
  //   List member = members;
  //   List paidMemberss = paidMembers;
  // }

  @override
  State<IqubDrawer> createState() => _IqubDrawerState();
}

class _IqubDrawerState extends State<IqubDrawer> {
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
          press: () => SelectedItem(context, 0, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'members',
          icon: Icons.people,
          press: () => SelectedItem(context, 1, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'requests',
          icon: Icons.message,
          press: () => SelectedItem(context, 2, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'payment',
          icon: Icons.payment,
          press: () => SelectedItem(context, 3, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'edit',
          icon: Icons.edit,
          press: () => SelectedItem(context, 4, widget.iqub, widget.members),
        ),
        buildMenuItem(
          text: 'draw lot',
          icon: Icons.sports_tennis_rounded,
          press: () =>
              SelectedItem(context, 5, widget.iqub, widget.paidMembers),
        ),
        buildMenuItem(
          text: 'delete iqub',
          icon: Icons.delete,
          press: () => SelectedItem(context, 6, widget.iqub, widget.members),
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
          builder: (context) => iqubAdminScreen(
                iqub: iqub,
                members: members,
              )));
      break;
    case 1:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              AdminmembersPage(iqubId: iqub, members: members)));
      break;
    case 2:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AdminrequestsPage(
                iqubId: iqub,
                members: members,
              )));
      break;

    case 3:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              AdminpaymentPage(iqubId: iqub, members: members)));
      break;

    case 4:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AdmineditPage(iqubId: iqub, members: members)));
      break;
    case 5:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DrawLot(iqubid: iqub, members: members)));
      break;
    case 6:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              AdmindeletePage(iqubId: iqub, members: members)));
      break;
  }
}
