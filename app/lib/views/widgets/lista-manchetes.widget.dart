import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/views/shared/loader.widget.dart';
import 'package:app_noticia/views/widgets/item-noticia.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ListaManchetesWidget extends StatefulWidget {
  @override
  _ListaManchetesWidget createState() => _ListaManchetesWidget();
}

class _ListaManchetesWidget extends State<ListaManchetesWidget> {
  List<ViewNoticiaModel> noticiaList = List.empty();

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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white10.withOpacity(0.1),
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
            final ViewNoticiaModel noticia = noticiaList[index];
            return ItemNoticiaWidget(noticiaModel: noticia);
          },
        ),
      ),
    );
  }



  void listar(BuildContext context) async {
    NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
    var listarResponse = await service.obterManchetes();
    if(mounted){
      setState(() {
        this.noticiaList = listarResponse;
      });
    }
  }
}
