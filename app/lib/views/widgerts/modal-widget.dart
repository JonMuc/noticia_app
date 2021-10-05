import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ModalWidget extends StatefulWidget{
  @override
  _ModalWidget createState() => _ModalWidget();
}

class _ModalWidget extends State<ModalWidget>{
  @override
  Widget build(BuildContext context){
    return Dialog(
      backgroundColor: Colors.transparent,
      //clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: 350),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.cancel, color: Colors.red, size: 25,))
              ],
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: "nagato pain \n\n Uchiha Madara \n\n Sasori \n\n deydara \n\n kisame \n\n kakuzu \n\n konan \n\n tobi \n\n hidan",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white,
                    wordSpacing: 1,

                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}