import 'package:das_app/components/default_button.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/services/idir_image_picker.dart';
import 'package:das_app/services/iqub_image_picker.dart';
import 'package:das_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../iqub_member_drawer_navigation.dart';

class MemberpaymentPage extends StatelessWidget {
  String iqubId;
  List members;
  MemberpaymentPage({this.iqubId, this.members});

  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    return Scaffold(
      drawer: IqubMemberDrawer(
        iqub: iqubId,
        members: members,
      ),
      appBar: AppBar(
        title: Text("payment"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            children: <Widget>[
              IqubUserImagePicker(iqubid: iqubId),
              SizedBox(height: 10),
            ],
          )),
    );
  }
}
