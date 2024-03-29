import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/widgets/resposta-comentario-noticia.widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../pages/cadastro-usuario.page.dart';
import '../pages/perfil.visitante.page..dart';

class UsuarioCardWidget extends StatefulWidget {
  final UsuarioModel usuarioModel;
  UsuarioCardWidget({@required this.usuarioModel}); // aqu

  @override
  _UsuarioCardWidget createState() => _UsuarioCardWidget();
}

class _UsuarioCardWidget extends State<UsuarioCardWidget> {

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
                        RichText(text:
                        TextSpan(
                          text: widget.usuarioModel.NomeUsuario, style: TextStyle(fontSize: 18, color: Colors.black),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                            print("usuario clicado " + widget.usuarioModel.Nome);
                            print(widget.usuarioModel.toJson());
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PerfilVisitantePage(idUsuario: widget.usuarioModel.Id)),
                              );
                            }
                        )),
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
