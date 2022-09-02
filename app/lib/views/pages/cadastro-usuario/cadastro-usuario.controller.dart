import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CadastroUsuarioController extends GetxController with GetSingleTickerProviderStateMixin {
  UsuarioService usuarioService = UsuarioService();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  CriarContaModel model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> key = new GlobalKey();
  String nome, email, senha, confirmarSenha;
  bool carregando = false;
  String urlFoto = "";

  Future getImageCamera() async {
    usuarioService.quantPermissaoSolicita++;
    if (usuarioService.quantPermissaoSolicita <= 3 ||
        await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
      // final result = Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ObterImagemCameraPage(camera: cameras)));
      // result.then((value) => {
      //   atualizarUrl(value)
      // });
    } else if (await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
      // final result = Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ObterImagemCameraPage(camera: cameras)));
      // result.then((value) => {
      //   atualizarUrl(value)
      // });
    } else {
      Get.defaultDialog(
          title: "De permissao de camera!",
          middleText: "De permissao de camera",
          backgroundColor: Colors.green,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            CupertinoDialogAction(
              child: Text("Fechar"),
              onPressed: () => Get.back(),
            ),
            CupertinoDialogAction(
              child: Text("Fechar"),
              onPressed: () => openAppSettings().then((value) => Get.back()),
            )
          ]);
    }
  }

  Future getImageGaleria() async {
    usuarioService.quantPermissaoGaleria++;
    if (usuarioService.quantPermissaoGaleria <= 3 ||
        await Permission.photos.request().isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        urlFoto = image.path;

        // setState(() {
        //   urlFoto = image.path;
        // });
      }
    } else {
      Get.defaultDialog(
          title: "title permissao galeria!",
          middleText: "Permissao galerica",
          backgroundColor: Colors.green,
          titleStyle: const TextStyle(color: Colors.white),
          middleTextStyle: const TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            CupertinoDialogAction(
              child: Text("Fechar"),
              onPressed: () => Get.back(),
            ),
            CupertinoDialogAction(
              child: Text("Permissao galeria"),
              onPressed: () => openAppSettings().then((value) => Get.back()),
            ),
          ]);
    }
  }

  dynamic opcaoFoto() {
    Get.defaultDialog(
        title: "title permissao galeria!",
        middleText: "Permissao galerica",
        backgroundColor: Colors.green,
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
        radius: 30,
        actions: [
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
        ]);
  }

  String validarNome(String value) {
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

  String validarSenha(String value) {
    if (value.length == 0) {
      return "Informe a Senha";
    } else if (value.length < 4) {
      return "Senha minima de 4 dígitos";
    }
    return null;
  }

  String validarConfirmarSenha(String value) {
    if (value.length == 0) {
      return "Informe a senha novamente";
    } else if (confirmarSenhaController.text != senhaController.text) {
      return "Porfavor digite a mesma senha";
    }
    return null;
  }

  String validarEmail(String value) {
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

  sendForm() {
    if (key.currentState.validate()) {
      key.currentState.save();
    }
  }

  void preencherCarregando(bool value) {
    carregando = value;

    // setState(() {
    // });
  }

  void criarConta() async {
    preencherCarregando(true);
    var usuarioModel = new CriarContaModel(
        nomeController.text,
        emailController.text,
        senhaController.text,
        confirmarSenhaController.text,
        urlFoto,
        nomeUsuarioController.text);
    var response = await usuarioService.criarUsuario(usuarioModel);

    //verifica se é um usuario, se for deu sucesso
    if (response is UsuarioModel) {
      preencherCarregando(false);
      final snackbar = SnackBar(
        content: Text('Usuario criado com sucesso.'),
        backgroundColor: Colors.blue,
      );
      scaffoldKey.currentState.showSnackBar(snackbar);

      //delay apos criar
      // new Future.delayed(new Duration(seconds: 2), () {
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      //       builder: (context) => HomePage()
      //   ), (route) => false);
      // });
    } else {
      preencherCarregando(false);
      ResponseModel responseModel = response;
      final snackbar = SnackBar(
        content: Text(responseModel.Objeto.toString()
            .replaceAll("[", "")
            .replaceAll("]", "")),
        backgroundColor: ThemeApp.snackBarMensagemEnvio,
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  atualizarUrl(String path) {
    urlFoto = path;
  }

  fecharGaleria() {
    // Navigator.of(context).pop();
  }
}
