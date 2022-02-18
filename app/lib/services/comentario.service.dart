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
    if(await usuarioService.verificarUsuarioLogado()){
      var result = await this.comentarioRepository.listarComentario(idNoticia);
      return result;
    }else{
      var result = await this.comentarioRepository.listarComentarioDeslogado(idNoticia);
      return result;
    }
  }

  Future avaliarComentario(int idComentario, int tipoAvaliacao) async {
    var result = await this.comentarioRepository.curtirComentario(idComentario, tipoAvaliacao);
  }

  Future excluirAvaliacaoComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.excluirAvaliacaoComentario(idUsuario, idComentario);
  }

 Future descurtirComentario(int idUsuario, int idComentario) async {
    var result = await this.comentarioRepository.curtirComentario(idComentario, 2);
 }

  Future<bool> fazerComentario(String mensagem, int idNoticia) async{
    return await this.comentarioRepository.salvarComentario(mensagem, idNoticia);
  }

  Future<bool> excluirComentario(int idComentario) async {
    return await this.comentarioRepository.excluirComentario(idComentario);
  }
}
