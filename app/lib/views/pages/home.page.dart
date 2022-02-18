import 'package:app_noticia/views/widgets/lista-manchetes.widget.dart';
import 'package:app_noticia/views/widgets/menu-usuario.widget.dart';
import 'package:app_noticia/views/widgets/modal.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {

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
    //TODO - ONESIGNAL
    // OneSignal.shared.getDeviceState().then((deviceState) {
    //   final userId = deviceState.userId;
    //   print("idPush:" + userId);
    //   //print("OneSignal: device state: ${deviceState.jsonRepresentation()}");
    // });
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // startTime() async {
  //   NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
  //   var asd = service.obterManchetes();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      endDrawer: new MenuUsuario(),
      drawer: new ModalWidget(),
      body: new NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
              title: Container(
                // height: 20,
                child: new Text("WNews"),
              ),
              pinned: true, //<-- pinned to true
              floating: true, //<-- floating to true
              forceElevated: innerBoxIsScrolled, //<-- forceElevated to innerBoxIsScrolled
              bottom: new TabBar(
                tabs: <Tab>[
                  new Tab(
                    text: "Notícias",
                    // icon: new Icon(Icons.show_chart),
                  ),
                  new Tab(
                    text: "Atividades",
                    // icon: new Icon(Icons.history),
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
    );
  }
}
