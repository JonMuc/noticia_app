import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/resposta-comentario-noticia.widget.dart';
import 'package:flutter/material.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class WidgetComentarioNoticia extends StatefulWidget {
  final ComentarioViewModel comentarioViewModel;
  Function() atualizarComentarios;

  WidgetComentarioNoticia({@required this.comentarioViewModel, this.atualizarComentarios});

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
    obterIdUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.comentarioViewModel.ComentarioAvaliado == 1) {
      comentarioCurtido = 1;
    } else if (widget.comentarioViewModel.ComentarioAvaliado == 2) {
      comentarioCurtido = 2;
    }

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
                  GestureDetector(
                    child: Text('ver resposta'),
                    onTap: () {
                      listarComentarios(context);
                      mostrarRespostaComentario =
                          mostrarRespostaComentario ? false : true;
                      setState(() {});
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
                            comentarioCurtido == 1 ? Colors.blue : Colors.grey,
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
                            comentarioCurtido == 2 ? Colors.red : Colors.grey,
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
                  ? Container(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: listaRespostaComentarios.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          color: Colors.transparent,
                          height: 0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          listarComentarios(context);
                          final ComentarioViewModel comentarioViewModel =
                              listaRespostaComentarios[index];
                          return Center(
                              child: WidgetRespostaComentarioNoticia(
                                  comentarioViewModel: comentarioViewModel));
                        },
                      ),
                    )
                  : Container(),
              mostrarCampoRespostaComentario
                  ? Container(
                      child: SizedBox(
                      width: 250,
                      child: TextField(),
                    ))
                  : Container()
            ],
          )),
    );
  }

  obterIdUsuario() async{
    var user = await usuarioService.obterUsuarioLogado();
    setState(() {
      idUsuarioLogado = user.Id;
    });
  }


  void deletarComentario() async {
    var responseDelete = await comentarioService.excluirComentario(widget.comentarioViewModel.IdComentario);
    if(responseDelete){
      widget.atualizarComentarios();
    }
  }

  void responderComentario() {}


  void listarComentarios(BuildContext context) async {
    // print('listar comentarios');
    // var listaRespostaComentarioResponse = await comentarioService.listarComentario();
    // this.listaRespostaComentarios = listaRespostaComentarioResponse;
    // setState(() {
    // });
  }

  void likeComentario(BuildContext context, int idComentario) async {
    var likeComentarioResponse =  await comentarioService.avaliarComentario(idComentario, 1);
    widget.comentarioViewModel.QuantidadeLike++;
  }

  void deslikeComentario(BuildContext context, int idComentario) async {
    var likeComentarioResponse =  await comentarioService.avaliarComentario(idComentario, 2);
    widget.comentarioViewModel.QuantidadeDeslike++;
  }

}
