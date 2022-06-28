import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/usuario-buscar-usuario.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostrarUsuariosSeguindoPage extends StatefulWidget{
  final UsuarioModel usuarioModel;
List<UsuarioModel> usuarioModelList = List.empty();
MostrarUsuariosSeguindoPage({@required this.usuarioModelList, this.usuarioModel }); // aqu

  @override
  _MostrarUsuariosSeguindoPage createState() => _MostrarUsuariosSeguindoPage();
}


class _MostrarUsuariosSeguindoPage extends State<MostrarUsuariosSeguindoPage>{
  TextEditingController buscarUsuarioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    Text(widget.usuarioModel == null ? "Usuarios seguindo[null]" :  "Usuarios que ${widget.usuarioModel.NomeUsuario} segue")
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton.icon(
                      onPressed: (){
                        print("botao buscar");
                      },
                      icon: Icon(Icons.search),
                      label: Text("Buscar")),
                )
              ],
            ),
            for(UsuarioModel usuario in widget.usuarioModelList) Container(
              child: Center(
                  child: UsuarioCardWidget(usuarioModel: usuario)
              ),
            )
          ],
        ),
      ),
    );
  }

  void buscarUsuario(BuildContext context, String nomeUsuario) async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var response = await service.buscarUsuario(nomeUsuario, 0, 0);
    // print(response.length);
    setState(() {
      widget.usuarioModelList = response;
    });
    print(widget.usuarioModelList.length);
  }


}
