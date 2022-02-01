import 'dart:convert';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AvaliacaoRepository {

  Future<bool> avaliarNoticia(int idNoticia, int tipoAvaliacao) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    var data =  {
      "IdNoticia": idNoticia,
      "TipoAvaliacao": tipoAvaliacao
    };
    var url = "${Settings.apiUrl}/avaliacao/noticia";
    Response response = await dio.post(url, data: data);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return responseModel.Sucesso;
  }
}
