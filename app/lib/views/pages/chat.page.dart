import 'package:app_noticia/models/chat-lista.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/chat.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/themes/style_app.dart';
import 'package:app_noticia/views/widgets/item-chat-lista-noticia.widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPage createState() => _ChatPage();
}
class _ChatPage extends State<ChatPage> with SingleTickerProviderStateMixin {
  int quantPermissaoGaleria;
  UsuarioModel usuario;
  List<ChatListaModel> chatList = List.filled(0, null, growable: true);


  @override
  initState() {
    obterListaMensagens();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: ThemeApp.backGround,
        appBar: new AppBar(
          title: new Text('Chat'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(usuario),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(usuario);
                  },
                  child: Icon(
                    Icons.check,
                    size: 26.0,
                  ),
                )
            ),
          ],
        ),
        body: ListView.separated(
          // controller: controller,
          padding: EdgeInsets.only(top: 5),
          itemCount: chatList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.transparent,
          ),
          itemBuilder: (BuildContext context, int index) {
            final ChatListaModel chat = chatList[index];
            return ItemChatListaWidget(chatListaModel: chat,);
          },
        )
    );
  }

  obterListaMensagens()  async{
    ChatService service = Provider.of<ChatService>(context, listen: false);
    var value = await service.listarChats();
    print(123213321);
    setState(() {
      this.chatList = value;
    });
  }
}