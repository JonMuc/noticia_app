import 'package:app/models/criar-conta.model.dart';
import 'package:app/models/usuario.model.dart';
import 'package:app/services/usuario.service.dart';
import 'package:app/themes/style_app.dart';
import 'package:app/views/pages/tela-cadastrostep2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaCadastro extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  _TelaCadastro createState() => _TelaCadastro();
}


class _TelaCadastro extends State<TelaCadastro> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context){
  print("Tela Cadastro");
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
            Text('Adcionar foto de perfil', style: TextStyle(fontSize: 10)),
            SizedBox(height: 50),
            Column(
              children:[
                Container(
                  color: ThemeApp.input,
                  width: 260.0,
                  height: 45,
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: nomeController,
                    decoration: new InputDecoration(
                      labelText: "Nome",
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
                  height: 45,
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                      labelText: "E-mail",
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
                  height: 45,
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: senhaController,
                    decoration: new InputDecoration(
                      labelText: "Senha",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                        borderSide: new BorderSide(
                        ),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter last Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  color: ThemeApp.input,
                  width: 260.0,
                  height: 45,
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: confirmarSenhaController,
                    decoration: new InputDecoration(
                      labelText: "Confirmar senha",
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
                  width: 255.0,
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
                    onPressed: () async {
                     await criarConta(context);
                     print(nomeController.text);
                     criarConta(context);
                    },
                    child: Text("Concluir",
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
      )
      );
  }

  Future UsuarioModel; criarConta(BuildContext context) async {
    CriarContaModel usuarioModel;
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var criarUsuarioResponse = await service.criarUsuario(usuarioModel);
    usuarioModel.Nome = nomeController.text;
    usuarioModel.Email = emailController.text;
    usuarioModel.Senha = senhaController.text;
    usuarioModel.ConfirmarSenha = confirmarSenhaController.text;
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
}