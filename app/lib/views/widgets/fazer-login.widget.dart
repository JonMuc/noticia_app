import 'dart:convert';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-usuario.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;



class FazerLoginWidget extends StatefulWidget{
  @override
  _FazerLoginWidget createState() => _FazerLoginWidget();
}

class _FazerLoginWidget extends State<FazerLoginWidget>{
  String _contactText = '';
  TextEditingController  senhaController = TextEditingController();
  TextEditingController  emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  child: Text("Fazer login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                children:[
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.65,
                    height:  MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: emailController,
                      decoration: new InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width:  MediaQuery.of(context).size.width * 0.65,
                    height:  MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      controller: senhaController,
                      decoration: new InputDecoration(
                        labelText: "Senhaa",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      child: Text("Avancar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan (
                          children: [
                            TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 14),
                                text: "Ainda nao tem uma conta? "
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              text: "Criar Conta",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  print("TelaCadastroStep1");
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context)
                                          => new TelaCadastroStep1()
                                      )
                                  );
                                },
                            )
                          ]
                      )
                  ),
                  SizedBox(height: 15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan (
                      children: [
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 10),
                          text: "Ao continuar, voce aceita os "
                        ),
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                          text: "Termos de uso ",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            },
                        ) ,
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 10),
                          text: "e a\n",
                        ),
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                          text: "Politica de Privacidade.",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            },
                        )
                      ]
                    )
                  )
                ],
              )
            ],
          ),
        ),
      );
  }

  Future fazerLogin(BuildContext context) async {
    print('tela login');
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var usuarioLogin = new UsuarioLoginModel(emailController.text,
        senhaController.text);
    var loginUsuarioResponse = await service.fazerLogin(usuarioLogin);
  }



}

