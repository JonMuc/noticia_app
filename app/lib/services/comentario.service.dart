import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:eventify/eventify.dart';
import 'package:flutter/cupertino.dart';

class ComentarioService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();
  final usuarioService = new UsuarioService();
  ComentarioViewModel responderComentarioModel = null;
  EventEmitter subComentarioRealizado = new EventEmitter();

  Future <List<ComentarioViewModel>> listarComentario(int idNoticia, int pageIndex, int pageSize) async {
    if(await usuarioService.verificarUsuarioLogado()){
      var result = await this.comentarioRepository.listarComentario(idNoticia, pageIndex, pageSize);
      print("numero de comentarios > "  +result.length.toString());
      return result;
    }else{
      var result = await this.comentarioRepository.listarComentarioDeslogado(idNoticia, pageIndex, pageSize);
      return result;
    }
  }

  Future <List<ComentarioViewModel>> listarSubComentario(int idComentario, int pageIndex, int pageSize) async {
    if(await usuarioService.verificarUsuarioLogado()){
      var result = await this.comentarioRepository.listarSubComentario(idComentario, pageIndex, pageSize);
      return result;
    }else{
      var result = await this.comentarioRepository.listarSubComentarioDeslogado(idComentario, pageIndex, pageSize);
      return result;
    }
  }

  Future<bool> avaliarComentario(int idComentario, int tipoAvaliacao) async {
    return await this.comentarioRepository.curtirComentario(idComentario, tipoAvaliacao);
  }

  Future<bool> fazerComentario(String mensagem, int idNoticia) async{
    if(responderComentarioModel == null){
      return await this.comentarioRepository.salvarComentario(mensagem, idNoticia);
    }else{
      var result = await this.comentarioRepository.salvarSubComentario(mensagem, idNoticia, responderComentarioModel.IdComentario);
      if(result){
        responderComentarioModel = null;
        subComentarioRealizado.emit("subComentarioRealizado", true);
      }
      return result;
    }
  }

  Future<bool> excluirComentario(int idComentario) async {
    return await this.comentarioRepository.excluirComentario(idComentario);
  }
}
