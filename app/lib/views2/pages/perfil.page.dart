import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/chat.page.dart';
import 'package:app_noticia/views/pages/editar-perfil.page.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mostrar-usuarios-seguidores.page.dart';
import 'mostrar-usuarios-seguindo.page.dart';

class PerfilUsuarioPage extends StatefulWidget {
  @override
  _PerfilUsuarioPage createState() => _PerfilUsuarioPage();
}

class _PerfilUsuarioPage extends State<PerfilUsuarioPage>
    with SingleTickerProviderStateMixin {
  UsuarioModel usuarioLogado;
  List<UsuarioModel> seguidoresList = List.empty();
  List<UsuarioModel> seguindoList = List.empty();
  int totalSeguidores = 0;

  @override
  initState() {
    obterUsuario();
    super.initState();
    mostrarSeguidoresTotal(usuarioLogado != null ? usuarioLogado.Id : 0);
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
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Align(
                        // child: CircleAvatar(
                        //     radius: 50.0,
                        //     backgroundImage: this.usuario != null &&
                        //             this.usuario.Foto != null
                        //         ? NetworkImage(this.usuario.Foto)
                        //         : AssetImage("assets/user.png")),
                          child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage("assets/user.png"))
                      ),
                    ),
                    this.usuarioLogado != null &&
                            this.usuarioLogado.PerfilLinkedin != null &&
                            this.usuarioLogado.PerfilLinkedin != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.linkedin.com/in/${this.usuarioLogado.PerfilLinkedin}");
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
                    this.usuarioLogado != null &&
                            this.usuarioLogado.PerfilInstagram != null &&
                            this.usuarioLogado.PerfilInstagram != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "http://www.instagram.com/${this.usuarioLogado.PerfilInstagram}");
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
                    this.usuarioLogado != null &&
                            this.usuarioLogado.PerfilFacebook != null &&
                            this.usuarioLogado.PerfilFacebook != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.facebook.com/${this.usuarioLogado.PerfilFacebook}");
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
                    this.usuarioLogado != null &&
                            this.usuarioLogado.PerfilTwitter != null &&
                            this.usuarioLogado.PerfilTwitter != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.twitter.com/${this.usuarioLogado.PerfilTwitter}");
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
                          this.usuarioLogado != null && this.usuarioLogado.Nome != null
                              ? this.usuarioLogado.Nome
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
                        // text: "Seguidores: ",
                        // text: "Seguidores: " + (this.usuarioLogado == null? "0" : totalSeguidores.toString()),
                        text: "Seguidores: " + (this.usuarioLogado == null? "0" : this.usuarioLogado.quantidadeSeguidores.toString()),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () async {
                              this.mostrarSeguidores(this.usuarioLogado != null ? this.usuarioLogado.Id : "");
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MostrarUsuariosSeguidoresPage(usuarioModelList: this.seguidoresList, usuarioModel: this.usuarioLogado)),
                              );
                            },
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        // text: "     Seguindo: " ,
                        text: "     Seguindo: " + (this.usuarioLogado == null? "0" : this.usuarioLogado.quantidadeSeguindo.toString()),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            this.mostrarSeguindo(this.usuarioLogado.Id);
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MostrarUsuariosSeguindoPage(usuarioModelList: this.seguindoList, usuarioModel: this.usuarioLogado)),
                            );
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
                        this.usuarioLogado != null && this.usuarioLogado.Descricao != null
                            ? this.usuarioLogado.Descricao
                            : "Descricao null",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ))),
                    onPressed: () async {
                      abrirChat();
                    },
                    child: Text(
                      "Chat",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ))),
                    onPressed: () async {
                      abrirEditarPerfil();
                    },
                    child: Text(
                      "Editar Perfil",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red)
                        ))),
                    onPressed: () async {
                      deslogarUsuario();
                    },
                    child: Text(
                      "Sair",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  abrirChat() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatPage()))
        .then((value) => {
      if (value is UsuarioModel)
        {
          setState(() {
            usuarioLogado = value;
          })
        }
    });
  }

  abrirEditarPerfil() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditarPerfilPage()))
        .then((value) => {
              if (value is UsuarioModel)
                {
                  setState(() {
                    usuarioLogado = value;
                  })
                }
            });
  }

  var url = 'http://www.youtube.com';

  Future<void> launchLink(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('nao pode executar o link $url');
    }
  }

  obterUsuario() async {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.obterUsuarioLogado();
    var user = await service.buscarUsuarioPorId(value.Id);
    setState(() {
      this.usuarioLogado = user;
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

  void mostrarSeguidores(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 0;
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.mostrarSeguidores(idUsuario, pageIndex, pageSize);
    setState(() {
      this.seguidoresList = value;
    });
  }

  void mostrarSeguidoresTotal(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 9999;
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.mostrarSeguidores(idUsuario, pageIndex, pageSize);
    setState(() {
      this.totalSeguidores = value.length;
      print(this.totalSeguidores);
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
