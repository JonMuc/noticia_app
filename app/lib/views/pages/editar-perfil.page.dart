import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/perfil-usuario.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'editar-perfil.page.dart';

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
                    MaterialPageRoute(builder: (context) => PerfilUsuarioPage()),
                  );
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
                        CircleAvatar(
                          radius: 50.0,
                          // backgroundImage: NetworkImage(widget.usuarioModel.Foto),
                          backgroundImage: this.usuario.Foto == null ? AssetImage("assets/user.png") : this.usuario.Foto,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Alterar foto de perfil", style: TextStyle(color: Colors.blue.withOpacity(0.7)))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: this.usuario.Nome == null ? "Null name" : this.usuario.Nome,
                      labelText: "Nome"),
                      controller: nomeController,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Nome de Usuario",
                    labelText: "Nome de Usuario",),),
                TextField(
                  decoration: InputDecoration(
                    hintText: this.usuario.Email == null ? "Null email" : this.usuario.Email,
                    labelText: "E-mail",),
                    controller: emailController,

                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: this.usuario.Descricao == null ? "Descricao" : this.usuario.Descricao,
                    labelText: "Bio",),
                    controller: descricaoController,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Compartilhar em outros aplicativos'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                                hintText: this.usuario.PerfilLikedin == null ? "@" : this.usuario.PerfilLikedin,
                                labelText: "Linkedin", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                            controller: linkedinController,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {print('Facebook');}, //FALTANDO CRIAR COLUNA EQUIVALENTE NO BANCO DE DADOS
                          icon: Image.asset("assets/logo_noticias/facebook.png"),
                          iconSize: 25,
                        ),
                        Text('Facebook (inclompleto)', style: TextStyle(fontSize: 13, color: Colors.blue.withOpacity(0.7)),)
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {print('Instagram');},
                          icon: Image.asset("assets/logo_noticias/Instagram.png"),
                          iconSize: 25,
                        ),
                        Container(
                          width: 140,
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: this.usuario.PerfilInstagram == null ? "@" : this.usuario.PerfilInstagram,
                                labelText: "Instagram", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                            controller: instagramController,
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
                                hintText: this.usuario.PerfilTwitter == null ? "@" : this.usuario.PerfilTwitter,
                                labelText: "Twitter", labelStyle: TextStyle(color: Colors.blue.withOpacity(0.7))),
                                controller: twitterController,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                  getImageGaleria();
                },
              ),
            ],
          );
        });
}

Future getImageGaleria() async {
    quantPermissaoGaleria ++;
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);

    if(quantPermissaoGaleria <= 3) {
      final ImagePicker _picker = ImagePicker();
      final XFile image = await _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        setState((){
          // carregando = true?
        });
        UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
        service.salvarFotoGaleria(image).then((value) => {
          fecharGaleria
        });
      }
    } else {
      showDialog(context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            content: Text(
              'permissao foto msg'),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('fechar'),
                  onPressed: () {},
              ),
            ],
          ));
    }
}

  // Future getImageCamera() async {
  //   final ConfiguracoesService service = Provider.of<ConfiguracoesService>(context, listen: false);
  //   service.quantPermissaoSolicita++;
  //
  //   if (service.quantPermissaoSolicita >= 3) {
  //     if (await Permission.camera.request().isGranted) {
  //       final cameras = await availableCameras();
  //       final result = Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => ObterImagemCameraPage(camera: cameras)));
  //       result.then((value) => {
  //         obterUsuario()
  //       });
  //     }else {
  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) => CupertinoAlertDialog(
  //             title: Text(AppLocalizations.of(context)!.translate('permissaoCamera')),
  //             content: Text(
  //                 AppLocalizations.of(context)!.translate('permissaoMessage')),
  //             actions: <Widget>[
  //               CupertinoDialogAction(
  //                 child: Text(AppLocalizations.of(context)!.translate('fechar')),
  //                 onPressed: () => Navigator.of(context).pop(),
  //               ),
  //               CupertinoDialogAction(
  //                 child: Text(AppLocalizations.of(context)!.translate('permissoes')),
  //                 onPressed: () => openAppSettings()
  //                     .then((value) => Navigator.of(context).pop()),
  //               ),
  //             ],
  //           ));
  //     }
  //   } else if (await Permission.camera.request().isGranted) {
  //     final cameras = await availableCameras();
  //     final result = Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => ObterImagemCameraPage(camera: cameras)));
  //     result.then((value) => {
  //       obterUsuario()
  //     });
  //   } else {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) => CupertinoAlertDialog(
  //           title: Text('permissaoCamera'),
  //           content: Text('permissaoMessage'),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               child: Text('fechar'),
  //               onPressed: () => Navigator.of(context).pop(),
  //             ),
  //             CupertinoDialogAction(
  //               child: Text('permissoes'),
  //               onPressed: () => openAppSettings()
  //                   .then((value) => Navigator.of(context).pop()),
  //             ),
  //           ],
  //         ));
  //   }
  // }

 void salvarEdicao(BuildContext context) async{
    print('salvar edicao');
   UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
   this.usuario.Nome = nomeController.text;
   this.usuario.Descricao = descricaoController.text;
   this.usuario.Email = emailController.text;
   this.usuario.PerfilLikedin = linkedinController.text;
   this.usuario.PerfilInstagram = instagramController.text;
   this.usuario.PerfilTwitter = twitterController.text;

   var response = await service.salvarEdicao(this.usuario, );
 }

 fecharGaleria(){
    obterUsuario();
    Navigator.of(context).pop();
 }

  obterUsuario()  async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var value = await service.obterUsuarioLogado();
    setState(() {
      this.usuario = value;
    });
  }

}