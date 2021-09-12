import 'package:app/views/widgerts/modal-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndDrawerWidget extends StatefulWidget{
  @override
  _EndDrawerWidget createState() => _EndDrawerWidget();
}

class _EndDrawerWidget extends State<EndDrawerWidget>{
  @override
  Widget build(BuildContext context) {
    return Drawer(

    child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(

            radius: 50.0,
            backgroundColor: const Color(0xFF778899),
            backgroundImage:
            NetworkImage("https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
          ),
        ),

          const DrawerHeader(

            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Nagato Pain'),
          ),
          ListTile(
            title: const Text('Item 111'),
            onTap: () {
              new ModalWidget();
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
      ],

  ),
    );
  }

}
