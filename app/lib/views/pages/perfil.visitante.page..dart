import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/editar-perfil.page.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilVisitantePage extends StatefulWidget {
  final int idUsuario;
  PerfilVisitantePage({@required this.idUsuario});
  @override
  _PerfilVisitantePage createState() => _PerfilVisitantePage();
}



class _PerfilVisitantePage extends State<PerfilVisitantePage>
    with SingleTickerProviderStateMixin {
  UsuarioModel usuarioModel;
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
                    this.usuarioModel == null ? Container() :
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Align(
                        child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: this.usuarioModel.NomeUsuario != null &&
                                this.usuarioModel.Foto != null
                                ? NetworkImage(this.usuarioModel.Foto)
                                : AssetImage("assets/user.png")),
                      ),
                    ),
                  this.usuarioModel != null &&
                      this.usuarioModel.PerfilLinkedin != null &&
                      this.usuarioModel.PerfilLinkedin != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.linkedin.com/in/${this.usuarioModel.PerfilLinkedin}");
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
                    this.usuarioModel != null &&
                        this.usuarioModel.PerfilInstagram != null &&
                        this.usuarioModel.PerfilInstagram != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "http://www.instagram.com/${this.usuarioModel.PerfilInstagram}");
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
                    this.usuarioModel != null &&
                        this.usuarioModel.PerfilFacebook != null &&
                        this.usuarioModel.PerfilFacebook != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.facebook.com/${this.usuarioModel.PerfilFacebook}");
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
                        this.usuarioModel != null &&
                        this.usuarioModel.PerfilTwitter != null &&
                        this.usuarioModel.PerfilTwitter != ""
                          ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.twitter.com/${this.usuarioModel.PerfilTwitter}");
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
                          this.usuarioModel != null && this.usuarioModel.Nome != null
                              ? this.usuarioModel.Nome
                              : "name Null",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(left: 15)),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 12),
                          text: "@matias.way     "),
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        text: "99 seguidores     ",
                        // recognizer: new TapGestureRecognizer()
                        //   ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                        //   },
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        text: "seguindo 77     ",
                        // recognizer: new TapGestureRecognizer()
                        //   ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                        //   },
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
                                print("seguir usuario " + this.usuarioModel.Id.toString());
                                seguirUsuario(this.usuarioModel.Id);
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
                                print("Deseguir usuario " + this.usuarioModel.Id.toString());
                                deseguirUsuario(this.usuarioModel.Id);
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
                        this.usuarioModel != null && this.usuarioModel.Descricao != null
                            ? this.usuarioModel.Descricao
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

  void seguirUsuario(int idUsuarioSeguido){
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.seguirUsuario(idUsuarioSeguido);
  }

  void deseguirUsuario(int idUsuarioSeguido){
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.deseguirUsuario(idUsuarioSeguido);
  }

  void buscarUsuarioPorId(int idUsuario) async {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var user = await service.buscarUsuarioPorId(idUsuario);
    setState(() {
      usuarioModel = user;
    });
  }



  deslogarUsuario() async {
    UsuarioService service =
        Provider.of<UsuarioService>(context, listen: false);
    await service.limparSecao();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}