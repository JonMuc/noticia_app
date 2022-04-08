import 'dart:convert';
import 'package:app_noticia/models/request/noticia-request.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NoticiaRepository {
  Future<List<ViewNoticiaModel>> listarManchete() async {
    var url = "${Settings.apiUrl}/noticia/listar-noticias";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List)
        .map((noticia) => ViewNoticiaModel.fromJson(noticia))
        .toList();
  }

  Future<List<ViewNoticiaModel>> listarMancheteDeslogado(NoticiaRequestModel request) async {
    var url = "${Settings.apiUrl}/noticiaG1/listar-manchete";
    Dio dio = new Dio();
    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List)
        .map((noticia) => ViewNoticiaModel.fromJson(noticia))
        .toList();
  }

}
