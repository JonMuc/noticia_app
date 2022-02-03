import 'dart:convert';

import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WidgetRespostaComentarioNoticia extends StatefulWidget {
  final ComentarioViewModel comentarioViewModel;
  WidgetRespostaComentarioNoticia({@required this.comentarioViewModel});

  @override
  _WidgetRespostaComentarioNoticia createState() => _WidgetRespostaComentarioNoticia();
}

class _WidgetRespostaComentarioNoticia extends State<WidgetRespostaComentarioNoticia> {
  List<ComentarioViewModel> listaDeComentarios = List.empty();
  // final noticia = NoticiaModel();
  final comentarioService = new ComentarioService();

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.comentarioViewModel.IdComentario);
    return Center(
      child:
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    // alignment: Alignment(-0.95, 0.90),
                    padding: EdgeInsets.only(top: 7),
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage(
                          widget.comentarioViewModel.UrlFoto ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    // child: Text('Usuario: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.blue),),
                    child: Text(widget.comentarioViewModel.Nome + ":", style: TextStyle(fontSize: 15))
                  ),
                  Container(
                    child: Text(widget.comentarioViewModel.Mensagem, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black))
                      // child: Text("comentario do usuarioo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.blue))
                  ),
                ],
              ),

            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 10),
                        children: [
                          TextSpan(
                            text: "23h",
                          )
                        ],
                      ),
                    ),
                  ),
                ],

              ),
            )
          ],
        )
      )
    );
  }



  // void listarComentarios(BuildContext context) async {
  //   print(2342);
  //   var listaComentarioResponse = await comentarioService.listarComentario();
  //   setState(() {
  //     this.listaDeComentarios = listaComentarioResponse;
  //   });
  // }


  var usuarioLogado = true;
  Future fazerComentario(BuildContext context) async {
    print('kaka');
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    // var comentarioModel = new ComentarioModel(commentController.text, widget.noticiaModel.Id);
    // var fazerComentarioResponse = await service.fazerComentario(comentarioModel);  ---< certo
  }

}