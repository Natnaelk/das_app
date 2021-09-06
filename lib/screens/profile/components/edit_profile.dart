import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/profile/components/profile_details.dart';
import 'package:das_app/screens/profile/components/profile_pic.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key key}) : super(key: key);

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void _updateUser(BuildContext context, String uid, String phone, String email,
      String fName, String lName, String address) async {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    try {
      String result = await DatabaseService()
          .editUserData(uid, email, address, phone, fName, lName);

      const SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text("Profile updated successfully"),
        duration: Duration(seconds: 5),
      );
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfileDetailsScreen()));
    } catch (e) {
      SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
      );
    }
  }

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
            return const Text('Loading...');
          } else {
            var document = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Profile'),
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  // const Center(
                  //   child: ProfilePic(),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                          hintText: document['firstName'],
                          labelText: 'First Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          hintText: document['lastName'],
                          labelText: 'Last Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                          hintText: document['address'],
                          labelText: 'Address',
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: document['phone'],
                          labelText: 'Phone',
                          floatingLabelBehavior: FloatingLabelBehavior.always)),
                  const SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                      color: kPrimaryColor,
                      onPressed: () {
                        _updateUser(
                            context,
                            currentUid,
                            phoneController.text.isNotEmpty
                                ? phoneController.text
                                : document['phone'],
                            emailController.text.isNotEmpty
                                ? emailController.text
                                : document['email'],
                            firstNameController.text.isNotEmpty
                                ? firstNameController.text
                                : document['firstName'],
                            lastNameController.text.isNotEmpty
                                ? lastNameController.text
                                : document['lastName'],
                            addressController.text.isNotEmpty
                                ? addressController.text
                                : document['address']);
                      },
                      child: const Text('Update'))
                ],
              )),
            );
          }
        });
  }
}
