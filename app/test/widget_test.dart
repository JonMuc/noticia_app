import 'package:app/models/comentario.model.dart';
import 'package:app/models/noticia.model.dart';
import 'package:app/services/noticia.service.dart';
import 'package:app/services/usuario.service.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:provider/provider.dart';


class TelaComentarioNoticia extends StatefulWidget {
  TelaComentarioNoticia({@required this.noticiaModel});
  final NoticiaModel noticiaModel;
  // final ComentarioModel comentarioModel;

  @override
  _TelaComentarioNoticia createState() => _TelaComentarioNoticia();
}
class _TelaComentarioNoticia extends State<TelaComentarioNoticia> {
  final noticia = NoticiaModel();
  var usuarioLogado = false;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  Widget commentChild() {
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
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.person),
              ),
              title: Text("trazerComentario(context).toString()"),
              trailing: IconButton(
                icon: Icon(Icons.favorite),
              ),
              subtitle: Text("comentario"),
              dense: true,
              //onLongPress: ,
              //onTap: ,
            )

        ),

        // Padding(
        //   padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
        //   child: ListTile(
        //     leading: GestureDetector(
        //       onTap: () async {
        //         // Display the image in large form.
        //         print("Comment Clicked");
        //       },
        //       child: Container(
        //         height: 50.0,
        //         width: 50.0,
        //         decoration: new BoxDecoration(
        //             color: Colors.blue,
        //             borderRadius: new BorderRadius.all(Radius.circular(50))),
        //         child: CircleAvatar(
        //             radius: 50,
        //             backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
        //       ),
        //     ),
        //     title: Text(
        //       data[i]['name'],
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //     subtitle: Text(data[i]['message']),
        //   ),
        // )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina de comentarios"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: CommentBox(
          userImage:
          "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          //child: commentChild(filedata),
          labelText: 'Escreva seu comentario',
          withBorder: false,
          errorText: 'Digite algo',
          sendButtonMethod: () async {
            await fazerComentario(context);
            if (formKey.currentState.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                  'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                  'message': commentController.text
                };
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
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

  Future fazerComentario(BuildContext context) async {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    var comentarioModel = new ComentarioModel(commentController.text, usuarioLogado);
    var fazerComentarioResponse = await service.fazerComentario(comentarioModel);
  }


// Future trazerComentario(BuildContext context) async {
//   NoticiaService service = Provider.of<NoticiaService>(context, listen: false);
//   var comentarioModel = new ComentarioModel(commentController.text, usuarioLogado);
//   var trazerComentarioResponse = await service.trazerComentario(comentarioModel);
// }

}