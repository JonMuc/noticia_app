import 'dart:convert';

import 'package:app/models/criar-conta.model.dart';
import 'package:app/models/usuario.model.dart';
import 'package:app/repository/usuario.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService extends ChangeNotifier {
  final usuarioRepository = new UsuarioRepository();

  Future fazerLogin(CriarContaModel criarContaModel) async{
    var result = await this.usuarioRepository.fazerLogin(criarContaModel);
    print('service login');

  }
  Future criarUsuario(CriarContaModel criarContaModel) async{
    var result = await this.usuarioRepository.criarUsuario(criarContaModel);
    print(criarContaModel.Nome);
  }


  void limparSecao() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("usuario")) {
      sharedPreferences.remove("usuario");
      sharedPreferences.remove("urlImage");
      sharedPreferences.remove("appCode");
    }
  }

  Future <UsuarioModel> entrar(CriarContaModel criarContaModel) async {
    var usuarioLogado = await usuarioRepository.fazerLogin(criarContaModel);
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("usuarioKey", jsonEncode(usuarioLogado));
      return usuarioLogado;
    } catch (ex){
      usuarioLogado = null;
      return usuarioLogado;
    }
  }



}
