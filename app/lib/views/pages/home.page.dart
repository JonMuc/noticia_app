import 'package:app/services/noticia.service.dart';
import 'package:app/themes/style_app.dart';
import 'package:app/views/widgerts/lista-manchetes.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  // UsuarioModel usuarioLogado;
  late ScrollController _scrollViewController;
  late TabController _tabController;


  @override
  void initState() {
    // usuarioLogado = null;
   //startTime();

    //super.initState();
    //_tabController = TabController(vsync: this, length: 2);
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  startTime() async {
    print(2);
    NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
    var asd = service.obterManchetes();
  }

  // route() {
  //   if (this.usuarioLogado != null) {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  //   } else {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    print(1);
    //tartTime();
    return Scaffold(
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { //<-- headerSliverBuilder
            return <Widget>[
              new SliverAppBar(
                title: Container(
                  height: 20,
                  child: new Text("CCN"),
                ),
                pinned: true,                       //<-- pinned to true
                floating: true,                     //<-- floating to true
                forceElevated: innerBoxIsScrolled,  //<-- forceElevated to innerBoxIsScrolled
                bottom: new TabBar(
                  tabs: <Tab>[
                    new Tab(
                      text: "STATISTICS",
                      icon: new Icon(Icons.show_chart),
                    ),
                    new Tab(
                      text: "HISTORY",
                      icon: new Icon(Icons.history),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              new ListaManchetesWidget(),
              new ListaManchetesWidget(),
            ],
            controller: _tabController,
          ),
        ),
        //floatingActionButton: [...]
    );
  }



  // @override
  // Widget build(BuildContext context) {
  //   print(1);
  //   //tartTime();
  //   return Scaffold(
  //     body: DefaultTabController(
  //       length: 2,
  //       child: Scaffold(
  //         appBar: AppBar(
  //           toolbarOpacity: 0.0,
  //           backgroundColor: ThemeApp.btnLoginEscuro,
  //           flexibleSpace: TabBar(
  //               // controller: _tabController,
  //               indicatorColor: Colors.white,
  //               tabs: [
  //                 Tab(
  //                   child: Text("Manchetes",style: TextStyle(color: Colors.white),),
  //                 ),Tab(
  //                   child: Text("Exterior",style: TextStyle(color: Colors.white),),
  //                 )
  //               ]),
  //         ),
  //         body: TabBarView(
  //           // controller: _tabController,
  //           children: [
  //             Scaffold(
  //               body: ListaManchetesWidget(),
  //             ),
  //             Scaffold(
  //               // body: ConvocacoesAprovadasWidget(),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // void navegarParaHome(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomePage()),
  //   );
  // }

}
