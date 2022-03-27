import 'dart:convert';
import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
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

  Future atualizarUsuario(UsuarioModel model) async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
      var url = "${Settings.apiUrl}/usuario/atualizar-usuario";
      Dio dio = new Dio();
      dio.options.headers['token'] = usuarioModel.Token;
      Response response = await dio.post(url, data: jsonEncode(model));
      ResponseModel responseModel = ResponseModel.fromJson(response.data);
      return UsuarioModel.fromJson(responseModel.Objeto);
    } catch (e) {
      return ResponseModel.fromJson(e.response.data);
    }
  }

  Future <List<UsuarioModel>> buscarUsuario(String nomeUsuario) async {
    var url = "${Settings.apiUrl}/usuario/buscar-usuario/" + nomeUsuario.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    print(responseModel.Sucesso);
    return (responseModel.Objeto as List).map((usuario) => UsuarioModel.fromJson(usuario)).toList();
  }

  Future <UsuarioModel> buscarUsuarioPorId(int idUsuario) async {
    var url = "${Settings.apiUrl}/usuario/visualizar-usuario/" + idUsuario.toString();
    Dio dio = new Dio();
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return UsuarioModel.fromJson(responseModel.Objeto);
  }

    Future seguirUsuario(int idUsuarioSeguido, int idUsuarioSeguidor) async {
    print("seguir usuario repos");
    var url = "${Settings.apiUrl}/usuario/seguir-usuario/" + idUsuarioSeguido.toString() + "/" + idUsuarioSeguidor.toString();
    Dio dio = new Dio();
    Response response = await dio.post(url);
    print("Seguidor:" + idUsuarioSeguidor.toString() + "  Seguido:" + idUsuarioSeguido.toString());
  }

  Future desseguirUsuario(int idUsuarioSeguido, int idUsuarioSeguidor) async {
    print("seguir usuario repos");
    var url = "${Settings.apiUrl}/usuario/seguir-usuario/" + idUsuarioSeguido.toString() + "/" + idUsuarioSeguidor.toString();
    Dio dio = new Dio();
    Response response = await dio.post(url);
    print("Seguidor:" + idUsuarioSeguidor.toString() + "  Seguido:" + idUsuarioSeguido.toString());
  }

  Future<String> salvarFotoUser(dynamic multipartFile, int idUsuario) async {
    var url = "${Settings.apiUrl}/usuario/enviar-foto/" + idUsuario.toString();
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.files.add(multipartFile);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    ResponseModel responseModel = ResponseModel.fromJson(json.decode(response.body));
    return responseModel.Objeto;
  }

  Future<String> editarFotoUser(dynamic multipartFile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
    var url = "${Settings.apiUrl}/usuario/editar-foto";
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.headers["token"] = usuarioModel.Token;
    request.files.add(multipartFile);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    ResponseModel responseModel = ResponseModel.fromJson(json.decode(response.body));
    return responseModel.Objeto;
  }
}
