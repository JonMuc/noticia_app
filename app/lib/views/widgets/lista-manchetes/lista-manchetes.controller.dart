import 'dart:async';
import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaMancheteController extends GetxController {
  UsuarioService usuarioService = UsuarioService();

  NoticiaService noticiaService = NoticiaService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController;
  // bool chamandoApi = false;
  int pageIndex = 0;
  int idBase = 0;
  RxList<ViewNoticiaModel> listaNoticia = <ViewNoticiaModel>[].obs;


  @override
  void onInit() {
    listar();
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 500) {
      listar();
    }
  }

  void listar() async {
    var listarResponse = await noticiaService.obterManchetes(pageIndex, idBase);
    // removerCarregando();
    pageIndex = pageIndex + 1;
    this.listaNoticia.addAll(listarResponse);
    // update();
  }

  // void removerCarregando(){
  //   Timer(Duration(seconds: 2), () {
  //     chamandoApi = false;
  //   });
  // }

  alertaNaoLogado(){
    final snackbar = SnackBar(
      content: Text("Faca login"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}