import 'dart:async';

import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/usuario-buscar-usuario.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostrarUsuariosSeguidoresPage extends StatefulWidget{
  final UsuarioModel usuarioModel;
  List<UsuarioModel> usuarioModelList = [];
  MostrarUsuariosSeguidoresPage({@required this.usuarioModelList, this.usuarioModel }); // aqu

  @override
  _MostrarUsuariosSeguidoresPage createState() => _MostrarUsuariosSeguidoresPage();
}

class _MostrarUsuariosSeguidoresPage extends State<MostrarUsuariosSeguidoresPage>{
  ScrollController controller;
  bool chamandoApi = false;
  int pageIndex = 0;
  int pageSize = 20;
  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    print("lista seguidores : " + widget.usuarioModelList.length.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 25),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child:
                    Text(widget.usuarioModel == null ? "Seguidores de [Usuario null]" :  "Seguidores de ${widget.usuarioModel.NomeUsuario}")
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton.icon(
                      onPressed: (){
                        print("botao buscar");
                      },
                      icon: Icon(Icons.search),
                      label: Text(widget.usuarioModelList.length.toString() + "  " + widget.usuarioModel.NomeUsuario)),
                )
              ],
            ),
            for(UsuarioModel usuario in widget.usuarioModelList) Container(
              child: Center(
                  // child: ElevatedButton(
                  //   onPressed: (){
                  //     print(usuario.Nome);
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => UsuarioCardWidget(usuarioModel: usuario)));
                  //   },
                  // )
                  child: UsuarioCardWidget(usuarioModel: usuario)
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 200 && !chamandoApi) {
    // if (controller.position.extentAfter < 200) {
      pageIndex = pageIndex + 20;
      print("chamar api  pageIndeex> " + pageIndex.toString());
      setState(() {
        chamandoApi = true;
      });
      mostrarSeguidores(widget.usuarioModel.Id, pageIndex, pageSize);
    }
  }

  void mostrarSeguidores(int idUsuario, int pageIndex, int pageSize) async {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.mostrarSeguidores(idUsuario, pageIndex, pageSize);
    removerCarregando();
    setState(() {
      widget.usuarioModelList.addAll(value);
    });
    print("lista seguidores > " + widget.usuarioModelList.length.toString());
  }

  void removerCarregando(){
    Timer(Duration(seconds: 2), () {
      setState(() {
        chamandoApi = false;
      });
    });
  }

}
