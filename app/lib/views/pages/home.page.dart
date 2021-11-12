import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/views/widgets/fazer-login.widget.dart';
import 'package:app_noticia/views/widgets/lista-manchetes.widget.dart';
import 'package:app_noticia/views/widgets/menu-inferior.widget.dart';
import 'package:app_noticia/views/widgets/modal.widget.dart';
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
    print("StartTime Noticia Service");
    NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
    var asd = service.obterManchetes();
  }

  @override
  Widget build(BuildContext context) {
    print("Home Page");
    //tartTime();
    return Scaffold(
      endDrawer:
      new FazerLoginWidget(),
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificacao',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.push_pin_sharp),
            label: 'Favorito',
            backgroundColor: Colors.pink,
          ),
        ],
        selectedItemColor: Colors.white,
      ),


      // BottomNavigationBar(
      //   backgroundColor: Colors.blue,
      //   items:
      //   const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "kaaaaaka"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.vpn_lock_rounded),
      //         label: "kaka"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.notifications),
      //         label: "kaka"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.push_pin_sharp),
      //         label: "kaaaaka"
      //     ),
      //   ],
      //   //currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.orange,
      //   //onTap: _onItemTapped,
      // ),
    );
  }

}

