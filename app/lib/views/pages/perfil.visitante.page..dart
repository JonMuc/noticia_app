import 'dart:ffi';

import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/editar-perfil.page.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mostrar-usuarios-seguidores.page.dart';
import 'mostrar-usuarios-seguindo.page.dart';

class PerfilVisitantePage extends StatefulWidget {
  final int idUsuario;
  PerfilVisitantePage({@required this.idUsuario});
  @override
  _PerfilVisitantePage createState() => _PerfilVisitantePage();
}

class _PerfilVisitantePage extends State<PerfilVisitantePage>
    with SingleTickerProviderStateMixin {
  UsuarioModel usuarioLogado;
  UsuarioModel usuarioPerfil;
  List<UsuarioModel> seguidoresList = List.empty();
  List<UsuarioModel> seguindoList = List.empty();
  @override
  void initState() {
    buscarUsuarioPorId(widget.idUsuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: ThemeApp.backGround,
            child: Column(
              children: [
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    this.usuarioPerfil == null ? Container() :
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Align(
                        child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: this.usuarioPerfil.NomeUsuario != null &&
                                this.usuarioPerfil.Foto != null
                                ? NetworkImage(this.usuarioPerfil.Foto)
                                : AssetImage("assets/user.png")),
                      ),
                    ),
                  this.usuarioPerfil != null &&
                      this.usuarioPerfil.PerfilLinkedin != null &&
                      this.usuarioPerfil.PerfilLinkedin != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.linkedin.com/in/${this.usuarioPerfil.PerfilLinkedin}");
                                  },
                                  icon: Image.asset(
                                      "assets/logo_noticias/Linkedin.png"),
                                  iconSize: 25,
                                ),
                                Text("Linkedin",
                                    style: TextStyle(
                                        color: Colors.blue.withOpacity(0.9),
                                        fontSize: 12)),
                              ],
                            ))
                        : Container(),
                        this.usuarioPerfil != null &&
                        this.usuarioPerfil.PerfilInstagram != null &&
                        this.usuarioPerfil.PerfilInstagram != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "http://www.instagram.com/${this.usuarioPerfil.PerfilInstagram}");
                                  },
                                  icon: Image.asset(
                                      "assets/logo_noticias/Instagram.png"),
                                  iconSize: 25,
                                ),
                                Text("Instagram",
                                    style: TextStyle(
                                        color: Colors.blue.withOpacity(0.9),
                                        fontSize: 12)),
                              ],
                            ),
                          )
                        : Container(),
                    this.usuarioPerfil != null &&
                        this.usuarioPerfil.PerfilFacebook != null &&
                        this.usuarioPerfil.PerfilFacebook != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.facebook.com/${this.usuarioPerfil.PerfilFacebook}");
                                  },
                                  icon: Image.asset(
                                      "assets/logo_noticias/facebook.png"),
                                  iconSize: 25,
                                ),
                                Text("Facebook",
                                    style: TextStyle(
                                        color: Colors.blue.withOpacity(0.9),
                                        fontSize: 12)),
                              ],
                            ),
                          )
                        : Container(),
                        this.usuarioPerfil != null &&
                        this.usuarioPerfil.PerfilTwitter != null &&
                        this.usuarioPerfil.PerfilTwitter != ""
                          ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.twitter.com/${this.usuarioPerfil.PerfilTwitter}");
                                  },
                                  icon: Image.asset(
                                      "assets/logo_noticias/twitter.png"),
                                  iconSize: 25,
                                ),
                                Text("Twitter",
                                    style: TextStyle(
                                        color: Colors.blue.withOpacity(0.9),
                                        fontSize: 12)),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
                new Row(
                  children: [
                    Container(
                        child: Text(
                          this.usuarioPerfil != null && this.usuarioPerfil.Nome != null
                              ? this.usuarioPerfil.Nome + "   ID " + this.usuarioPerfil.Id.toString()
                              : "name Null",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(left: 15)),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 12),
                              text: "@${this.usuarioPerfil != null && this.usuarioPerfil.NomeUsuario != null ? this.usuarioPerfil.NomeUsuario : "unknow"}" ),
                        ])),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12,
                            ),
                            text: Jasegue ? "vc ja segue este usuario" : "Seguidores ${this.usuarioPerfil == null ? "" : this.usuarioPerfil.quantidadeSeguidores.toString()}",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async {
                                this.mostrarSeguindo(this.usuarioPerfil.Id);
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MostrarUsuariosSeguidoresPage(usuarioModelList: this.seguidoresList, usuarioModel: this.usuarioPerfil)),
                                );
                              },
                          ),
                        ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        text: "Seguindo ${this.usuarioPerfil == null ? "" : this.usuarioPerfil.quantidadeSeguindo.toString()}",
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            this.mostrarSeguindo(this.usuarioPerfil.Id);
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MostrarUsuariosSeguindoPage(usuarioModelList: this.seguindoList, usuarioModel: this.usuarioPerfil)),
                            );
                            },
                      ),
                    ])),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            text: "  Seguir usuario     ",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                print("seguir usuario " + this.usuarioPerfil.Id.toString());
                                seguirUsuario(this.usuarioPerfil.Id);
                              },
                          ),
                          TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            text: " Deseguir usuario     ",
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                print("Deseguir usuario " + this.usuarioPerfil.Id.toString());
                                deseguirUsuario(this.usuarioPerfil.Id);
                              },
                          )
                        ])),
                  ],
                ),
                new Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        this.usuarioPerfil != null && this.usuarioPerfil.Descricao != null
                            ? this.usuarioPerfil.Descricao
                            : "Descricao null",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  var url = 'http://www.youtube.com';

  Future<void> launchLink(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('nao pode executar o link $url');
    }
  }

  var Jasegue = false;

  Future<bool> usuarioJaSeguido(int id) async{
    mostrarSeguidores(this.usuarioPerfil.Id);
    obterUsuario();
    Jasegue = true;
  }

  void mostrarSeguidores(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 0;
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.mostrarSeguidores(idUsuario, pageIndex, pageSize);
    setState(() {
      this.seguidoresList = value;
    });
  }

  void mostrarSeguindo(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 0;
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.mostrarSeguindo(idUsuario, pageIndex, pageSize);
    setState(() {
      this.seguindoList = value;
    });
  }

  void seguirUsuario(int idUsuarioSeguido){
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.seguirUsuario(idUsuarioSeguido);
  }

  void deseguirUsuario(int idUsuarioSeguido){
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.deseguirUsuario(idUsuarioSeguido);
  }

  void buscarUsuarioPorId(int idUsuario) async {
    print(widget.idUsuario);
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var user = await service.buscarUsuarioPorId(idUsuario);
    if(user.quantidadeSeguidores == null){
      user.quantidadeSeguidores = 0;
    }
    if(user.quantidadeSeguindo == null){
      user.quantidadeSeguindo = 0;
    }
    setState(() {
      usuarioPerfil = user;
    });
  }

  obterUsuario()  async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.obterUsuarioLogado();
    setState(() {
      this.usuarioLogado = value;
    });
  }


}
