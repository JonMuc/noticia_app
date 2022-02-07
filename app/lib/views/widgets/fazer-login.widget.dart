import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-usuario.page.dart';
import 'package:app_noticia/views/pages/comentario-noticia.page.dart';
import 'package:app_noticia/views/shared/progress-indicator.widget.dart';
import 'package:app_noticia/views/widgets/perfil-usuario.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'comentario-noticia.widget.dart';

class FazerLoginWidget extends StatefulWidget {
  @override
  _FazerLoginWidget createState() => _FazerLoginWidget();
}

class _FazerLoginWidget extends State<FazerLoginWidget> {
  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool carregando = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        floatingActionButton: carregando ? Align(
            child: FloatingActionButton(
              onPressed: null,
              child: GenericProgressIndicator(),
              backgroundColor: Colors.transparent,
              elevation: 0,),
            alignment: Alignment(-0.2,0)) : Container(),
        key: _scaffoldKey,
        body: Container(
          color: ThemeApp.backGround,
          child: Column(
            children: [
              SizedBox(height: 140),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
                ),
              ),
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Fazer login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: emailController,
                      decoration: new InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: senhaController,
                      // keyboardType:  TextInputType.visiblePassword,
                      decoration: new InputDecoration(
                        labelText: "Senha",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red)
                              ))),
                      onPressed: () async {
                        await fazerLogin(context);
                        print('printou avancar');
                      },
                      child: Text(
                        "Avancar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // carregando ?
                  // Container(
                  //   padding: EdgeInsets.only(top: 10),
                  //   child: Center(
                  //     child: GenericProgressIndicator(),
                  //   ),
                  // )
                  //     : Container(),
                  SizedBox(height: 50),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            text: "Ainda nao tem uma conta? "),
                        TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          text: "Criar Conta",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TelaCadastroUsuario()),
                              // MaterialPageRoute(builder: (context) => PerfilUsuario()),
                              );
                            },
                            //
                            // new MaterialPageRoute(
                            //     builder: (BuildContext context)
                            //     // => new TelaComentarioNoticia()
                            //     => new TelaComentarioNoticia(noticiaModel: noticia)
                            )
                      ])),
                  SizedBox(height: 15),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 10),
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
                          style: TextStyle(color: Colors.black, fontSize: 10),
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
                      ]))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void preencherCarregando(bool value) {
    setState(() {
      carregando = value;
    });
  }

  Future fazerLogin(BuildContext context) async {
    preencherCarregando(true);
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var request = new UsuarioLoginModel(emailController.text, senhaController.text);
    var response = await service.fazerLogin(request);
    if(response is UsuarioModel){
      preencherCarregando(false);
      Navigator.pop(context);
    }else{
      preencherCarregando(false);
      ResponseModel responseModel = response;
      print(responseModel.Objeto);
      final snackbar = SnackBar(
        content: Text(responseModel.Objeto.toString()
            .replaceAll("[", "")
            .replaceAll("]", "")),
        backgroundColor: ThemeApp.snackBarMensagemEnvio,
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  void navegarCriarConta(BuildContext context) async {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new TelaCadastroUsuario()))
        .then((value) => {
      if (value) {Navigator.pop(context)}
    });
  }
}
