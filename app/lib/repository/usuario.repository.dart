import 'dart:convert';

import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';


class UsuarioRepository {
  Future <UsuarioModel> fazerLogin(CriarContaModel criarContaModel) async {
    var url = "${Settings.apiUrl}/login/logar";
    Dio dio = new Dio();
    Response response = await dio.post(url, data: (criarContaModel)); // jsonEncode
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    UsuarioModel usuarioModel = UsuarioModel.fromJson(responseModel.Objeto);

    print('repositorio login');
    print(responseModel.Objeto);
  }
  Future criarUsuario(CriarContaModel criarContaModel) async {
    var url = "${Settings.apiUrl}/usuario/criar-usuario-step";
    Dio dio = new Dio();
    print(Settings.apiUrl);
    print(jsonEncode(criarContaModel));
    Response response = await dio.post(url, data: jsonEncode(criarContaModel));
    print(response.statusCode);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    print(responseModel.Objeto);
  }
}
