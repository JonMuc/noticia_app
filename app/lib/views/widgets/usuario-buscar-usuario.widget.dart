import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/resposta-comentario-noticia.widget.dart';
import 'package:flutter/material.dart';

class UsuarioBuscarUsuarioWidget extends StatefulWidget {
  final UsuarioModel usuarioModel;
  UsuarioBuscarUsuarioWidget({@required this.usuarioModel}); // aqu


  @override
  _UsuarioBuscarUsuarioWidget createState() => _UsuarioBuscarUsuarioWidget();

}


class _UsuarioBuscarUsuarioWidget extends State<UsuarioBuscarUsuarioWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            children: [
                 Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage("assets/user.png")
                      ),
                      // child: CircleAvatar(
                      //   radius: 30.0,
                      //   backgroundImage: widget.usuarioModel.Foto ==
                      //       null
                      //       ? AssetImage("assets/user.png")
                      //       : NetworkImage(widget.usuarioModel.Foto),
                      // ),
                    ),
                    Column(
                      children: [
                        Text(widget.usuarioModel.NomeUsuario, style: TextStyle(fontSize: 18, color: Colors.black),),
                        Text(widget.usuarioModel.Nome, style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 18, fontStyle: FontStyle.italic))
                      ],
                    )
                  ],
                ),
            ],
          )
      ),
    );
  }

}
