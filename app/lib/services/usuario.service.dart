import 'package:app/models/criar-conta.model.dart';
import 'package:app/models/usuario.model.dart';
import 'package:app/repository/usuario.repositorio.dart';
import 'package:flutter/cupertino.dart';

class UsuarioService extends ChangeNotifier {
  final usuarioRepository = new UsuarioRepository();


  Future criarUsuario(CriarContaModel criarContaModel) async{
    var result = await this.usuarioRepository.criarUsuario();
    print('usuario,service');
  }
}
