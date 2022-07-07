import 'package:app_noticia/models/request/noticia-request.model.dart';
import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';

class NoticiaService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();
  final usuarioService = new UsuarioService();
  NoticiaRequestModel request = new NoticiaRequestModel(0, 5, 0);

  Future<List<ViewNoticiaModel>> obterManchetes(int pageIndex, int idBase) async{
    request.PageIndex = pageIndex;
    request.IdBase = idBase;
    var user = await usuarioService.obterUsuarioLogado();
    if(user == null){
      var result = await this.noticiaRepository.listarMancheteDeslogado(request);
      return result;
    }else{
      return await this.noticiaRepository.listarManchete(request);
    }
  }

}
