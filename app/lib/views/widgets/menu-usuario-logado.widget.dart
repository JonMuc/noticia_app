import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-usuario.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class MenuUsuarioLogadoWidget extends StatefulWidget{
  @override
  _MenuUsuarioLogadoWidget createState() => _MenuUsuarioLogadoWidget();
}

class _MenuUsuarioLogadoWidget extends State<MenuUsuarioLogadoWidget>{
  UsuarioModel usuario;
  @override
  Widget build(BuildContext context) {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.obterUsuarioLogado().then((value) => {
      this.usuario = value
    });
    return Drawer(
        child: Container(
          color: ThemeApp.backGround,
          child: Column(
            children: [
              SizedBox(height: 140),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                  NetworkImage("https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
                ),
              ),
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("Usuario logado",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34
                    ),
                  ),
                ),
              ),
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(this.usuario == null ? "Nome usuario" : this.usuario.Nome,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                children:[
                  SizedBox(height: 10),
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.65,
                    height:  MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          //side: BorderSide(color: Colors.red)
                        )
                        )
                      ),
                      onPressed: () async {
                        await fazerLogin(context);
                      },
                      child: Text("Sair",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }

  Future fazerLogin(BuildContext context) async {
    // UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    // var usuarioLogin = new CriarContaModel(null, emailController.text,
    //     senhaController.text, null);
    // var loginUsuarioResponse = await service.fazerLogin(usuarioLogin);
  }
}

