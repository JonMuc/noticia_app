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

  Future<bool> salvarSubComentario(String mensagem, int idNoticia, int idComentario) async {
    var data =  {
      "Mensagem": mensagem.toString(),
      "IdNoticia": idNoticia,
      "IdComentario": idComentario,
    };
    var url = "${Settings.apiUrl}/comentario/comentar-comentario";
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

  Future<bool> excluirSubComentario(int idComentario) async {
    var url = "${Settings.apiUrl}/comentario/excluir-comentario-noticia/" + idComentario.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return responseModel.Sucesso;
  }

  Future<bool> curtirComentario(int idComentario, int tipo) async {
    var url = "${Settings.apiUrl}/avaliacao/comentario";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;

    var request = {
      "IdComentario": idComentario,
      "TipoAvaliacao": tipo
    };

    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return responseModel.Sucesso;
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

  Future<List<ComentarioViewModel>> listarComentario(int idNoticia, int pageIndex, int pageSize) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia/" + idNoticia.toString() + "/" + pageIndex.toString() + "/" + pageSize.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }

  Future<List<ComentarioViewModel>> listarComentarioDeslogado(int idNoticia, int pageIndex, int pageSize) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia-deslogado/" + idNoticia.toString() + "/" + pageIndex.toString() + "/" + pageSize.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }


  Future<List<ComentarioViewModel>> listarSubComentario(int idComentario) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentarios-de-comentario/" + idComentario.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }

  Future<List<ComentarioViewModel>> listarSubComentarioDeslogado(int idComentario) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentarios-de-comentario-deslogado/" + idComentario.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }
}
