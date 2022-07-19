import 'dart:convert';
import 'package:app_noticia/models/chat-lista.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatRepository {


  Future<List<ChatListaModel>> listarChats() async {
    var url = "${Settings.apiUrl}/chat/listar-conversas";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    Dio dio = new Dio();
    dio.options.headers['token'] = usuarioModel.Token;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List)
        .map((obj) => ChatListaModel.fromJson(obj))
        .toList();
  }
}
