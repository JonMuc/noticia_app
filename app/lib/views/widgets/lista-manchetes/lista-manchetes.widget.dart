import 'package:app_noticia/views/widgets/lista-manchetes/lista-manchetes.controller.dart';
import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/views/widgets/item-noticia.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListaManchetesWidget extends GetView<ListaMancheteController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Obx(() => ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.listaNoticia.length,
          itemBuilder: (context, index) {
            final ViewNoticiaModel noticia = controller.listaNoticia[index];
            return ItemNoticiaWidget(noticiaModel: noticia, notifyUsuarioNaoLogado: controller.alertaNaoLogado,);
          })),
    );
  }
}
