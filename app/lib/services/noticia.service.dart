import 'package:app_noticia/models/comentario.model.dart';
import 'package:app_noticia/models/noticia.model.dart';
import 'package:app_noticia/repository/comentario.repository.dart';
import 'package:app_noticia/repository/noticia.repository.dart';
import 'package:flutter/cupertino.dart';

class NoticiaService extends ChangeNotifier {
  final noticiaRepository = new NoticiaRepository();
  final comentarioRepository = new ComentarioRepository();

  Future<List<NoticiaModel>> obterManchetes() async{
    var result = await this.noticiaRepository.listarManchete();
    print('Service');
    print(result.length);
    return result;
  }

}
