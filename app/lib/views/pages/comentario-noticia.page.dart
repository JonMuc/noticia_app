import 'dart:convert';

import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/noticia.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/shared/loader.widget.dart';
import 'package:app_noticia/views/widgets/comentario-noticia.widget.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class
TelaComentarioNoticia extends StatefulWidget {
  final NoticiaModel noticiaModel;
  TelaComentarioNoticia({@required this.noticiaModel});

  @override
  _TelaComentarioNoticia createState() => _TelaComentarioNoticia();
}
class _TelaComentarioNoticia extends State<TelaComentarioNoticia> {
  List<ComentarioViewModel> listaDeComentarios = List.empty();
  final comentarioService = new ComentarioService();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return ListaComentarios();
    //print(jsonEncode(listaDeComentarios));
    if(mounted){
      if(listaDeComentarios.isEmpty){
        print("Listar noticias");
        listarComentarios(context);
      }
      return Scaffold(
        body: Container(
          child: CommentBox(
            userImage:
            "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
            child: ListaComentarios(),
            labelText: 'Escreva seu comentario',
            withBorder: false,
            errorText: 'Digite algo',
            sendButtonMethod: () async {
              await fazerComentario(context, commentController.text);
              commentController.clear();
              listarComentarios(context);
            },
            commentController: commentController,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
          ),
        ),
      );
    }

    return Loader(
      callback: ListaComentarios,
      object: listaDeComentarios,
    );
  }

  Widget ListaComentarios() {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [

                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        child: ImageIcon(
                            AssetImage("logo_noticias/cnn.png")
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(widget.noticiaModel.Titulo.toString(), style: TextStyle(fontSize: 15, color: Colors.black))
                      )
                    ],
                  ),
                  // child: Row(
                  //   children: [
                  //     ImageIcon(
                  //       AssetImage("logo_noticias/cnn.png"),
                  //       color: Color(0xFF3A5A98),
                  //       size: 3,
                  //     ),
                  //     Container(
                  //         width: MediaQuery.of(context).size.width * 0.6,
                  //         child: Text(widget.noticiaModel.Titulo.toString(), style: TextStyle(fontSize: 15, color: Colors.black))
                  //     )
                  //   ],
                  // ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: listaDeComentarios.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Colors.transparent,
                      height: 0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final ComentarioViewModel comentarioViewModel = listaDeComentarios[index];
                      return Center(
                          child: WidgetComentarioNoticia(comentarioViewModel: comentarioViewModel)
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void listarComentarios(BuildContext context) async {
    print('listar comentarios');
    var listaComentarioResponse = await comentarioService.listarComentario();
    setState(() {
      this.listaDeComentarios = listaComentarioResponse;
    });
  }

  Future fazerComentario(BuildContext context, String comentario) async {
    print('Fazer comentario');
    UsuarioService usuarioService = Provider.of<UsuarioService>(context, listen: false);
    //ComentarioService comentarioService = Provider.of<ComentarioService>(context, listen: false);
    UsuarioModel usuarioLogado = await usuarioService.obterUsuarioLogado();
    //var usuarioId = usuarioLogado.Id;
    var usuarioId = 32;
    widget.noticiaModel.Id = 149;
    var fazerComentarioResponse = await comentarioService.fazerComentario(comentario, widget.noticiaModel.Id, usuarioId);
  }
}