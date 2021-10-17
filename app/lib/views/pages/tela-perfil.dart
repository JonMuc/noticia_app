import 'package:app/models/criar-conta.model.dart';
import 'package:app/models/usuario.model.dart';
import 'package:app/services/usuario.service.dart';
import 'package:app/themes/style_app.dart';
import 'package:app/views/pages/tela-cadastrostep2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaPerfil extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  _TelaPerfil createState() => _TelaPerfil();
}


class _TelaPerfil extends State<TelaPerfil> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context){
  print("Tela Perfil");
  return Scaffold(
      body: Container(
          color: ThemeApp.backGround,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Align(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                      NetworkImage("https://www.pinpng.com/pngs/m/131-1315114_png-pain-pain-akatsuki-black-and-white-transparent.png"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.history),
                  ),
                  IconButton(
                    icon: Icon(Icons.ios_share),
                  ),
                  IconButton(
                    icon: Icon(Icons.person_add),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              new Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    child: Text('Alexandre Matias' , style:
                      TextStyle(
                          fontSize: 26,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              new Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  RichText(text:
                    TextSpan(
                        children: [
                          TextSpan(
                              style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
                              text: "@matias.way     "
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12,),
                            text: "99 seguidores",
                            // recognizer: new TapGestureRecognizer()
                            //   ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            //   },
                          )
                        ]
                    )
                  ),
                ],
              ),
              SizedBox(height: 10,),
              new Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    child: Text('Designer at Arquivo Publico do Estado do Espirito Santo \nUx designer and Dev Front End as a freelancer', style:
                      TextStyle(
                          color: Colors.black.withOpacity(0.6)
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      )
    );
  }
  //
  // Future UsuarioModel; criarConta(BuildContext context) async {
  //   CriarContaModel usuarioModel;
  //   UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
  //   var criarUsuarioResponse = await service.criarUsuario(usuarioModel);
  //   usuarioModel.Nome = nomeController.text;
  //   usuarioModel.Email = emailController.text;
  //   usuarioModel.Senha = senhaController.text;
  //   usuarioModel.ConfirmarSenha = confirmarSenhaController.text;
  // }
  //
  // TextEditingController nomeController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController senhaController = TextEditingController();
  // TextEditingController confirmarSenhaController = TextEditingController();
}