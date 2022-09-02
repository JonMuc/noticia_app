import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-usuario/cadastro-usuario.page.dart';
import 'package:app_noticia/views/shared/progress-indicator.widget.dart';
import 'package:app_noticia/views/widgets/fazer-login/fazer-login.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FazerLoginWidget extends GetView<FazerLoginController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ThemeApp.backGround,
      child: Scaffold(
        floatingActionButton: controller.carregando
            ? Align(
                child: FloatingActionButton(
                  onPressed: null,
                  child: GenericProgressIndicator(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                alignment: Alignment(-0.2, 0))
            : Container(),
        key: controller.scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 150),
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        "https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Fazer login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: controller.emailController,
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
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: controller.senhaController,
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
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(15)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            //side: BorderSide(color: Colors.red)
                          ))),
                      onPressed: () {
                        controller.fazerLogin();
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CadastroUsuarioViewPage()),
                              );
                            },
                        )
                      ])),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
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
                        ])),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
