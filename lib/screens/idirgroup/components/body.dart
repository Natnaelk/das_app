import 'package:das_app/screens/idirgroup/components/create_idir_form.dart';
import 'package:das_app/screens/idirgroup/components/created_idir_list.dart';
import 'package:das_app/screens/idirgroup/components/joined_idir_list.dart';
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
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: getProportionateScreenWidth(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Created Idirs"),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CreateIdirForm.routeName);
                  },
                  color: kPrimaryColor,
                  child: Text("Create Idir")),
            ],
          ),
          CreatedIdir(),
          SizedBox(
            height: getProportionateScreenWidth(3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Joined Idirs"),
              FlatButton(
                  onPressed: () {},
                  color: kPrimaryColor,
                  child: Text("Join Idir")),
            ],
          ),
          JoinedIdir(),
        ],
      ),
    );
  }
}
