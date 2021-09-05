import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/idirgroup/roles/admin/idir_admin_screen.dart';
import 'package:das_app/screens/idirgroup/roles/member/idir_member_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class IdirSearchPage extends StatefulWidget {
  const IdirSearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<IdirSearchPage> {
  // data
  TextEditingController searchEditingController = TextEditingController();
  QuerySnapshot searchResultSnapshot;
  bool isLoading = false;
  bool hasUserSearched = false;
  bool _isJoined = false;
  User user;
  String _userid;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // initState()
  @override
  void initState() {
    super.initState();
    _getCurrentUserNameAndUid();
  }

  // functions
  _getCurrentUserNameAndUid() {
    _userid = FirebaseAuth.instance.currentUser.uid;
  }

  _initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService()
          .searchIdirByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        //print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: kPrimaryColor,
      duration: const Duration(milliseconds: 1500),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  _joinValueInGroup(String userid, String idirId) async {
    bool value =
        await DatabaseService(uid: userid).isUserJoined(idirId, userid);
    setState(() {
      _isJoined = value;
    });
  }

  // widgets
  Widget groupList() {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                currentUid,
                searchResultSnapshot.docs[index].get("idirName"),
                searchResultSnapshot.docs[index].get("idirId"),
                searchResultSnapshot.docs[index].get("admin"),
              );
            })
        : Container();
  }

  Widget groupTile(String uid, String idirName, String idirId, String admin) {
    _joinValueInGroup(uid, idirId);
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return ListTile(
      tileColor: kSecondaryColor,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: kPrimaryColor,
          child: Text(idirName.substring(0, 1).toUpperCase(),
              style: const TextStyle(color: Colors.white))),
      title:
          Text(idirName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Admin: $admin"),
      trailing: InkWell(
        onTap: () async {
          if (!_isJoined) {
            if (admin == currentUid) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => idirAdminScreen(
                        idir: idirId,
                      )));
            } else {
              await DatabaseService(uid: _userid).requestjoinIdir(idirId, uid);
              _showScaffold('request sent successfully');
              Future.delayed(const Duration(milliseconds: 2000), () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              });
            }
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => idirMemberScreen(
                      idir: idirId,
                    )));
          }
        },
        child: !_isJoined
            ? admin == currentUid
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black87,
                        border: Border.all(color: Colors.white, width: 1.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text('Admin',
                        style: TextStyle(color: Colors.white)))
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kPrimaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text('Join',
                        style: TextStyle(color: Colors.white)),
                  )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black87,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text('Joined', style: TextStyle(color: Colors.white)),
              ),
      ),
    );
  }

  // building the search page widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Search',
            style: TextStyle(fontSize: 21.0, color: kSecondaryColor)),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              //color: kPrimaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      style: const TextStyle(
                        color: kPrimaryColor,
                      ),
                      decoration: const InputDecoration(
                          hintText: "Search groups...",
                          hintStyle: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        _initiateSearch();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(40)),
                          child: const Icon(Icons.search, color: Colors.white)))
                ],
              ),
            ),
            isLoading
                ? Container(child: Center(child: CircularProgressIndicator()))
                : groupList()
          ],
        ),
      ),
    );
  }
}
