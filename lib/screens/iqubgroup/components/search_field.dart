import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/groups/groups_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IqubSearchField extends StatefulWidget {
  const IqubSearchField({
    Key key,
  }) : super(key: key);

  @override
  State<IqubSearchField> createState() => _IqubSearchFieldState();
}

class _IqubSearchFieldState extends State<IqubSearchField> {
  void _requestjoinIqub(BuildContext context, String groupId) async {
    try {
      AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
      String currentUid = _authStream.uid;
      await DatabaseService().requestjoinIqub(
        groupId,
        currentUid,
      );
      if (currentUid.isNotEmpty) {
        Navigator.pushNamed(context, GroupsScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("Iqub joined successfuly"),
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

  TextEditingController infoOfIqub = TextEditingController();

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
                    controller: infoOfIqub,
                    decoration: InputDecoration(
                        fillColor: kPrimaryColor.withOpacity(0.1),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Enter Iqub ID",
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
                    _requestjoinIqub(context, infoOfIqub.text);
                  },
                  child: Text('join'),
                )
              ]),
        ),
      ),
    );
  }
}
