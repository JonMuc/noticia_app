import 'package:app_noticia/themes/style_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaCadastro2 extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  _TelaCadastro2 createState() => _TelaCadastro2();
}


class _TelaCadastro2 extends State<TelaCadastro2> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context){
    print("Tela Cadastro2");
    return Scaffold(
        body: Container(
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
              SizedBox(height: 30),
              Column(
                children:[
                  Container(
                    color: ThemeApp.input,
                    width: 260.0,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Telefone",
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
                    color: ThemeApp.input,
                    width: 260.0,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Linkedin",
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
                    color: ThemeApp.input,
                    width: 260.0,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Instagram",
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
                    color: ThemeApp.input,
                    width: 260.0,
                    height: 95,
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      maxLines: null,
                      maxLength: 500,
                      decoration: new InputDecoration(
                        hintText: "Descricao",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(6.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 250.0,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              )
                          )
                      ),
                      onPressed: (){
                        print ('kaaka');
                      },
                      child: Text("Concluir cadastro",
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
                                text: "Ja tem uma conta? "
                            ),
                            TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              text: "Entrar",
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
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
}