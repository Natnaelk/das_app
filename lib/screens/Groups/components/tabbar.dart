// import 'package:das_app/constants.dart';
// import 'package:flutter/material.dart';

// class GroupScreenTabBar extends StatefulWidget {
//   @override
//   _GroupScreenTabBarState createState() => _GroupScreenTabBarState();
// }

// class _GroupScreenTabBarState extends State<GroupScreenTabBar>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TabBar(
//               padding: EdgeInsets.only(left: 10),
//               isScrollable: true,
//               indicatorColor: kPrimaryColor,
//               indicatorWeight: 3,
//               labelPadding: EdgeInsets.symmetric(horizontal: 50),
//               labelColor: kPrimaryColor,
//               unselectedLabelColor: kSecondaryColor,
//               tabs: [
//                 Tab(
//                   child: Container(
//                       child: Text(
//                     'My Iqubs',
//                     style: TextStyle(fontSize: 15),
//                   )),
//                 ),
//                 Tab(
//                   child: Container(
//                       child: Text(
//                     'My Idirs',
//                     style: TextStyle(fontSize: 15),
//                   )),
//                 )
//               ],
//               controller: _tabController,
//               indicatorSize: TabBarIndicatorSize.tab,
//             ),
//             Column(children: <Widget>[
//               TabBarView(
//                 children: [
//                   Container(child: Center(child: Text('people'))),
//                   Text('Person')
//                 ],
//                 controller: _tabController,
//               ),
//             ])
//           ],
//         ),
//       ),
//     );
//   }
// }
