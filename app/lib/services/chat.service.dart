import 'package:app_noticia/models/chat-lista.model.dart';
import 'package:app_noticia/models/request/noticia-request.model.dart';
import 'package:app_noticia/repository/chat.repository.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/cupertino.dart';

class ChatService extends ChangeNotifier {
  final chatRepository = new ChatRepository();
  final usuarioService = new UsuarioService();

  NoticiaRequestModel request = new NoticiaRequestModel(0, 5, 0);

  Future<List<ChatListaModel>> listarChats() async{
    return await this.chatRepository.listarChats();
  }
}
