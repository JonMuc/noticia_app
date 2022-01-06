import 'dart:convert';

import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/shared/progress-indicator.widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilUsuario extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);
  @override
  _PerfilUsuario createState() => _PerfilUsuario();
}

class _PerfilUsuario extends State<PerfilUsuario>{
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  CriarContaModel model;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  String nome, email, senha, confirmarSenha;
  bool carregando = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: ThemeApp.backGround),
      home: Builder(
        builder: (context) =>
            Scaffold(
              floatingActionButton: carregando ? Align(
                  child: FloatingActionButton(
                    onPressed: null,
                    child: GenericProgressIndicator(),
                    backgroundColor: Colors.transparent,
                    elevation: 0,),
                  alignment: Alignment(0.1,0)) : Container(),
              key: _scaffoldKey,
              appBar: new AppBar(
                title: new Text('Perfil'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              body: new SingleChildScrollView(
                child: new Container(
                  margin: new EdgeInsets.all(30.0), //margin screen
                  child: new Form(
                    key: _key,
                    child: _formUI(),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _formUI() {
    return new Align(
        alignment: Alignment.center,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                      "https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
                ),
                Column(

                  children: [
                    IconButton(onPressed: () {print('linkedin');},
                      icon: Image.asset("assets/logo_noticias/Linkedin.png"),
                      iconSize: 25,
                    ),
                    Text('Linkedin', style: TextStyle(fontSize: 13, color: Colors.blue.withOpacity(0.7)),)
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {print('Facebook');},
                      icon: Image.asset("assets/logo_noticias/facebook.png"),
                      iconSize: 25,
                    ),
                    Text('Facebook', style: TextStyle(fontSize: 13, color: Colors.blue.withOpacity(0.7)),)
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {print('Instagram');},
                      icon: Image.asset("assets/logo_noticias/Instagram.png"),
                      iconSize: 25,
                    ),
                    Text('Instagram', style: TextStyle(fontSize: 13, color: Colors.blue.withOpacity(0.7)),)
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: () {print('Twitter');},
                      icon: Image.asset("assets/logo_noticias/twitter.png"),
                      iconSize: 25,
                    ),
                    Text('Twitter', style: TextStyle(fontSize: 13, color: Colors.blue.withOpacity(0.7)),)
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text('Nagato Pain', style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold
                ),)
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(text:
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    text: "@nagato.pain",
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        print('@matias.way');
                      },
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                RichText(text:
                    TextSpan(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "777 seguindo",
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          print('777 seguindo');
                        },
                    ),
                ),
                SizedBox(
                  width: 17,
                ),
                RichText(text: TextSpan(
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  text: "999 seguidores",
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      print('999 seguidores');
                    },
                ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text('Membro pica lord da ataksuki, famoso destruidor de konoha e tobas', style: TextStyle(color: Colors.black.withOpacity(0.8))),
            SizedBox(
              height: 17,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ThemeApp.backGround),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                            side: BorderSide(color: Colors.black.withOpacity(0.2))
                        ))),
                onPressed: () async {
                  print('');
                },
                child: Text(
                  "Editar perfil",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                RichText(text: TextSpan(
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  text: "COLECOES",
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      print('COLECOES');
                    },
                ),
                ),
                SizedBox(
                  width: 20,
                ),
                RichText(text: TextSpan(
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  text: "CURTIDAS",
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      print('CURTIDAS');
                    },
                ),
                )
              ],
            ),
          ],
        )
    );
  }
}
