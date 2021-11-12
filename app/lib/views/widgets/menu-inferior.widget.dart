import 'package:app_noticia/views/widgets/lista-manchetes.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuInferiorWidget extends StatefulWidget{
  @override
  _MenuInferiorWidget createState() => _MenuInferiorWidget();

}
class _MenuInferiorWidget extends State<MenuInferiorWidget>{
  @override
  Widget build(BuildContext){
    return BottomNavigationBar(
      backgroundColor: Colors.red,
      items:
      const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "kaaaaaka"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.vpn_lock_rounded),
            label: "kaka"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
            label: "kaka"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.push_pin_sharp),
            label: "kaaaaka"
        ),
      ],
      //currentIndex: _selectedIndex,
      selectedItemColor: Colors.orange,
      //onTap: _onItemTapped,
    );
  }
}