import 'package:app_noticia/repository/avaliacao.repository.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';

class AvaliacaoService extends ChangeNotifier {
  final avaliacaoRepository = new AvaliacaoRepository();
  final usuarioService = new UsuarioService();

  Future<bool> avaliarNoticia(int idNoticia, int tipoAvaliacao) async{
    return await this.avaliacaoRepository.avaliarNoticia(idNoticia, tipoAvaliacao);
  }
}
