import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/usuario-buscar-usuario.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuscarUsuarioWidget extends StatefulWidget{

  @override
  _BuscarUsuarioWidget createState() => _BuscarUsuarioWidget();
}


class _BuscarUsuarioWidget extends State<BuscarUsuarioWidget>{
  TextEditingController buscarUsuarioController = TextEditingController();
  List<UsuarioModel> usuarioModelList = List.empty();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.65,
                child:
                TextField(
                  decoration: InputDecoration(
                    labelText: "Buscar Usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.blue)),
                    filled: true,
                  ),
                  controller: buscarUsuarioController,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton.icon(
                    onPressed: (){
                      buscarUsuario(context, buscarUsuarioController.text);
                    },
                    icon: Icon(Icons.search),
                    label: Text("Buscar")),
              )
            ],
          ),
          for(UsuarioModel usuario in usuarioModelList) Container(
            child: Center(
                child: UsuarioBuscarUsuarioWidget(usuarioModel: usuario)
            ),
          )
        ],
      ),
    );
  }

  void buscarUsuario(BuildContext context, String nomeUsuario) async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var response = await service.buscarUsuario(nomeUsuario);
    // print(response.length);
    setState(() {
      this.usuarioModelList = response;
    });
    print(usuarioModelList.length);
  }
}
