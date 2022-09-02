import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/pages/cadastro-usuario/cadastro-usuario.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FazerLoginController extends GetxController {
  UsuarioService usuarioService = UsuarioService();
  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool carregando = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
  }


  void preencherCarregando(bool value) {
    carregando = value;
  }

  Future fazerLogin() async {
    preencherCarregando(true);
    var request =
    new UsuarioLoginModel(emailController.text, senhaController.text);
    var response = await usuarioService.fazerLogin(request);
    if (response is UsuarioModel) {
      // print(11111111);
      preencherCarregando(false);
      // Navigator.pop(context);
    } else {
      preencherCarregando(false);
      ResponseModel responseModel = response;
      print(responseModel.Objeto);
      final snackbar = SnackBar(
        content: Text(responseModel.Objeto.toString()
            .replaceAll("[", "")
            .replaceAll("]", "")),
        backgroundColor: ThemeApp.snackBarMensagemEnvio,
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  void navegarCriarConta(BuildContext context) async {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new CadastroUsuarioViewPage()))
        .then((value) => {
      if (value) {Navigator.pop(context)}
    });
  }

}