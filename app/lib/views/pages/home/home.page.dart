import 'package:app_noticia/views/pages/home/home.controller.dart';
import 'package:app_noticia/views/widgets/lista-manchetes/lista-manchetes.widget.dart';
import 'package:app_noticia/views/widgets/menu-usuario/menu-usuario.widget.dart';
import 'package:app_noticia/views/widgets/modal.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewPage extends GetView<HomeController> {
  final List<Widget> _telas = [
    ListaManchetesWidget(),
    // BuscarUsuarioWidget(),
    // NavigationItemHome3(),
    // NavigationItemHome4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: new MenuUsuarioWidget(),
      drawer: new ModalWidget(),
      body: new NestedScrollView(
        controller: controller.scrollViewController,
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
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
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
                controller: controller.tabController,
              ),
            ),
          ];
        },
        body: _telas[controller.currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: controller.onTabTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
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
