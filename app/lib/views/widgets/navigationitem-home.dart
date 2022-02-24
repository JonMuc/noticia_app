import 'package:app_noticia/views/widgets/lista-manchetes.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuInferiorWidget extends StatefulWidget{
  @override
  _MenuInferiorWidget createState() => _MenuInferiorWidget();

}
class _MenuInferiorWidget extends State<MenuInferiorWidget>{
  ScrollController _scrollViewController;
  // TabController _tabController;
  // @override

  // void initState() {
  //   // usuarioLogado = null;
  //   //startTime();
  //   //TODO - ONESIGNAL
  //   // OneSignal.shared.getDeviceState().then((deviceState) {
  //   //   final userId = deviceState.userId;
  //   //   print("idPush:" + userId);
  //   //   //print("OneSignal: device state: ${deviceState.jsonRepresentation()}");
  //   // });
  //   super.initState();
  //   //   _scrollViewController = new ScrollController();
  //   //   _tabController = new TabController(length: 2);
  // }

  @override
  Widget build(BuildContext context){
    // return NestedScrollView(
      // controller: _scrollViewController,
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return <Widget>[
//           new SliverAppBar(
//             actions: [
//               Builder(
//                 builder: (context) => IconButton(
//                   icon: Icon(Icons.person),
//                   onPressed: () => Scaffold.of(context).openEndDrawer(),
//                   tooltip:
//                   MaterialLocalizations.of(context).openAppDrawerTooltip,
//                 ),
//               ),
//             ],
//             title: Container(
// // height: 20,
//               child: new Text("WNews"),
//             ),
//             pinned: true, //<-- pinned to true
//             floating: true, //<-- floating to true
//             forceElevated: innerBoxIsScrolled, //<-- forceElevated to innerBoxIsScrolled
// //             bottom: new TabBar(
// //               tabs: <Tab>[
// //                 new Tab(
// //                   text: "Notícias",
// // // icon: new Icon(Icons.show_chart),
// //                 ),
// //                 new Tab(
// //                   text: "Atividades",
// // // icon: new Icon(Icons.history),
// //                 ),
// //               ],
// //               // controller: _tabController,
// //             ),
//           ),
//         ];
//       },
      body: Column(
        children: <Widget>[
          new ListaManchetesWidget(),
          new ListaManchetesWidget(),
        ],
        // controller: _tabController,
      // ),
    );
  }
}