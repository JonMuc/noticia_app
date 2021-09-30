// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DrawerWidget extends StatefulWidget{
//   @override
//   _DrawerWidget createState() => _DrawerWidget();
// }
//
// class _DrawerWidget extends State<DrawerWidget>{
//   late ScrollController _scrollViewController;
//   late TabController _tabController;
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//
//       actions: [
//         Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () => Scaffold.of(context).openEndDrawer(),
//             tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//           ),
//         ),
//       ],
//       title: Container(
//         height: 20,
//         child: new Text("Noticias APP"),
//       ),
//       pinned: true,                       //<-- pinned to true
//       floating: true,                     //<-- floating to true
//       forceElevated: innerBoxIsScrolled,  //<-- forceElevated to innerBoxIsScrolled
//       bottom: new TabBar(
//         tabs: <Tab>[
//           new Tab(
//             text: "STATISTICS",
//             icon: new Icon(Icons.show_chart),
//           ),
//           new Tab(
//             text: "HISTORY",
//             icon: new Icon(Icons.history),
//           ),
//         ],
//         controller: _tabController,
//       ),
//     );
//   }
// }
