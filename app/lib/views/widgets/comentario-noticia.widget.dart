import 'dart:convert';

import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/views/widgets/resposta-comentario-noticia.widget.dart';
import 'package:flutter/material.dart';


class WidgetComentarioNoticia extends StatefulWidget {
  final ComentarioViewModel comentarioViewModel;
  WidgetComentarioNoticia({@required this.comentarioViewModel});
  //final NoticiaModel noticiaModel;
  @override
  _WidgetComentarioNoticia createState() => _WidgetComentarioNoticia();
}

class _WidgetComentarioNoticia extends State<WidgetComentarioNoticia> {
  final comentarioService = new ComentarioService();
  List<ComentarioViewModel> listaRespostaComentarios;
  bool mostrarRespostaComentario = false;
  bool mostrarCampoRespostaComentario = false;
  int comentarioCurtido = 0;

  @override
  Widget build(BuildContext context){
    // if(mounted){
    //   if(listaRespostaComentarios.isEmpty){
    //     print("Listar noticias");
    //     listarComentarios(context);
    //   }}
    // print(widget.comentarioViewModel.IdComentario);
    if (widget.comentarioViewModel.ComentarioAvaliado == 1){
      comentarioCurtido = 1;
    } else if (widget.comentarioViewModel.ComentarioAvaliado == 2){
      comentarioCurtido = 2;
    }
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            // height: MediaQuery.of(context).size.height * 0.09,
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        // alignment: Alignment(-0.95, 0.90),
                        padding: EdgeInsets.only(top: 7),
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                              widget.comentarioViewModel.UrlFoto),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                          child: Text(widget.comentarioViewModel.Nome + ": ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black))
                      ),
                      Container(
                          child: Text(widget.comentarioViewModel.Mensagem, style: TextStyle(fontSize: 15))
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    GestureDetector(
                      child:Text('ver resposta'),
                      onTap: () {
                        listarComentarios(context);
                        mostrarRespostaComentario = mostrarRespostaComentario ? false : true;
                        setState(() {
                        });
                      },
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          if (comentarioCurtido == 0 || comentarioCurtido == 1){
                            deslikeComentario(context, widget.comentarioViewModel.IdComentario);
                            print('dar deslike');
                            comentarioCurtido = 2;
                            widget.comentarioViewModel.ComentarioAvaliado = 2;
                          } else {
                            excluirLikeComentario(context, widget.comentarioViewModel.IdComentario);
                            print('remover deslike');
                            widget.comentarioViewModel.ComentarioAvaliado = 0;
                            comentarioCurtido = 0;
                          }
                          setState(()  {
                          });
                          },
                        icon: Icon(
                          Icons.thumb_down_alt,
                          color: comentarioCurtido == 2 ? Colors.red : Colors.grey,
                          // color: Colors.red,
                        ),
                        iconSize: 15.0,
                      ),
                    ),
                    Container(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: widget.comentarioViewModel.QuantidadeDeslike.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          print("comentario avaliado ${widget.comentarioViewModel.ComentarioAvaliado}");
                          if (comentarioCurtido == 1){
                            excluirLikeComentario(context, widget.comentarioViewModel.IdComentario);
                            comentarioCurtido = 0;
                            widget.comentarioViewModel.ComentarioAvaliado = 0;
                          } else if (comentarioCurtido == 2 || comentarioCurtido == 0){
                            likeComentario(context, widget.comentarioViewModel.IdComentario);
                            comentarioCurtido = 1;
                            widget.comentarioViewModel.ComentarioAvaliado = 1;
                          }
                          setState(() {
                          });
                        },
                        icon: Icon(
                          Icons.thumb_up_alt,
                          color: comentarioCurtido == 1 ? Colors.blue : Colors.grey,
                        ),
                        iconSize: 15.0,
                      ),
                    ),
                    Container(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: widget.comentarioViewModel.QuantidadeLike.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          print('reply');
                          setState(() {
                            // mostrarCampoRespostaComentario = mostrarCampoRespostaComentario ? false : true;
                          });
                          },
                        icon: Icon(
                          Icons.reply,
                          color: Colors.blue,
                        ),
                        iconSize: 15.0,
                      ),
                    ),
                  ],
                ),
                mostrarRespostaComentario ? Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount:  listaRespostaComentarios.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Colors.transparent,
                      height: 0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      listarComentarios(context);
                      print('item builder');
                      final ComentarioViewModel comentarioViewModel = listaRespostaComentarios[index];
                      return Center(
                          child: WidgetRespostaComentarioNoticia(comentarioViewModel: comentarioViewModel)
                      );
                    },
                  ),
                ) : Container(),
              mostrarCampoRespostaComentario ? Container(
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                    ),
                  )
              ) : Container()
              ],
            )
        ),
    );

  }

  void responderComentario(){

  }

  void listarComentarios(BuildContext context) async {
    print('listar comentarios');
    var listaRespostaComentarioResponse = await comentarioService.listarComentario();
    this.listaRespostaComentarios = listaRespostaComentarioResponse;
    setState(() {
    });
  }

  void likeComentario(BuildContext context, int idComentario) async {
    // UsuarioService usuarioService = Provider.of<UsuarioService>(context, listen: false);
    //UsuarioModel usuarioLogado = await usuarioService.obterUsuarioLogado();
    //var usuarioId = usuarioLogado.Id;
    var usuarioId = 1;
    var likeComentarioResponse = await comentarioService.curtirComentario(usuarioId, idComentario);
  }
  void deslikeComentario(BuildContext context, int idComentario) async {
    // UsuarioService usuarioService = Provider.of<UsuarioService>(context, listen: false);
    //UsuarioModel usuarioLogado = await usuarioService.obterUsuarioLogado();
    //var usuarioId = usuarioLogado.Id;
    var usuarioId = 1;
    var deslikeComentarioResponse = await comentarioService.descurtirComentario(usuarioId, idComentario);
  }
  void excluirLikeComentario(BuildContext context, int idComentario) async {
    // UsuarioService usuarioService = Provider.of<UsuarioService>(context, listen: false);
    //UsuarioModel usuarioLogado = await usuarioService.obterUsuarioLogado();
    //var usuarioId = usuarioLogado.Id;
    var usuarioId = 1;
    var excluirLikeComentarioResponse = await comentarioService.excluirAvaliacaoComentario(usuarioId, idComentario);
  }

}