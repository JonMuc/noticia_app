import 'package:app/models/noticia.model.dart';
import 'package:app/repository/manchete.repository.dart';
import 'package:flutter/cupertino.dart';

class NoticiaService extends ChangeNotifier {
  final mancheteRepository = new MancheteRepository();

  Future<List<NoticiaModel>> obterManchetes() async{
    var result = await this.mancheteRepository.listarManchete();
    print('Service');
    print(result.length);
    return result;
  }
}
