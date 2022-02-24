import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscarUsuarioWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(

      children: [
        Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.65,
              child:
              TextField(
                decoration: InputDecoration(
                    labelText: "Buscar Usuario",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.blue)),
                  filled: true,
                ),

              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.search),
                  label: Text("Buscar")),
            )
          ],
        )
      ],
    ),
  );
}
