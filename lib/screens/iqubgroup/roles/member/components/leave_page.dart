import 'package:das_app/models/auth_model.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';
import '../iqub_member_screen.dart';

class MemberLeavePage extends StatelessWidget {
  final String iqubId;
  final List members;
  const MemberLeavePage({Key key, this.iqubId, this.members}) : super(key: key);

  void _leaveIqub(
      BuildContext context, String iqubId, String currentUid) async {
    try {
      await DatabaseService().leaveIqub(iqubId, currentUid);
      if (iqubId.isNotEmpty) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("Iqub Left successfuly"),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("error"),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return Scaffold(
        body: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Column(children: <Widget>[
            const SizedBox(
              height: 270,
            ),
            const Text("Are you sure you want to leave this iqub?"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _leaveIqub(context, iqubId, currentUid);
                  },
                  color: Colors.green,
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 40)),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => iqubMemberScreen(
                              iqub: iqubId,
                              members: members,
                            )));
                  },
                  color: Colors.red,
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ])
        ])));
  }
}
