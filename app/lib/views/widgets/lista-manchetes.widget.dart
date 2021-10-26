
import 'package:app/models/noticia.model.dart';
import 'package:app/services/noticia.service.dart';
import 'package:app/themes/style_app.dart';
import 'package:app/views/shared/loader.widget.dart';
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
        print(111111);

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
      // color: Colors.blue,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Colors.white10,
              // Colors.deepPurple,
              ThemeApp.corFundoNoticia,
              Colors.black,
              // Colors.brown
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
                    color: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 10,
                    child: Container(
                      width:  MediaQuery.of(context).size.width,
                      //padding: EdgeInsets.only(top: 10, right: 10, left: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.network(
                                      noticia.UrlImage == null ? 'https://e3z7c6v7.rocketcdn.me/blog/wp-content/uploads/2019/02/274034-erro-de-http-wordpress-como-corrigir.jpg' : noticia.UrlImage.toString(),
                                      width: 280.0,
                                    ) ,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(noticia.Titulo.toString(), style: TextStyle(fontSize: 17, color: Colors.white,
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
                                            ]),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(noticia.HoraAtras.toString(), style: TextStyle(fontSize: 12.5,color: Colors.white, fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400))
                                  )
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(noticia.Fonte.toString(), style: TextStyle(fontSize: 12.5,color: Colors.white,
                                        fontWeight: FontWeight.w500),)
                                ),
                              )
                            ],
                          )

                          // Row(
                          //   children: <Widget>[
                          //     Text(noticia.HoraAtras.toString(), style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                          //     Align(
                          //       alignment: Alignment.centerRight,
                          //       child: Text(noticia.Fonte.toString(), style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                          //     )
                          //
                          //   ],
                          // ),
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
    print("entrouu");
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
