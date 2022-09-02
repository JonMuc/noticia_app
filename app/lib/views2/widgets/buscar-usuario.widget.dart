import 'dart:async';

import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/usuario-buscar-usuario.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/style_app.dart';

class BuscarUsuarioWidget extends StatefulWidget{

  @override
  _BuscarUsuarioWidget createState() => _BuscarUsuarioWidget();
}


class _BuscarUsuarioWidget extends State<BuscarUsuarioWidget>{
  TextEditingController buscarUsuarioController = TextEditingController();
  List<UsuarioModel> usuarioModelList = [];
  bool chamandoApi = false;
  int pageIndex = 0;
  int pageSize = 20;
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        // backgroundColor: ThemeApp.backGround,
        backgroundColor: Colors.white,
        toolbarHeight: 17, //set your height
        flexibleSpace:
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.83,
              child:
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pesquisar',
                  filled: true,
                ),
                controller: buscarUsuarioController,
              ),
            ),
            Container(
              // padding: EdgeInsets.only(top: 10),
              child: TextButton(
                child: Icon(Icons.search),
                onPressed: () {
                  buscarUsuario(context, buscarUsuarioController.text, pageIndex, pageSize);
                },
              ),
              ),
          ],
        )
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            for(UsuarioModel usuario in usuarioModelList) Container(
              child: Center(
                  child: UsuarioCardWidget(usuarioModel: usuario)
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    // print(controller.position.extentAfter);
    if (controller.position.extentAfter < 300 && !chamandoApi) {
      pageIndex = pageIndex + 20;
      print("chamar api  pageIndeex> " + pageIndex.toString());
      setState(() {
        chamandoApi = true;
      });
      buscarUsuario(context, buscarUsuarioController.text, pageIndex, pageSize);
    }
  }

  void buscarUsuario(BuildContext context, String nomeUsuario, int pageIndex, int pageSize) async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var response = await service.buscarUsuario(nomeUsuario, pageIndex, pageSize);
    removerCarregando();
    setState(() {
      this.usuarioModelList.addAll(response);
    });
  }

  void removerCarregando(){
    Timer(Duration(seconds: 2), () {
      setState(() {
        chamandoApi = false;
      });
    });
  }


}
