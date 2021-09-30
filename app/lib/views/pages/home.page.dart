import 'package:app/services/noticia.service.dart';
import 'package:app/views/widgerts/endDrawer-widget.dart';
import 'package:app/views/widgerts/lista-manchetes.widget.dart';
import 'package:app/views/widgerts/modal-widget.dart';
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
  ScrollController _scrollViewController;
  TabController _tabController;


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

  @override
  Widget build(BuildContext context) {
    print(1);
    //tartTime();
    return Scaffold(
      endDrawer:
      new EndDrawerWidget(),
      drawer:
      new ModalWidget(),
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { //<-- headerSliverBuilder
          return <Widget>[
            new SliverAppBar(
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
              title: Container(

                height: 20,
                child: new Text("Noticias APP"),
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
      bottomNavigationBar:
      //new MenuInferiorWidget(),
      BottomNavigationBar(
        backgroundColor: Colors.blue,
        items:
        const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_lock_rounded),
            label: 'World',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore_rounded),
            label: 'Pesquisar',
          ),

        ],
        //currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        //onTap: _onItemTapped,
      ),
    );
  }

}

