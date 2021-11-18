import 'dart:convert';
import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/repository/usuario.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService extends ChangeNotifier {
  UsuarioModel usuarioModel = null;
  ResponseModel responseModel = null;
  final usuarioRepository = new UsuarioRepository();
  final noticiaRepository = new NoticiaRepository();

  Future criarUsuario(CriarContaModel criarContaModel) async{
    try{
      var response = await this.usuarioRepository.criarUsuario(criarContaModel);
      if(response is UsuarioModel){
        this.usuarioModel = response;

        //ADICIONANDO USUARIO
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        if(sharedPreferences.containsKey("usuario")){
          sharedPreferences.remove("usuario");
        }
        await sharedPreferences.setString("usuario", jsonEncode(this.usuarioModel));
        return this.usuarioModel;
      }else{
        this.responseModel = response;
        return this.responseModel;
      }
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

  Future<bool> verificarUsuarioLogado() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      print(sharedPreferences.get("usuario"));
      if(sharedPreferences.containsKey("usuario")){
        print("return true");
        return true;
      }
      return false;
  }

  Future<UsuarioModel> obterUsuarioLogado() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("usuario")){
      UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
      return usuarioModel;
    }
    return null;
  }

  Future limparSecao() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("usuario")) {
      sharedPreferences.remove("usuario");
      // sharedPreferences.remove("urlImage");
      // sharedPreferences.remove("appCode");
    }
  }

  Future <UsuarioModel> fazerLogin(UsuarioLoginModel usuarioLoginModel) async {
    var usuarioLogado = await usuarioRepository.fazerLogin(usuarioLoginModel);
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("usuario", jsonEncode(usuarioLogado));
      return usuarioLogado;
    } catch (ex){
      usuarioLogado = null;
      return usuarioLogado;
    }
  }
}
