import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';

class NoticiaService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();
  final usuarioService = new UsuarioService();

  Future<List<ViewNoticiaModel>> obterManchetes() async{
    var user = await usuarioService.obterUsuarioLogado();
    if(user == null){
      return await this.noticiaRepository.listarMancheteDeslogado();
    }else{
      return await this.noticiaRepository.listarManchete();
    }
  }

}
