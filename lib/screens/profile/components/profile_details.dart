import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/profile/components/edit_profile.dart';
import 'package:das_app/screens/profile/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({Key key}) : super(key: key);

  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          } else {
            var document = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditUserProfile()));
                    },
                    icon: Icon(Icons.edit),
                    color: kPrimaryColor,
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ProfilePic(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'First Name',
                          style:
                              TextStyle(fontSize: 20, color: kSecondaryColor),
                        ),
                        Text(
                          document['firstName'],
                          style: TextStyle(fontSize: 20, color: kPrimaryColor),
                        )
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Last Name',
                          style:
                              TextStyle(fontSize: 20, color: kSecondaryColor),
                        ),
                        Text(
                          document['lastName'],
                          style: TextStyle(fontSize: 20, color: kPrimaryColor),
                        )
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Email',
                          style:
                              TextStyle(fontSize: 20, color: kSecondaryColor),
                        ),
                        Text(
                          document['email'],
                          style: TextStyle(fontSize: 20, color: kPrimaryColor),
                        ),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Address',
                          style:
                              TextStyle(fontSize: 20, color: kSecondaryColor),
                        ),
                        Text(
                          document['address'],
                          style: TextStyle(fontSize: 20, color: kPrimaryColor),
                        ),
                      ]),
                ],
              )),
            );
          }
        });
  }
}
