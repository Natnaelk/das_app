import 'package:das_app/components/custom_bottom_nav_bar.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/enums.dart';
import 'package:das_app/screens/Groups/components/body.dart';
import 'package:das_app/screens/groups/components/search_field.dart';
import 'package:das_app/screens/groups/components/tabbar.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/groups_screen_app_bar.dart';

class GroupsScreen extends StatelessWidget {
  static var routeName = '/groups';

  const GroupsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Groups"),
            actions: [
              GroupsAppBar(),
            ],
            bottom: TabBar(
              padding: EdgeInsets.only(left: 10),
              isScrollable: true,
              indicatorColor: kPrimaryColor,
              indicatorWeight: 3,
              labelPadding: EdgeInsets.symmetric(horizontal: 50),
              labelColor: kPrimaryColor,
              unselectedLabelColor: kSecondaryColor,
              tabs: [
                Tab(
                  child: Container(
                      child: Text(
                    'My Iqubs',
                    style: TextStyle(fontSize: 15),
                  )),
                ),
                Tab(
                  child: Container(
                      child: Text(
                    'My Idirs',
                    style: TextStyle(fontSize: 15),
                  )),
                )
              ],
            )),
        body: Body(),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.groups),
      ),
    );
  }
}
