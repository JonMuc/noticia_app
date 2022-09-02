import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/perfil-usuario/perfil-usuario.controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mostrar-usuarios-seguidores.page.dart';
import '../mostrar-usuarios-seguindo.page.dart';

class PerfilUsuarioPage extends GetView<PerfilUsuarioController> {
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
                              backgroundImage: AssetImage("assets/user.png"))),
                    ),
                    controller.usuarioLogado != null &&
                        controller.usuarioLogado.PerfilLinkedin != null &&
                        controller.usuarioLogado.PerfilLinkedin != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.linkedin.com/in/${controller.usuarioLogado.PerfilLinkedin}");
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
                    controller.usuarioLogado != null &&
                        controller.usuarioLogado.PerfilInstagram != null &&
                        controller.usuarioLogado.PerfilInstagram != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "http://www.instagram.com/${controller.usuarioLogado.PerfilInstagram}");
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
                    controller.usuarioLogado != null &&
                        controller.usuarioLogado.PerfilFacebook != null &&
                        controller.usuarioLogado.PerfilFacebook != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.facebook.com/${controller.usuarioLogado.PerfilFacebook}");
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
                    controller.usuarioLogado != null &&
                            controller.usuarioLogado.PerfilTwitter != null &&
                        controller.usuarioLogado.PerfilTwitter != ""
                        ? Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launch(
                                        "https://www.twitter.com/${controller.usuarioLogado.PerfilTwitter}");
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
                          controller.usuarioLogado != null &&
                              controller.usuarioLogado.Nome != null
                              ? controller.usuarioLogado.Nome
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
                        text: "Seguidores: " +
                            (controller.usuarioLogado == null
                                ? "0"
                                : controller.usuarioLogado
                                    .quantidadeSeguidores
                                    .toString()),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            controller.mostrarSeguidores(controller.usuarioLogado != null
                                ? controller.usuarioLogado.Id
                                : "");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MostrarUsuariosSeguidoresPage(
                                          usuarioModelList: controller.seguidoresList,
                                          usuarioModel: controller.usuarioLogado)),
                            );
                          },
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        // text: "     Seguindo: " ,
                        text: "     Seguindo: " +
                            (controller.usuarioLogado == null
                                ? "0"
                                : controller.usuarioLogado
                                    .quantidadeSeguindo
                                    .toString()),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            controller.mostrarSeguindo(controller.usuarioLogado.Id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MostrarUsuariosSeguindoPage(
                                          usuarioModelList: controller.seguindoList,
                                          usuarioModel: controller.usuarioLogado)),
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
                        controller.usuarioLogado != null &&
                            controller.usuarioLogado.Descricao != null
                            ? controller.usuarioLogado.Descricao
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
                      controller.abrirChat();
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
                      controller.abrirEditarPerfil();
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
                      controller.deslogarUsuario();
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
}
