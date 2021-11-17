import 'package:app_noticia/models/noticia.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:provider/provider.dart';


class TelaComentarioNoticia extends StatefulWidget {
  final NoticiaModel noticiaModel;
  TelaComentarioNoticia({@required this.noticiaModel});

  @override
  _TelaComentarioNoticia createState() => _TelaComentarioNoticia();
}
class _TelaComentarioNoticia extends State<TelaComentarioNoticia> {
  final noticia = NoticiaModel();

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  List comentariosEstatico = [
  {
    'name': '1',
    'pic': 'https://picsum.photos/300/30',
    'message': 'I love to code'
  },
  {
    'name': '2',
    'pic': 'https://picsum.photos/300/30',
    'message': 'Vesssssry cool'
  },
  {
    'name': '3',
    'pic': 'https://picsum.photos/300/30',
    'message': 'Vesssssry cool'
  },
  {
    'name': '4',
    'pic': 'https://picsum.photos/300/30',
    'message': 'Vesssssry cool'
  }
  ];




  Widget TelaComentarios(data) {   //DATA = MENSAGEM
    print (widget.noticiaModel);
    return ListView(
      children: [
        Container(
          child: Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.history)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(widget.noticiaModel.Titulo.toString(), style: TextStyle(fontSize: 15, color: Colors.black))
              )
              //noticia.Titulo.toString(), style: TextStyle(fontSize: 17, color: Colors.white)
            ],
          ),
        ),
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: CommentBox(
          userImage:
          "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: TelaComentarios(comentariosEstatico),
          labelText: 'Escreva seu comentario',
          withBorder: false,
          errorText: 'Digite algo',
          sendButtonMethod: () async {
            if (formKey.currentState.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  "IdCriadoPor": 44,
                  "IdNoticia": 11,
                  "message": commentController.text
                };
                comentariosEstatico.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            };
            await fazerComentario(context);
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
  var usuarioLogado = true;
  Future fazerComentario(BuildContext context) async {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    //var comentarioModel = new ComentarioModel(commentController.text, widget.noticiaModel.Id);
    //var fazerComentarioResponse = await service.fazerComentario(comentarioModel);  ---< certo
  }

}