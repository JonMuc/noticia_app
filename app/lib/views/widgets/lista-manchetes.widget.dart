import 'dart:ui';
import 'package:app_noticia/models/noticia.model.dart';
import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/comentario-noticia.page.dart';
import 'package:app_noticia/views/shared/loader.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListaManchetesWidget extends StatefulWidget {
  @override
  _ListaManchetesWidget createState() => _ListaManchetesWidget();
}

class _ListaManchetesWidget extends State<ListaManchetesWidget> {
  List<NoticiaModel> noticiaList = List.empty();

  @override
  Widget build(BuildContext context) {
    if(mounted){
      if(noticiaList.isEmpty){
        listar(context);
      }
    }
    return Loader(
      callback: lista,
      object: noticiaList,
    );
  }

  Widget lista() {
    return
      Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeApp.corFundoNoticia,
              Colors.black,
            ],
          )
      ),
      child: ListView.separated(
        padding: EdgeInsets.only(top: 5),
        itemCount: noticiaList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.transparent,
        ),
        itemBuilder: (BuildContext context, int index) {
          final NoticiaModel noticia = noticiaList[index];
          return Container(
            padding: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 7.0),
            width:  MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 10,
                    child: Container(
                        width:  MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: ClipRRect(
                                    child: Image.asset("assets/logo_noticias/g1.png", width: 35,),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(noticia.Fonte, style: TextStyle(fontWeight: FontWeight.w700,),),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  child:
                                  Stack(children: <Widget>[
                                    Container(
                                      // width: 116.0,
                                      // height: 174.0,
                                      foregroundDecoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0, 0, 0.6, 1],
                                        ),
                                      ),
                                      child: Image.network(noticia.UrlImage, fit: BoxFit.cover,),
                                    )
                                  ])
                                ),
                                Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child:Text(noticia.Titulo.toString(),
                                        style: TextStyle(fontSize: 17, color: Colors.white,fontWeight: FontWeight.w600,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0.5, 0.5),
                                              blurRadius: 10.0,
                                              color: Colors.black,
                                              // color: Color.fromARGB(50, 0, 0, 255),
                                            ),
                                            Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.black,
                                              offset: Offset(0.5, 0.5),
                                            ),
                                          ]
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                // alignment: WrapAlignment.spaceBetween,
                                // spacing: 20,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: IconButton(onPressed: (){},
                                        // padding: EdgeInsets.only(left: 5, right: 5),
                                        color: Colors.blue,
                                        icon: Icon(Icons.thumb_up_alt_rounded)
                                    ),
                                  ),
                                  IconButton(onPressed: (){},
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      color: Colors.blue,
                                      icon: Icon(Icons.thumb_down_alt)
                                  ),
                                  IconButton(onPressed: (){},
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      color: Colors.blue,
                                      icon: Icon(Icons.push_pin_sharp)
                                  ),
                                  IconButton(onPressed: (){},
                                      padding: EdgeInsets.only(left: 5, right: 5),
                                      color: Colors.blue,
                                      icon: Icon(Icons.offline_share)
                                  ),
                                  IconButton(onPressed: (){
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context)
                                          // => new TelaComentarioNoticia()
                                          => new TelaComentarioNoticia(noticiaModel: noticia)
                                      ),
                                    );
                                  },
                                      padding: EdgeInsets.all(5), color: Colors.blue,
                                      icon: Icon(Icons.comment_rounded)
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  void listar(BuildContext context) async {
    //print("entrouu");
    NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
    var listarResponse = await service.obterManchetes();
    print(listarResponse.length);
    if(mounted){
      setState(() {
        this.noticiaList = listarResponse;
      });
    }
  }
}
