import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/members_page.dart';
import 'package:flutter/material.dart';
import '../member/components/payment_page.dart';
import 'components/delete.dart';
import 'components/edit.dart';
import 'components/payment_page.dart';
import 'components/requests_page.dart';
import 'iqub_admin_screen.dart';

class IqubDrawer extends StatelessWidget {
  String iqub;
  IqubDrawer({this.iqub});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        AppBar(title: Text('Hello Admin!')),
        Divider(),
        buildMenuItem(
          text: 'Home',
          icon: Icons.home,
          press: () => SelectedItem(context, 0, iqub),
        ),
        buildMenuItem(
          text: 'members',
          icon: Icons.people,
          press: () => SelectedItem(context, 1, iqub),
        ),
        buildMenuItem(
          text: 'requests',
          icon: Icons.message,
          press: () => SelectedItem(context, 2, iqub),
        ),
        buildMenuItem(
          text: 'payment',
          icon: Icons.payment,
          press: () => SelectedItem(context, 3, iqub),
        ),
        buildMenuItem(
          text: 'edit',
          icon: Icons.edit,
          press: () => SelectedItem(context, 4, iqub),
        ),
        buildMenuItem(
          text: 'delete iqub',
          icon: Icons.delete,
          press: () => SelectedItem(context, 5, iqub),
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

void SelectedItem(BuildContext context, int index, String iqub) {
  Navigator.pop(context);
  switch (index) {
    case 0:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => iqubAdminScreen()));
      break;
    case 1:
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AdminmembersPage(
                iqubId: iqub,
              )));
      break;
    case 2:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminrequestsPage()));
      break;

    case 3:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminpaymentPage()));
      break;

    case 4:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdmineditPage()));
      break;

    case 5:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdmindeletePage()));
      break;
  }
}
