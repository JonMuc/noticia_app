import 'package:app_noticia/models/comentario.model.dart';
import 'package:app_noticia/models/noticia.model.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:flutter/cupertino.dart';

class NoticiaService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();

  Future<List<NoticiaModel>> obterManchetes() async{
    var result = await this.noticiaRepository.listarManchete();
    print('Service');
    print(result.length);
    return result;
  }

  Future trazerComentario(ComentarioModel comentarioModel) async{
    var result = await this.noticiaRepository.trazerComentario(comentarioModel);
    print(comentarioModel);
  }

}
