import 'dart:convert';
import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ComentarioRepository {

  Future<bool> salvarComentario(String mensagem, int idNoticia) async {
    var data =  {
      "Mensagem": mensagem.toString(),
      "IdNoticia": idNoticia,
    };
    var url = "${Settings.apiUrl}/comentario/salvar-comentario-noticia";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.post(url, data: data);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return responseModel.Sucesso;
  }

  Future<bool> excluirComentario(int idComentario) async {
    var url = "${Settings.apiUrl}/comentario/excluir-comentario-noticia/" + idComentario.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return responseModel.Sucesso;
  }

  Future curtirComentario(int idUsuario, int idComentario, int tipo) async {
    var url = "${Settings.apiUrl}/avaliacao/comentario";
    Dio dio = new Dio();
    //print(Settings.apiUrl);
    var request = {

      "IdUsuario": idUsuario,
      "IdComentario": idComentario,
      "TipoAvaliacao": tipo
    };
    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }
  Future excluirAvaliacaoComentario(int idUsuario, int idComentario) async {
    var url = "${Settings.apiUrl}/avaliacao/excluir-avaliacao-comentario";
    Dio dio = new Dio();
    var request = {
      "idUsuario": idUsuario,
      "idComentario": idComentario
    };
    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }

  Future descurtirComentario(int idUsuario, int idComentario) async {
    var url = "${Settings.apiUrl}/avaliacao/comentario";
    Dio dio = new Dio();
    var request = {
      "IdUsuario": idUsuario,
      "IdComentario": idComentario,
      "TipoAvaliacao": 2
    };
    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }
 Future obterLikeComentario(int idUsuario, int idComentario) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia";
    Dio dio = new Dio();
    var request = {
      "IdUsuario": idUsuario,
      "IdComentario": idComentario,
      "TipoAvaliacao": 2
    };
    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }

  Future<List<ComentarioViewModel>> listarComentario(int idNoticia) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia/" + idNoticia.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }

  Future<List<ComentarioViewModel>> listarComentarioDeslogado(int idNoticia) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia-deslogado/" + idNoticia.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }

}
