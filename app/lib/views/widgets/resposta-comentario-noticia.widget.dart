import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:flutter/material.dart';


class RespostaComentarioNoticiaWidget extends StatefulWidget {
  final ComentarioViewModel comentarioViewModel;
  Function() atualizarComentarios;
  Function() msgNaoLogado;


  RespostaComentarioNoticiaWidget({@required this.comentarioViewModel, this.atualizarComentarios, this.msgNaoLogado});

  @override
  _RespostaComentarioNoticiaWidget createState() => _RespostaComentarioNoticiaWidget();
}

class _RespostaComentarioNoticiaWidget extends State<RespostaComentarioNoticiaWidget> {
  final usuarioService = new UsuarioService();
  final comentarioService = new ComentarioService();
  final GlobalKey _menuKey = GlobalKey();
  Function() atualizarComentarios;
  int idUsuarioLogado = 0;

  @override
  void initState() {
    obterIdUsuario();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundImage: widget.comentarioViewModel.UrlFoto == null ? AssetImage("assets/user.png")
                          : NetworkImage(widget.comentarioViewModel.UrlFoto),
                    ),
                  ),
                  Expanded(
                      child: RichText(
                        overflow: TextOverflow.visible,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.comentarioViewModel.Nome + ": ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black)),
                            TextSpan(
                                text: widget.comentarioViewModel.Mensagem,
                                style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4), fontSize: 10),
                      children: [
                        TextSpan(
                          text: "23h",
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: widget.comentarioViewModel.QuantidadeLike
                                  .toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          likeComentario(context, widget.comentarioViewModel.IdComentario);
                        },
                        icon: Icon(
                          Icons.thumb_up_alt,
                          color:
                          widget.comentarioViewModel.ComentarioAvaliado == 1 ? Colors.blue : Colors.grey,
                        ),
                        iconSize: 15.0,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: widget.comentarioViewModel.QuantidadeDeslike
                                  .toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          deslikeComentario(context,widget.comentarioViewModel.IdComentario);
                        },
                        icon: Icon(
                          Icons.thumb_down_alt,
                          color:
                          widget.comentarioViewModel.ComentarioAvaliado == 2 ? Colors.red : Colors.grey,
                          // color: Colors.red,
                        ),
                        iconSize: 15.0,
                      ),
                    )
                  ],
                ),
                widget.comentarioViewModel.IdUsuario == idUsuarioLogado || true ? Container(
                  child: PopupMenuButton<bool>(
                    key: _menuKey,
                    iconSize: 0,
                    onSelected: (bool result) {
                      setState(() {
                        deletarComentario();
                      });
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
                      PopupMenuItem<bool>(
                        value: true,
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                ) : Container(),
              ],
            ),
          ],
        )
      )
    );
  }


  obterIdUsuario() async{
    var user = await usuarioService.obterUsuarioLogado();
    if(user != null){
      setState(() {
        idUsuarioLogado = user.Id;
      });
    }
  }

  void deletarComentario() async {
    var responseDelete = await comentarioService.excluirComentario(widget.comentarioViewModel.Id);
    if(responseDelete){
      widget.atualizarComentarios();
    }
  }

  void likeComentario(BuildContext context, int idComentario) async {
    if(idUsuarioLogado != 0){
      var likeComentarioResponse =  await comentarioService.avaliarComentario(idComentario, 1);
      if(likeComentarioResponse){
        setState(() {
          if(widget.comentarioViewModel.ComentarioAvaliado == 1){
            widget.comentarioViewModel.ComentarioAvaliado = 0;
            widget.comentarioViewModel.QuantidadeLike--;
          }else{
            if(widget.comentarioViewModel.ComentarioAvaliado == 2){
              widget.comentarioViewModel.QuantidadeDeslike--;
            }
            widget.comentarioViewModel.ComentarioAvaliado = 1;
            widget.comentarioViewModel.QuantidadeLike++;
          }
        });
      }
    }else{
      widget.msgNaoLogado();
    }
  }

  void deslikeComentario(BuildContext context, int idComentario) async {
    if(idUsuarioLogado != 0){
      var likeComentarioResponse =  await comentarioService.avaliarComentario(idComentario, 2);
      if(likeComentarioResponse){
        setState(() {
          if(widget.comentarioViewModel.ComentarioAvaliado == 2){
            widget.comentarioViewModel.ComentarioAvaliado = 0;
            widget.comentarioViewModel.QuantidadeDeslike--;
          }else{
            if(widget.comentarioViewModel.ComentarioAvaliado == 1){
              widget.comentarioViewModel.QuantidadeLike--;
            }
            widget.comentarioViewModel.ComentarioAvaliado = 2;
            widget.comentarioViewModel.QuantidadeDeslike++;
          }
        });
      }
    }else{
      widget.msgNaoLogado();
    }
  }
}