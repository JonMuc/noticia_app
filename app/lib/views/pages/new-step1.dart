import 'package:app/models/criar-conta.model.dart';
import 'package:app/services/usuario.service.dart';
import 'package:app/themes/style_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class TelaCadastroStep1 extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);
  @override
  _TelaCadastroStep1 createState() => _TelaCadastroStep1();
}
class _TelaCadastroStep1 extends State<TelaCadastroStep1> with SingleTickerProviderStateMixin {
  TextEditingController  nomeController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  senhaController = TextEditingController();
  TextEditingController  confirmarSenhaController = TextEditingController();
  CriarContaModel model;
  final _scallfoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  String nome, email, senha, confirmarSenha;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: ThemeApp.backGround),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Crie sua conta'),
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
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          new CircleAvatar(
            radius: 40.0,
            backgroundImage:
            NetworkImage("https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
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
                )
              ),
              keyboardType: TextInputType.name,
              validator: _validarNome,
              onSaved: (String val) {
                nome = val;
              },
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
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
                  )
              ),
              keyboardType: TextInputType.name,
              validator: _validarEmail,
              onSaved: (String val) {
                email = val;
              },
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
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
                  )
              ),
              keyboardType: TextInputType.name,
              validator: _validarSenha,
              onSaved: (String val) {
                senha = val;
              },
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
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
                  )
              ),
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
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      )
                  )
              ),
              onPressed: () async {
                await criarConta(context);
                _sendForm();
              },
              child: Text("Avancar",
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
          SizedBox(
            height:  10,
          ),
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
    );



  }

  String _validarNome(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o Nome";
    } else if(value.length < 3) {
      return "Nome invalido";
    }
    else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String _validarSenha(String value) {
    if (value.length == 0) {
      return "Informe a Senha";
    } else if(value.length < 4) {
      return "Senha minima de 4 dígitos";
    }
    return null;
  }
  String _validarConfirmarSenha(String value) {
    if (value.length == 0) {
      return "Informe a senha novamente";
    } else if(confirmarSenhaController.text != senhaController.text) {
      return "Porfavor digite a mesma senha";
    }
    return null;
  }

  String _validarEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if(!regExp.hasMatch(value)){
      return "Email inválido";
    }else {
      return null;
    }
  }

  _sendForm() {
    if (_key.currentState.validate()) {
      // Sem erros na validação
      _key.currentState.save();
      print("Nome $nome");
      print("Email $email");
      print("Senha $senha");
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
  Future criarConta(BuildContext context) async {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var usuarioModel = new CriarContaModel(nomeController.text,
        emailController.text, senhaController.text, confirmarSenhaController.text);
    var criarUsuarioResponse = await service.criarUsuario(usuarioModel);
  }
}