import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/groups/groups_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IdirSearchField extends StatefulWidget {
  const IdirSearchField({
    Key key,
  }) : super(key: key);

  @override
  State<IdirSearchField> createState() => _IdirSearchFieldState();
}

class _IdirSearchFieldState extends State<IdirSearchField> {
  void _joinIdir(BuildContext context, String idirId) async {
    try {
      AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
      String currentUid = _authStream.uid;
      await DatabaseService().joinIdir(idirId, currentUid);
      if (currentUid.isNotEmpty) {
        Navigator.pushNamed(context, GroupsScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("Idir joined successfuly"),
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

  TextEditingController infoOfIdir = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 220,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: infoOfIdir,
                    decoration: InputDecoration(
                        fillColor: kPrimaryColor.withOpacity(0.1),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Enter Idir ID",
                        prefixIcon: const Icon(
                          Icons.search,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 9)),
                  ),
                ),
                FlatButton(
                  color: kPrimaryColor,
                  onPressed: () {
                    _joinIdir(context, infoOfIdir.text);
                  },
                  child: Text('join'),
                )
              ]),
        ),
      ),
    );
  }
}
