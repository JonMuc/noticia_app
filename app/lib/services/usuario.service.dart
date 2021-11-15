import 'dart:convert';
import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/repository/usuario.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService extends ChangeNotifier {
  UsuarioModel usuarioModel;
  final usuarioRepository = new UsuarioRepository();
  final noticiaRepository = new NoticiaRepository();
  //
  // Future fazerLogin(CriarContaModel criarContaModel) async{
  //   var result = await this.usuarioRepository.fazerLogin(criarContaModel);
  //   print('service login');
  //
  // }

  Future<UsuarioModel> criarUsuario(CriarContaModel criarContaModel) async{
    try{
      this.usuarioModel = await this.usuarioRepository.criarUsuario(criarContaModel);

      //ADICIONANDO USUARIO
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.containsKey("usuario")){
        sharedPreferences.remove("usuario");
      }
      await sharedPreferences.setString("usuario", jsonEncode(this.usuarioModel));
      print(sharedPreferences.get("usuario"));
      return this.usuarioModel;
    }catch(ex){
      this.usuarioModel = null;
      return this.usuarioModel;
    }
  }

  Future fazerComentario(String mensagem, int idNoticia) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("usuario")) {
      UsuarioModel user = UsuarioModel.fromJson(sharedPreferences.get("usuario"));
      var result = await this.noticiaRepository.salvarComentario(mensagem, idNoticia, user.Id);
    }
  }

  void limparSecao() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("usuario")) {
      sharedPreferences.remove("usuario");
      sharedPreferences.remove("urlImage");
      sharedPreferences.remove("appCode");
    }
  }

  Future <UsuarioModel> fazerLogin(UsuarioLoginModel usuarioLoginModel) async {
    print(usuarioLoginModel.Senha);
    var usuarioLogado = await usuarioRepository.fazerLogin(usuarioLoginModel);
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
