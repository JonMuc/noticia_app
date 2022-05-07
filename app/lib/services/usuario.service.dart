import 'dart:convert';
import 'package:app_noticia/models/criar-conta.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/models/usuario-login.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/repository/usuario.repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';


class UsuarioService extends ChangeNotifier {
  UsuarioModel usuarioModel = null;
  ResponseModel responseModel = null;
  final usuarioRepository = new UsuarioRepository();
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();
  int quantPermissaoSolicita = 0;
  int quantPermissaoGaleria = 0;

  Future criarUsuario(CriarContaModel criarContaModel) async{
    try{
      var response = await this.usuarioRepository.criarUsuario(criarContaModel);
      if(response is UsuarioModel){
        if(criarContaModel.UrlFoto != ""){
          XFile imageFile = XFile(criarContaModel.UrlFoto);
          var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
          var length = await imageFile.length();
          var multipartFile = new http.MultipartFile('image', stream, length,
              filename: basename(imageFile.path));
          response.Foto = await usuarioRepository.salvarFotoUser(multipartFile, response.Id);
          print(response.Foto);
        }
        this.usuarioModel = response;
        await fazerLogin(new UsuarioLoginModel(response.Email, criarContaModel.Senha));
        //ADICIONANDO USUARIO
        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        // if(sharedPreferences.containsKey("usuario")){
        //   sharedPreferences.remove("usuario");
        // }
        // await sharedPreferences.setString("usuario", jsonEncode(this.usuarioModel));
        return this.usuarioModel;
      }else{
        this.responseModel = response;
        return this.responseModel;
      }
    }catch(ex){
      this.usuarioModel = null;
      return this.usuarioModel;
    }
  }

  Future<bool> verificarUsuarioLogado() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.get("usuario"));
    if(sharedPreferences.containsKey("usuario")){
      return true;
    }
    return false;
  }

  Future atualizarUsuario(UsuarioModel model) async {
    var response = await usuarioRepository.atualizarUsuario(model);
    if(response is UsuarioModel){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("usuario", jsonEncode(response));
      return response;
    }
  }

  Future atualizarCacheUsuario(UsuarioModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("usuario", jsonEncode(model));
  }

  Future <List<UsuarioModel>> buscarUsuario(String nomeUsuario) async {
    var response = await usuarioRepository.buscarUsuario(nomeUsuario);
    return response;
  }

 Future <List<UsuarioModel>> mostrarSeguidores(int idUsuario) async {
   var response = await usuarioRepository.mostrarSeguidores(idUsuario);
    return response;
  }

  Future <List<UsuarioModel>> mostrarSeguindo(int idUsuario) async {
    var response = await usuarioRepository.mostrarSeguindo(idUsuario);
    return response;
  }


  void seguirUsuario(int idUsuario) async {
    var usuarioLogado = new UsuarioModel.d();
    usuarioLogado = await obterUsuarioLogado();
    await usuarioRepository.seguirUsuario(idUsuario, usuarioLogado.Id);
  }

  void deseguirUsuario(int idUsuario) async {
    var usuarioLogado = new UsuarioModel.d();
    usuarioLogado = await obterUsuarioLogado();
    await usuarioRepository.deseguirUsuario(idUsuario, usuarioLogado.Id);
  }

  Future <UsuarioModel> buscarUsuarioPorId(int idUsuario) async {
    var response = await usuarioRepository.buscarUsuarioPorId(idUsuario);
    var perfilUsuario = await usuarioRepository.visualizarPerfilUsuario(idUsuario);
    response.quantidadeSeguidores = perfilUsuario.quantidadeSeguidores;
    response.quantidadeSeguindo = perfilUsuario.quantidadeSeguindo;
    return response;
  }

  Future <UsuarioModel> visualizarPerfilUsuario(int idUsuario) async {
    var response = await usuarioRepository.visualizarPerfilUsuario(idUsuario);
    return response;
  }

  Future<UsuarioModel> obterUsuarioLogado() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("usuario")){
      UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(sharedPreferences.get("usuario")));
      return usuarioModel;
    }
    return null;
  }

  Future limparSecao() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("usuario")) {
      sharedPreferences.remove("usuario");
    }
  }

  Future fazerLogin(UsuarioLoginModel usuarioLoginModel) async {
    var response = await usuarioRepository.fazerLogin(usuarioLoginModel);
    if(response is UsuarioModel){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString("usuario", jsonEncode(response));
      return response;
    }else{
      return response;
    }
  }

  Future salvarFotoUser(XFile imageFile, int idUser) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    return this.usuarioRepository.salvarFotoUser(multipartFile, idUser);
  }

  Future<String> alterarFoto(XFile imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    var url = await this.usuarioRepository.editarFotoUser(multipartFile);
    var user = await obterUsuarioLogado();
    user.Foto = url;
    await atualizarUsuario(user);
    return url;
  }
}
