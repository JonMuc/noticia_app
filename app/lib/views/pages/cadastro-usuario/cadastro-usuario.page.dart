import 'dart:io';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-usuario/cadastro-usuario.controller.dart';
import 'package:app_noticia/views/shared/progress-indicator.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CadastroUsuarioViewPage extends GetView<CadastroUsuarioController> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: ThemeApp.backGround),
      home: new Scaffold(
        floatingActionButton: controller.carregando
            ? Align(
                child: FloatingActionButton(
                  onPressed: null,
                  child: GenericProgressIndicator(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                alignment: Alignment(0.1, 0))
            : Container(),
        key: controller.scaffoldKey,
        appBar: new AppBar(
          title: new Text('Crie sua conta'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(30.0), //margin screen
            child: new Form(
              key: controller.key,
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          controller.opcaoFoto();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: controller.urlFoto == "" ||
                                  controller.urlFoto == null
                              ? CircleAvatar(
                                  radius: 70.0,
                                  backgroundImage:
                                      AssetImage("assets/user.png"),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    File(controller.urlFoto),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 20, right: 20),
                        child: TextFormField(
                          controller: controller.nomeController,
                          decoration: new InputDecoration(
                              isDense: true,
                              contentPadding:
                                  new EdgeInsets.fromLTRB(15, 30, 10, 0),
                              labelText: "Nome",
                              fillColor: ThemeApp.input,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                              )),
                          keyboardType: TextInputType.name,
                          validator: controller.validarNome,
                          onSaved: (String val) {
                            controller.nome = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 20, right: 20),
                        child: TextFormField(
                          controller: controller.nomeUsuarioController,
                          decoration: new InputDecoration(
                              isDense: true,
                              contentPadding:
                                  new EdgeInsets.fromLTRB(15, 30, 10, 0),
                              labelText: "Nome Usuario",
                              fillColor: ThemeApp.input,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.validarEmail,
                          onSaved: (String val) {
                            controller.email = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 20, right: 20),
                        child: TextFormField(
                          controller: controller.emailController,
                          decoration: new InputDecoration(
                              isDense: true,
                              contentPadding:
                                  new EdgeInsets.fromLTRB(15, 30, 10, 0),
                              labelText: "Email",
                              fillColor: ThemeApp.input,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.validarEmail,
                          onSaved: (String val) {
                            controller.email = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 20, right: 20),
                        child: TextFormField(
                          controller: controller.senhaController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: new InputDecoration(
                              isDense: true,
                              contentPadding:
                                  new EdgeInsets.fromLTRB(15, 30, 10, 0),
                              labelText: "Senha",
                              fillColor: ThemeApp.input,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                              )),
                          keyboardType: TextInputType.name,
                          validator: controller.validarSenha,
                          onSaved: (String val) {
                            controller.senha = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        child: TextFormField(
                          controller: controller.confirmarSenhaController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: new InputDecoration(
                              isDense: true,
                              contentPadding:
                                  new EdgeInsets.fromLTRB(15, 30, 10, 0),
                              labelText: "Confirmar Senha",
                              fillColor: ThemeApp.input,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(9.0),
                              )),
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          validator: controller.validarConfirmarSenha,
                          onSaved: (String val) {
                            controller.confirmarSenha = val;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        // width: MediaQuery.of(context).size.width * 0.65,
                        // height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                          onPressed: () {
                            controller.criarConta();
                            controller.sendForm();
                          },
                          child: Text(
                            "Avancar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                text: "Ja tem uma conta? "),
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              text: "Entrar",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                                },
                            )
                          ])),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                                text: "Ao continuar, voce aceita os "),
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              text: "Termos de uso ",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                                },
                            ),
                            TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                              text: "e a\n",
                            ),
                            TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              text: "Politica de Privacidade.",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                                },
                            )
                          ])),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
