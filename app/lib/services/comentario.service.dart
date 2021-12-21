import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:flutter/cupertino.dart';

class ComentarioService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();

  Future <List<ComentarioViewModel>> listarComentario() async {
    var result = await this.comentarioRepository.listarComentario();
    print('service ListarComentario');
    return result;
  }

  Future curtirComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.curtirComentario(idUsuario, idComentario, 1);
  }
  Future excluirAvaliacaoComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.excluirAvaliacaoComentario(idUsuario, idComentario);
  }
 Future descurtirComentario(int idUsuario, int idComentario) async {
    print('SERVICE DESLIKE');
    var result = await this.comentarioRepository.curtirComentario(idUsuario, idComentario, 2);
 }

  Future fazerComentario(String mensagem, int idNoticia, int idUsuario) async{
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // if (sharedPreferences.containsKey("usuario")) {
      //   UsuarioModel user = UsuarioModel.fromJson(sharedPreferences.get("usuario"));
      //   user.Id = 1;
      //   var result = await this.comentarioRepository.salvarComentario(mensagem, idNoticia, user.Id);
      //   print('caiu aquuui');
      // }
    //UsuarioModel user = UsuarioModel.fromJson(sharedPreferences.get("usuario"));
    UsuarioModel user = new UsuarioModel.d();
    user.Id = 1;
    var result = await this.comentarioRepository.salvarComentario(mensagem, idNoticia, user.Id);
  }
}
