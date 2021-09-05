import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/components/idir_search_field.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_admin_screen.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // data
  TextEditingController searchEditingController = new TextEditingController();
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
          .searchByName(searchEditingController.text)
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
      duration: Duration(milliseconds: 1500),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  _joinValueInGroup(String userid, String iqubId) async {
    bool value =
        await DatabaseService(uid: userid).isUserJoined(iqubId, userid);
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
                searchResultSnapshot.docs[index].get("iqubName"),
                searchResultSnapshot.docs[index].get("iqubId"),
                searchResultSnapshot.docs[index].get("admin"),
              );
            })
        : Container();
  }

  Widget groupTile(String uid, String iqubName, String iqubId, String admin) {
    _joinValueInGroup(uid, iqubId);
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return ListTile(
      tileColor: kSecondaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: kPrimaryColor,
          child: Text(iqubName.substring(0, 1).toUpperCase(),
              style: TextStyle(color: Colors.white))),
      title: Text(iqubName, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Admin: $admin"),
      trailing: InkWell(
        onTap: () async {
          if (!_isJoined) {
            if (admin == currentUid) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => iqubAdminScreen(
                        iqub: iqubId,
                      )));
            } else {
              await DatabaseService(uid: _userid).requestjoinIqub(iqubId, uid);
              _showScaffold('request sent successfully');
              Future.delayed(Duration(milliseconds: 2000), () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              });
            }
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => iqubMemberScreen(
                      iqub: iqubId,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text('Admin', style: TextStyle(color: Colors.white)))
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kPrimaryColor,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text('Join', style: TextStyle(color: Colors.white)),
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
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              //color: kPrimaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                      decoration: InputDecoration(
                          hintText: "Search groups...",
                          hintStyle: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(width: 10),
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
                          child: Icon(Icons.search, color: Colors.white)))
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
