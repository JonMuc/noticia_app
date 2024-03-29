import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/obter-image-camera.page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


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
        backgroundColor: ThemeApp.backGround,
        appBar: new AppBar(
          title: new Text('Editar Perfil'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(usuario),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    salvarEdicao(context);
                    Navigator.of(context).pop(usuario);
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
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Align(
                              child: CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: this.usuario != null && this.usuario.Foto != null ? NetworkImage(this.usuario.Foto) : AssetImage("assets/user.png")
                              ),
                            ),
                          ),
                          TextButton(onPressed: (){
                            selecionarFoto(context);
                          }, child:
                          Text("Alterar foto de perfil", style: TextStyle(color: Colors.blue.withOpacity(0.7))))
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
                title: new Text('Camera'),
                onTap: () {
                  getImageCamera();
                },
              ),
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Galeria'),
                onTap: (){
                  getImageGaleria();
                },
              ),
            ],
          );
        });
  }

  Future getImageGaleria() async {
    final UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.quantPermissaoGaleria++;
    if (service.quantPermissaoGaleria <= 3 || await Permission.photos.request().isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile image = await _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
        atualizarUrl(image.path);
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

  Future getImageCamera() async {
    final UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.quantPermissaoSolicita++;
    if (service.quantPermissaoSolicita <= 3 || await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
      final result = Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ObterImagemCameraPage(camera: cameras)));
      result.then((value) => {
        atualizarUrl(value)
      });
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

  atualizarUrl(String path) async{
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var result = await service.alterarFoto(new XFile(path));
    setState(() {
      usuario.Foto = result;
    });
  }

  void salvarEdicao(BuildContext context) async{
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
    if(response is UsuarioModel){
      setState(() {
        usuario = response;
      });
    }
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