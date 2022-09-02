import 'package:app_noticia/models/request/noticia-request.model.dart';
import 'package:app_noticia/services/noticia.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  NoticiaService noticiaService = NoticiaService();
  ScrollController scrollViewController;
  TabController tabController;
  int currentIndex = 0;
  final usuarioService = Get.find<UsuarioService>();


  @override
  void onInit() {
    usuarioService.verificarUsuarioLogado();
    scrollViewController = new ScrollController();
    tabController = new TabController(vsync: this,length: 2);
    super.onInit();
    tessste();
  }

  void tessste() async{
    NoticiaRequestModel request = new NoticiaRequestModel(0, 5, 0);
    // var asd = await noticiaService.noticiaRepository.listarMancheteDeslogado(request);
    var asd = await noticiaService.obterManchetes(0,0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    currentIndex = index;
    update();
  }
}