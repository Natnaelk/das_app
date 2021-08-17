import 'package:das_app/models/user_model.dart';
import 'package:das_app/screens/idirgroup/components/search_field.dart';
import 'package:das_app/screens/iqubgroup/components/create_iqub_form.dart';
import 'package:das_app/screens/iqubgroup/components/created_iqub_list.dart';
import 'package:das_app/screens/iqubgroup/components/joined_iqub_list.dart';
import 'package:das_app/screens/iqubgroup/components/search_field.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (10)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Created iqubs"),
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateIqubForm.routeName);
                    },
                    color: kPrimaryColor,
                    child: const Text("Create iqub")),
              ],
            ),
            CreatedIqub(),
            SizedBox(
              height: (40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Joined iqubs"),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IqubSearchField()),
                      );
                    },
                    color: kPrimaryColor,
                    child: const Text("Join iqub")),
              ],
            ),
            JoinedIqub(),
          ],
        ),
      ),
    );
  }
}
