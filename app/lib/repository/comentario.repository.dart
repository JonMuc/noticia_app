
import 'dart:convert';

import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';


class ComentarioRepository {

  Future salvarComentario(String mensagem, int idNoticia, int idCriadoPor) async {
    print("repositorio");
    var data =  {
      "Mensagem": mensagem.toString(),
      "IdNoticia": idNoticia,
      "IdCriadoPor": idCriadoPor,
    };
    var url = "${Settings.apiUrl}/comentario/salvar-comentario-noticia";
    Dio dio = new Dio();

    //print(Settings.apiUrl);
    Response response = await dio.post(url, data: data);
    //print(response.statusCode);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
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
    print(response.statusCode);
    print('COMENTARIO CURTIDO');
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }
  Future excluirAvaliacaoComentario(int idUsuario, int idComentario) async {
    var url = "${Settings.apiUrl}/avaliacao/excluir-avaliacao-comentario";
    Dio dio = new Dio();
    //print(Settings.apiUrl);
    var request = {
      "idUsuario": idUsuario,
      "idComentario": idComentario
    };
    print('REMOVIDO LIKE COMENTARIO');
    Response response = await dio.post(url, data: request);
    print(response.statusCode);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }

  Future descurtirComentario(int idUsuario, int idComentario) async {
    var url = "${Settings.apiUrl}/avaliacao/comentario";
    Dio dio = new Dio();
    //print(Settings.apiUrl);
    var request = {
      "IdUsuario": idUsuario,
      "IdComentario": idComentario,
      "TipoAvaliacao": 2
    };
    Response response = await dio.post(url, data: request);
    print(response.statusCode);
    print('LIKE DOWN');
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }
 Future obterLikeComentario(int idUsuario, int idComentario) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia";
    Dio dio = new Dio();
    //print(Settings.apiUrl);
    var request = {
      "IdUsuario": idUsuario,
      "IdComentario": idComentario,
      "TipoAvaliacao": 2
    };
    Response response = await dio.post(url, data: request);
    print(response.statusCode);
    print('COMENTARIO DESCURTIDO');
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
  }

  Future<List<ComentarioViewModel>> listarComentario() async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia";     //{idNoticia}
    Dio dio = new Dio();
    print(Settings.apiUrl);
    //print(jsonEncode(comentarioModel));
    var request =
      {
        "IdUsuario": 1,
        "IdNoticia": 149
      };
    Response response = await dio.post(url, data: request);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    print(jsonEncode(responseModel.Objeto));
    return (responseModel.Objeto as List).map((comentario) => ComentarioViewModel.fromJson(comentario)).toList();
  }

}
