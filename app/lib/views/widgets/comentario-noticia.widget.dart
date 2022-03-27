import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/resposta-comentario-noticia.widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usuario.model.dart';
import '../pages/perfil.visitante.page..dart';


class WidgetComentarioNoticia extends StatefulWidget {
  final ComentarioViewModel comentarioViewModel;
  Function() atualizarComentarios;
  Function() responderComentario;
  Function() msgNaoLogado;

  WidgetComentarioNoticia({@required this.comentarioViewModel, this.atualizarComentarios, this.responderComentario, this.msgNaoLogado});

  @override
  _WidgetComentarioNoticia createState() => _WidgetComentarioNoticia();
}


class _WidgetComentarioNoticia extends State<WidgetComentarioNoticia> {
  final comentarioService = new ComentarioService();
  final usuarioService = new UsuarioService();
  List<ComentarioViewModel> listaRespostaComentarios;
  bool mostrarRespostaComentario = false;
  bool mostrarCampoRespostaComentario = false;
  int comentarioCurtido = 0;
  int idUsuarioLogado = 0;
  final GlobalKey _menuKey = GlobalKey();


  @override
  void initState() {
    ComentarioService service = Provider.of<ComentarioService>(context, listen: false);

    //evento ao responder
    service.subComentarioRealizado.on("subComentarioRealizado", null, (ev, context) {
      listarSubComentariosAoResponder();
    });
    obterIdUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onDoubleTap: () {
        if(widget.comentarioViewModel.IdUsuario == idUsuarioLogado){
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        }
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 7),
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundImage: widget.comentarioViewModel.UrlFoto ==
                                null
                            ? AssetImage("assets/user.png")
                            : NetworkImage(widget.comentarioViewModel.UrlFoto),
                      ),
                    ),
                    Expanded(
                        child: RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: widget.comentarioViewModel.Nome + ":: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => PerfilVisitantePage(idUsuario: widget.comentarioViewModel.IdUsuario)),
                                );
                              }
                          ),
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
                  mostrarRespostaComentario ? Container() : GestureDetector(
                    child: widget.comentarioViewModel.QuantidadeSubComentario != 0 ?
                    Text('ver ' + widget.comentarioViewModel.QuantidadeSubComentario.toString() + ' resposta') : Container(),
                    onTap: () {
                      listarSubComentarios();
                    },
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
                            setState(() {});
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
                  widget.comentarioViewModel.IdUsuario != idUsuarioLogado ? Container(
                    child: IconButton(
                      onPressed: () async {
                        responderComentario();
                      },
                      icon: Icon(
                        Icons.reply,
                        color: Colors.blue,
                      ),
                      iconSize: 15.0,
                    ),
                  ) : Container(),
                  widget.comentarioViewModel.IdUsuario == idUsuarioLogado ? Container(
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
              mostrarRespostaComentario
                  ? Column(
                    children: [
                      for(ComentarioViewModel item in listaRespostaComentarios) RespostaComentarioNoticiaWidget(comentarioViewModel: item, atualizarComentarios: listarSubComentarios, msgNaoLogado: msgErroUser),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Text('ocultar resposta'),
                          onTap: () {
                            setState(() {
                              mostrarRespostaComentario = false;
                            });
                          },
                        ),
                      ),
                    ],
              )
                  : Container(),
            ],
          )),
    );
  }

  msgErroUser() {
    widget.msgNaoLogado();
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
    var responseDelete = await comentarioService.excluirComentario(widget.comentarioViewModel.IdComentario);
    if(responseDelete){
      widget.atualizarComentarios();
    }
  }

  void responderComentario() {
    if(idUsuarioLogado != 0){
      ComentarioService comentarioService = Provider.of<ComentarioService>(context, listen: false);
      comentarioService.responderComentarioModel = widget.comentarioViewModel;
      widget.responderComentario();
    }else{
      widget.msgNaoLogado();
    }

  }

  void listarSubComentariosAoResponder() async {
    ComentarioService comentarioService = Provider.of<ComentarioService>(context, listen: false);
    var listaSubComentario = await comentarioService.listarSubComentario(widget.comentarioViewModel.IdComentario);
    setState(() {
      listaRespostaComentarios = listaSubComentario;
    });
  }

  void listarSubComentarios() async {
    ComentarioService comentarioService = Provider.of<ComentarioService>(context, listen: false);
    var listaSubComentario = await comentarioService.listarSubComentario(widget.comentarioViewModel.IdComentario);
    setState(() {
      listaRespostaComentarios = listaSubComentario;
      mostrarRespostaComentario = true;
    });
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
