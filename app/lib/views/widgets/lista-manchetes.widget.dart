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
        print("Listar noticias");
        listar(context);
      }
    }
    return Loader(
      callback: lista,
      object: noticiaList,
    );
  }

  Widget lista() {
    return Container(
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
        itemCount: noticiaList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.transparent,
          height: 0,
        ),
        itemBuilder: (BuildContext context, int index) {
          final NoticiaModel noticia = noticiaList[index];
          return Container(
            padding: EdgeInsets.only(top: 7.0, left: 7.0, right: 7.0, bottom: 7.0),
            width:  MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10,
                    child: Container(
                        width:  MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                    noticia.UrlImage == null ? 'https://e3z7c6v7.rocketcdn.me/blog/wp-content/uploads/2019/02/274034-erro-de-http-wordpress-como-corrigir.jpg' : noticia.UrlImage.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                    left: 10,
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child:Text(noticia.Titulo.toString(), style: TextStyle(fontSize: 17, color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 8.0,
                                          color: Color.fromARGB(50, 0, 0, 255),
                                        ),
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(1.0, 1.0),
                                        ),
                                      ]),
                                  ),
                                 )
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    spacing: 20,
                                    children: [
                                      IconButton(onPressed: (){},
                                          padding: EdgeInsets.all(5),                                          color: Colors.blue,
                                          icon: Icon(Icons.push_pin_sharp)
                                      ),
                                      IconButton(onPressed: (){},
                                          padding: EdgeInsets.all(5),                                          color: Colors.blue,
                                          icon: Icon(Icons.offline_share)
                                      ),
                                      IconButton(onPressed: (){},
                                          padding: EdgeInsets.all(5),                                          color: Colors.blue,
                                          icon: Icon(Icons.thumb_up_alt_rounded)
                                      ),
                                      IconButton(onPressed: (){},
                                          padding: EdgeInsets.all(5),                                          color: Colors.blue,
                                          icon: Icon(Icons.thumb_down_alt)
                                      ),
                                      IconButton(onPressed: (){
                                        print("allaa");
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (BuildContext context)
                                                => new TelaComentarioNoticia(noticiaModel: noticia)
                                            )
                                        );
                                      },
                                          padding: EdgeInsets.all(5),                                          color: Colors.blue,
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
