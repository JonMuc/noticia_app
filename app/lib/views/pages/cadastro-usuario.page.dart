import 'dart:io';

import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:app_noticia/views/pages/obter-image-camera.page.dart';
import 'package:app_noticia/views/shared/progress-indicator.widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class TelaCadastroUsuario extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);
  @override
  _TelaCadastroUsuario createState() => _TelaCadastroUsuario();
}

class _TelaCadastroUsuario extends State<TelaCadastroUsuario>
    with SingleTickerProviderStateMixin {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  CriarContaModel model;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  String nome, email, senha, confirmarSenha;
  bool carregando = false;
  String urlFoto = "";


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: ThemeApp.backGround),
      home: new Scaffold(
        floatingActionButton: carregando ? Align(
            child: FloatingActionButton(
              onPressed: null,
              child: GenericProgressIndicator(),
              backgroundColor: Colors.transparent,
              elevation: 0,),
            alignment: Alignment(0.1,0)) : Container(),
        key: _scaffoldKey,
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
              key: _key,
              child: _formUI(),
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
            GestureDetector(
              onTap: () {
                _opcaoFoto(context);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                child: urlFoto == "" ? CircleAvatar(
                  radius: 70.0,
                  backgroundImage: AssetImage("assets/user.png"),
                ) : ClipOval(
                  child: Image.file(File(urlFoto), width: 150, height: 150,fit: BoxFit.cover,),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: TextFormField(
                controller: nomeController,
                decoration: new InputDecoration(
                    isDense: true,
                    contentPadding: new EdgeInsets.fromLTRB(15, 30, 10, 0),
                    labelText: "Nome",
                    fillColor: ThemeApp.input,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                    )),
                keyboardType: TextInputType.name,
                validator: _validarNome,
                onSaved: (String val) {
                  nome = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: TextFormField(
                controller: emailController,
                decoration: new InputDecoration(
                    isDense: true,
                    contentPadding: new EdgeInsets.fromLTRB(15, 30, 10, 0),
                    labelText: "Email",
                    fillColor: ThemeApp.input,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                    )),
                keyboardType: TextInputType.emailAddress,
                validator: _validarEmail,
                onSaved: (String val) {
                  email = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: TextFormField(
                controller: senhaController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: new InputDecoration(
                    isDense: true,
                    contentPadding: new EdgeInsets.fromLTRB(15, 30, 10, 0),
                    labelText: "Senha",
                    fillColor: ThemeApp.input,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                    )),
                keyboardType: TextInputType.name,
                validator: _validarSenha,
                onSaved: (String val) {
                  senha = val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextFormField(
                controller: confirmarSenhaController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: new InputDecoration(
                    isDense: true,
                    contentPadding: new EdgeInsets.fromLTRB(15, 30, 10, 0),
                    labelText: "Confirmar Senha",
                    fillColor: ThemeApp.input,
                    filled: true,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(9.0),
                    )),
                maxLines: 1,
                keyboardType: TextInputType.name,
                validator: _validarConfirmarSenha,
                onSaved: (String val) {
                  confirmarSenha = val;
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ))),
                onPressed: () {
                  criarConta(context);
                  _sendForm();
                },
                child: Text(
                  "Avancar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 14),
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
            SizedBox(
              height: 10,
            ),
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
                ])),

          ],
        ));
  }

  Future getImageCamera() async {
    final UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.quantPermissaoSolicita++;
    if (service.quantPermissaoSolicita >= 3) {
      if (await Permission.camera.request().isGranted) {
        final cameras = await availableCameras();
        final result = Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObterImagemCameraPage(camera: cameras)));
        result.then((value) => {
          atualizarUrl(value)
        });
      }else {
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("De permissao de camera"),
              content: Text("De permissao de camera"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("Fechar"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoDialogAction(
                  child: Text("Permissoes"),
                  onPressed: () => openAppSettings()
                      .then((value) => Navigator.of(context).pop()),
                ),
              ],
            ));
      }
    } else if (await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
      final result = Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ObterImagemCameraPage(camera: cameras)));
      result.then((value) => {
        atualizarUrl(value)
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("De permissao de camera"),
            content: Text("De permissao de camera"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Fechar"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text("Fechar"),
                onPressed: () => openAppSettings()
                    .then((value) => Navigator.of(context).pop()),
              ),
            ],
          ));
    }
  }

  atualizarUrl(String path){
    setState(() {
      urlFoto = path;
    });
  }

  fecharGaleria(){
    Navigator.of(context).pop();
  }

  Future getImageGaleria() async {
    final UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.quantPermissaoGaleria++;
    if (service.quantPermissaoGaleria <= 3 || await Permission.photos.request().isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile image = await _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        setState(() {
          urlFoto = image.path;
        });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("title permissao galeria"),
            content: Text("Permissao galerica"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Fechar"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text("Permissao galeria"),
                onPressed: () => openAppSettings()
                    .then((value) => Navigator.of(context).pop()),
              ),
            ],
          ));
    }
  }

  dynamic _opcaoFoto(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.camera),
                title: new Text("Camera"),
                onTap: () {
                  getImageCamera();
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text("Galeria"),
                onTap: () {
                  getImageGaleria();
                },
              ),
            ],
          );
        });
  }

  String _validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o Nome";
    } else if (value.length < 3) {
      return "Nome invalido";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String _validarSenha(String value) {
    if (value.length == 0) {
      return "Informe a Senha";
    } else if (value.length < 4) {
      return "Senha minima de 4 dígitos";
    }
    return null;
  }

  String _validarConfirmarSenha(String value) {
    if (value.length == 0) {
      return "Informe a senha novamente";
    } else if (confirmarSenhaController.text != senhaController.text) {
      return "Porfavor digite a mesma senha";
    }
    return null;
  }

  String _validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  _sendForm() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
    }
  }

  void preencherCarregando(bool value) {
    setState(() {
      carregando = value;
    });
  }

  void criarConta(BuildContext context) async {
    preencherCarregando(true);
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var usuarioModel = new CriarContaModel(
        nomeController.text,
        emailController.text,
        senhaController.text,
        confirmarSenhaController.text,
        urlFoto
    );
    var response = await service.criarUsuario(usuarioModel);

    //verifica se é um usuario, se for deu sucesso
    if (response is UsuarioModel) {
      preencherCarregando(false);
      final snackbar = SnackBar(
        content: Text('Usuario criado com sucesso.'),
        backgroundColor: Colors.blue,
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);

      //delay apos criar
      new Future.delayed(new Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) => HomePage()
        ), (route) => false);
      });
    } else {
      preencherCarregando(false);
      ResponseModel responseModel = response;
      final snackbar = SnackBar(
        content: Text(responseModel.Objeto.toString()
            .replaceAll("[", "")
            .replaceAll("]", "")),
        backgroundColor: ThemeApp.snackBarMensagemEnvio,
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }
}
