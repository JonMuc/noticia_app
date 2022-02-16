import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/perfil.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// atualizar secao
// mudar foto de perfil

class EditarPerfilPage extends StatefulWidget {
  @override
  _EditarPerfilPage createState() => _EditarPerfilPage();
}
class _EditarPerfilPage extends State<EditarPerfilPage> with SingleTickerProviderStateMixin {
  int quantPermissaoGaleria;
  UsuarioModel usuario;

  TextEditingController nomeController = TextEditingController();
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();


  @override
  initState() {
    obterUsuario();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Editar Perfil'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    salvarEdicao(context);
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PerfilUsuarioPage()));
                  },
                  child: Icon(
                    Icons.check,
                    size: 26.0,
                  ),
                )
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
              color: ThemeApp.backGround,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: this.usuario.Foto == null || this.usuario.Foto == "" ? AssetImage("assets/user.png") : AssetImage(this.usuario.Foto),
                            ),
                          ),
                          Text("Alterar foto de perfil", style: TextStyle(color: Colors.blue.withOpacity(0.7)))
                        ],
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Nome"),
                    controller: nomeController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nome de Usuario"),
                  controller: nomeUsuarioController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "E-mail",),
                    controller: emailController
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Bio",),
                    controller: descricaoController
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: () {print('Linkedin');},
                            icon: Image.asset("assets/logo_noticias/Linkedin.png"),
                            iconSize: 25,
                          ),
                          Container(
                            width: 140,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Linkedin", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                              controller: linkedinController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {
                            print('Facebook');},
                            icon: Image.asset("assets/logo_noticias/facebook.png"),
                            iconSize: 25,
                          ),
                          Container(
                            width: 140,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Facebook", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                              controller: facebookController,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {
                            print('Instagram');},
                            icon: Image.asset("assets/logo_noticias/Instagram.png"),
                            iconSize: 25,
                          ),
                          Container(
                            width: 140,
                            height: 60,
                            child: TextField(
                              controller: instagramController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Instagram", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {print('Twitter');},
                            icon: Image.asset("assets/logo_noticias/twitter.png"),
                            iconSize: 25,
                          ),
                          Container(
                            width: 140,
                            height: 60,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Twitter", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                              controller: twitterController,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
          ),
        )
    );
  }

  dynamic selecionarFoto(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Teste 1'),
                onTap: () {
                  // getImageCamera();
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('teste 2'),
                onTap: (){
                },
              ),
            ],
          );
        });
  }

  void salvarEdicao(BuildContext context) async{
    print('salvar edicao');
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    this.usuario.Nome = nomeController.text;
    this.usuario.NomeUsuario = nomeUsuarioController.text;
    this.usuario.Descricao = descricaoController.text;
    this.usuario.Email = emailController.text;
    this.usuario.PerfilLinkedin = linkedinController.text;
    this.usuario.PerfilInstagram = instagramController.text;
    this.usuario.PerfilTwitter = twitterController.text;
    this.usuario.PerfilFacebook = facebookController.text;
    var response = await service.atualizarUsuario(this.usuario);
    print(this.usuario.NomeUsuario);
    print(this.usuario.Nome);
  }

  obterUsuario()  async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.obterUsuarioLogado();
    setState(() {
      this.usuario = value;
      nomeController = new TextEditingController(text: this.usuario.Nome);
      nomeUsuarioController = new TextEditingController(text: this.usuario.NomeUsuario);
      emailController = new TextEditingController(text: this.usuario.Email);
      descricaoController = new TextEditingController(text: this.usuario.Descricao);
      twitterController = new TextEditingController(text: this.usuario.PerfilTwitter);
      facebookController = new TextEditingController(text: this.usuario.PerfilFacebook);
      instagramController = new TextEditingController(text: this.usuario.PerfilInstagram);
      linkedinController = new TextEditingController(text: this.usuario.PerfilLinkedin);
    });
  }

}