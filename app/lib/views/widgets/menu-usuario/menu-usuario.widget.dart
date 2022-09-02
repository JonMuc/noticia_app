import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/pages/perfil-usuario/perfil-usuario.page.dart';
import 'package:app_noticia/views/widgets/fazer-login/fazer-login.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MenuUsuarioWidget extends StatelessWidget{
  final usuarioService = Get.find<UsuarioService>();

  @override
  Widget build(BuildContext context){
    return usuarioService.usuarioLogado ? PerfilUsuarioPage() : FazerLoginWidget();
  }
}