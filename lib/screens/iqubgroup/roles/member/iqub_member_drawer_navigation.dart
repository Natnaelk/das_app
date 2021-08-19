import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/roles/member/components/members_page.dart';
import 'package:flutter/material.dart';
import 'components/payment_page.dart';
import 'components/leave_page.dart';
import 'iqub_member_screen.dart';

class IqubMemberDrawer extends StatelessWidget {
  const IqubMemberDrawer({Key key}) : super(key: key);

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
          press: () => SelectedItem(context, 0),
        ),
        buildMenuItem(
          text: 'members',
          icon: Icons.people,
          press: () => SelectedItem(context, 1),
        ),
        buildMenuItem(
          text: 'payment',
          icon: Icons.message,
          press: () => SelectedItem(context, 2),
        ),
        buildMenuItem(
          text: 'leave iqub',
          icon: Icons.leave_bags_at_home,
          press: () => SelectedItem(context, 2),
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

void SelectedItem(BuildContext context, int index) {
  Navigator.pop(context);
  switch (index) {
    case 0:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => iqubMemberScreen()));
      break;
    case 1:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MembersPage()));
      break;
    case 2:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MemberpaymentPage()));
      break;
    case 3:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MemberLeavePage()));
      break;
  }
}
