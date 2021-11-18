import 'dart:convert';
import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';


class UsuarioRepository {

  Future<UsuarioModel>fazerLogin(UsuarioLoginModel usuarioLoginModel) async {
    var url = "${Settings.apiUrl}/login/logar";
    Dio dio = new Dio();
    Response response = await dio.post(url, data: jsonEncode(usuarioLoginModel)); // jsonEncode
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    if(responseModel.Sucesso){
      UsuarioModel usuarioModel = UsuarioModel.fromJson(responseModel.Objeto);
      return usuarioModel;
    }
    return null;
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
    // print(222222222);
    // print(jsonEncode(responseModel));
    // if(responseModel.Sucesso){
    // }else{
    //   print(222222222);
    //   print(jsonEncode(responseModel));
    //   return responseModel;
    // }
  }

}
