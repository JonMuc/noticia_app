import 'dart:async';

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
  // List<ViewNoticiaModel> noticiaList = List.empty();
  List<ViewNoticiaModel> noticiaList = List.filled(0, null, growable: true);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller;
  bool chamandoApi = false;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    if(mounted){
      if(noticiaList.isEmpty){
        listar();
      }
    }
    return Loader(
      callback: lista,
      object: noticiaList,
    );
  }

  Widget lista() {
    return Scaffold(
      key: _scaffoldKey,
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
        child:
        // ListView(
        //   controller: controller,
        //   children: [
        //     for(ViewNoticiaModel obj in noticiaList) ItemNoticiaWidget(noticiaModel: obj, notifyUsuarioNaoLogado: alertaNaoLogado,)
        //   ],
        // )
        ListView.separated(
          controller: controller,
          padding: EdgeInsets.only(top: 5),
          itemCount: noticiaList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.transparent,
          ),
          itemBuilder: (BuildContext context, int index) {
            final ViewNoticiaModel noticia = noticiaList[index];
            return ItemNoticiaWidget(noticiaModel: noticia, notifyUsuarioNaoLogado: alertaNaoLogado,);
          },
        ),
      ),
    );
  }

  void _scrollListener() {
    // print(controller.position.extentAfter);
    if (controller.position.extentAfter < 500 && !chamandoApi) {
      setState(() {
        chamandoApi = true;
      });
      listar();
    }
  }

  void listar() async {
    print(this.noticiaList.length);
    print(pageIndex);
    NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
    var listarResponse = await service.obterManchetes(pageIndex);
    removerCarregando();
    setState(() {
      pageIndex = pageIndex + 1;
      for(ViewNoticiaModel item in listarResponse){
        this.noticiaList.add(item);
      }
      // this.noticiaList.addAll(listarResponse);
      //this.noticiaList.addAll(listarResponse);
      //   this.noticiaList = listarResponse;
    });
  }

  void removerCarregando(){
    Timer(Duration(seconds: 2), () {
      setState(() {
        chamandoApi = false;
      });
    });
  }

  alertaNaoLogado(){
    final snackbar = SnackBar(
      content: Text("Faca login"),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
