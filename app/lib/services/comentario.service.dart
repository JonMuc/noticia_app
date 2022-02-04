import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';

class ComentarioService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();
  final usuarioService = new UsuarioService();

  Future <List<ComentarioViewModel>> listarComentario(int idNoticia) async {
    var result = await this.comentarioRepository.listarComentario(idNoticia);
    return result;
  }

  Future curtirComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.curtirComentario(idUsuario, idComentario, 1);
  }

  Future excluirAvaliacaoComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.excluirAvaliacaoComentario(idUsuario, idComentario);
  }

 Future descurtirComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.curtirComentario(idUsuario, idComentario, 2);
 }

  Future<bool> fazerComentario(String mensagem, int idNoticia) async{
    return await this.comentarioRepository.salvarComentario(mensagem, idNoticia);
  }

  Future<bool> excluirComentario(int idComentario) async {
    return await this.comentarioRepository.excluirComentario(idComentario);
  }
}
