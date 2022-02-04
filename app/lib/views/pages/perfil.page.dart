import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/editar-perfil.page.dart';
import 'package:app_noticia/views/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilUsuarioPage extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  _PerfilUsuarioPage createState() => _PerfilUsuarioPage();
}


class _PerfilUsuarioPage extends State<PerfilUsuarioPage> with SingleTickerProviderStateMixin {
  UsuarioModel usuario;
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
                        radius: 50.0,
                        // backgroundImage: NetworkImage(widget.usuarioModel.Foto),
                        // backgroundImage: this.usuario.Foto == null ? AssetImage("assets/user.png") : this.usuario.Foto,
                        backgroundImage: AssetImage("assets/user.png"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        IconButton(onPressed: () {print('Linkedin');},
                          icon: Image.asset("assets/logo_noticias/Linkedin.png"),
                          iconSize: 25,
                        ),
                        Text("Linkedin", style: TextStyle(color: Colors.blue.withOpacity(0.9), fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(onPressed: () {print('Instagram');},
                          icon: Image.asset("assets/logo_noticias/Instagram.png"),
                          iconSize: 25,
                        ),
                        Text("Instagram", style: TextStyle(color: Colors.blue.withOpacity(0.9), fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(onPressed: () {print('Facebook');},
                          icon: Image.asset("assets/logo_noticias/facebook.png"),
                          iconSize: 25,
                        ),
                        Text("Facebook", style: TextStyle(color: Colors.blue.withOpacity(0.9), fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(onPressed: () {print('Twitter');},
                          icon: Image.asset("assets/logo_noticias/twitter.png"),
                          iconSize: 25,
                        ),
                        Text("Twitter", style: TextStyle(color: Colors.blue.withOpacity(0.9), fontSize: 12)),
                      ],
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
                      // child: Text(this.usuario.Nome == null ? "Null" : this.usuario.Nome, style:
                      child: Text("nameless", style:
                      TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(text:
                    TextSpan(
                        children: [
                          TextSpan(
                              style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
                              text: "@matias.way     "
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12,),
                            text: "99 seguidores     ",
                            // recognizer: new TapGestureRecognizer()
                            //   ..onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                            //   },
                          ),

                          TextSpan(
                            style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12,),
                            text: "seguindo 77     ",
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
                      child: Text('sem descricao', style:
                      // child: Text(this.usuario.Descricao == null ? "descricao null" : this.usuario.Descricao, style:
                      TextStyle(
                          color: Colors.black.withOpacity(0.6)
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(11)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ))),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EditarPerfilPage()));
                    },
                    child: Text(
                      "Editar Perfil",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(11)),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              //side: BorderSide(color: Colors.red)
                            ))),
                    onPressed: () async {
                      deslogarUsuario();

                    },
                    child: Text(
                      "Sair",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )

              ],
            )
        )
    );
  }
  obterUsuario()  async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.obterUsuarioLogado();
    setState(() {
      this.usuario = value;
    });
  }

  deslogarUsuario()  async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    await service.limparSecao();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => HomePage()
    ), (route) => false);
  }
}