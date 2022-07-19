import 'package:app_noticia/models/chat-lista.model.dart';
import 'package:flutter/material.dart';

class ItemChatListaWidget extends StatefulWidget {
  ChatListaModel chatListaModel;

  ItemChatListaWidget({Key key, this.chatListaModel}) : super(key: key);

  @override
  _ItemChatListaWidget createState() => _ItemChatListaWidget();
}

class _ItemChatListaWidget extends State<ItemChatListaWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.chatListaModel.Foto),
          ),
          Center(
            child: Text(widget.chatListaModel.Nome),
          )
        ],
      ),
    );
  }
}
