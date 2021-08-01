import 'package:das_app/screens/iqubgroup/components/create_iqub_form.dart';
import 'package:das_app/screens/iqubgroup/components/created_iqub_list.dart';
import 'package:das_app/screens/iqubgroup/components/joined_iqub_list.dart';
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
              Text("Created iqubs"),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CreateIqubForm.routeName);
                  },
                  color: kPrimaryColor,
                  child: Text("Create iqub")),
            ],
          ),
          CreatedIqub(),
          SizedBox(
            height: getProportionateScreenWidth(3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Joined iqubs"),
              FlatButton(
                  onPressed: () {},
                  color: kPrimaryColor,
                  child: Text("Join iqub")),
            ],
          ),
          JoinedIqub(),
        ],
      ),
    );
  }
}
