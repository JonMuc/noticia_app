import 'package:app/views/widgerts/lista-manchetes.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuInferiorWidget extends StatefulWidget{
  @override
  _MenuInferiorWidget createState() => _MenuInferiorWidget();

}
class _MenuInferiorWidget extends State<MenuInferiorWidget>{
  @override
  Widget build(BuildContext){
    return  BottomNavigationBar(
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
    );
  }

}