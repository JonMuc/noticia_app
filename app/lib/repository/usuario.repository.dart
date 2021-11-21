import 'dart:convert';
import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';


class UsuarioRepository {

  Future fazerLogin(UsuarioLoginModel usuarioLoginModel) async {
    try{
      var url = "${Settings.apiUrl}/login/logar";
      Dio dio = new Dio();
      Response response = await dio.post(url, data: jsonEncode(usuarioLoginModel));
      ResponseModel responseModel = ResponseModel.fromJson(response.data);
      UsuarioModel usuarioModel = UsuarioModel.fromJson(responseModel.Objeto);
      return usuarioModel;
    }catch(e){
      return ResponseModel.fromJson(e.response.data);
    }
  }

  Future criarUsuario(CriarContaModel criarContaModel) async {
    try{
      var url = "${Settings.apiUrl}/usuario/criar-usuario-step";
      Dio dio = new Dio();
      Response response = await dio.post(url, data: jsonEncode(criarContaModel));
      ResponseModel responseModel = ResponseModel.fromJson(response.data);
      return UsuarioModel.fromJson(responseModel.Objeto);
    } catch (e) {
      return ResponseModel.fromJson(e.response.data);
    }
  }

}
