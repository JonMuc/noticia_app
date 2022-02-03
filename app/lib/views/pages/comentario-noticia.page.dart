import 'package:app_noticia/models/comentario-view.model.dart';
import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/services/avaliacao.service.dart';
import 'package:app_noticia/services/comentario.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/comentario-noticia.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class
TelaComentarioNoticia extends StatefulWidget {
  final ViewNoticiaModel noticiaModel;
  TelaComentarioNoticia({@required this.noticiaModel});

  @override
  _TelaComentarioNoticia createState() => _TelaComentarioNoticia();
}
class _TelaComentarioNoticia extends State<TelaComentarioNoticia> {
  List<ComentarioViewModel> listaDeComentarios = List.empty();
  final comentarioService = new ComentarioService();
  final TextEditingController commentController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    listarComentarios(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, size: 30,),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(widget.noticiaModel.UrlImage, fit: BoxFit.contain,),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(widget.noticiaModel.Fonte, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.noticiaModel.QuantidadeLike.toString()),
                    Container(
                      child: IconButton(
                          onPressed: () {
                            avaliar(1);
                          },
                          color: Colors.black,
                          icon: widget.noticiaModel.UsuarioAvaliacao == 1 ? Icon(Icons.thumb_up_alt_rounded) :
                          Icon(Icons.thumb_up_alt_outlined)),
                    ),
                    Text(widget.noticiaModel.QuantidadeDeslike.toString()),
                    IconButton(
                        onPressed: () {
                          avaliar(2);
                        },
                        color: Colors.black,
                        icon: widget.noticiaModel.UsuarioAvaliacao == 2 ? Icon(Icons.thumb_down_alt_rounded) :
                        Icon(Icons.thumb_down_alt_outlined)),
                  ],
                ),
              )
            ],
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  child: Image.asset(obterOrigemNoticia(2)),
                ),
                Container(
                    padding: EdgeInsets.only(left: 6),
                    width: MediaQuery.of(context).size.width * 0.81,
                    child: Text(widget.noticiaModel.Titulo.toString(), style: TextStyle(fontSize: 15),  overflow: TextOverflow.visible)
                ),
              ],
            ),
          ),
          Column(
            children: [
              for(ComentarioViewModel come in listaDeComentarios) Container(
                child: Center(
                          child: WidgetComentarioNoticia(comentarioViewModel: come)
                      ),
              )
            ],

            // ListView.separated(
            //   shrinkWrap: true,
            //   itemCount: listaDeComentarios.length,
            //   separatorBuilder: (BuildContext context, int index) => Divider(
            //     color: Colors.transparent,
            //     height: 0,
            //   ),
            //   itemBuilder: (BuildContext context, int index) {
            //     final ComentarioViewModel comentarioViewModel = listaDeComentarios[index];
            //     return Center(
            //         child: WidgetComentarioNoticia(comentarioViewModel: comentarioViewModel)
            //     );
            //   },
            // ),
          )
        ],
      ),
    );
    //   Scaffold(
    //   // appBar: new AppBar(
    //   //   iconTheme: IconThemeData(color: Colors.white),
    //   //   backgroundColor: Colors.transparent,
    //   // ),
    //   body: Container(
    //     child: CommentBox(
    //       userImage:
    //       "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
    //       child: ListaComentarios(),
    //       labelText: 'Escreva seu comentario',
    //       withBorder: false,
    //       errorText: 'Digite algo',
    //       sendButtonMethod: () async {
    //         await fazerComentario(context, commentController.text);
    //         commentController.clear();
    //         listarComentarios(context);
    //       },
    //       commentController: commentController,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
    //     ),
    //   ),
    // );
  }

  avaliar(int tipoAvaliar) async {
    UsuarioService service =
    Provider.of<UsuarioService>(context, listen: false);
    var user = await service.obterUsuarioLogado();
    if (user == null) {
      final snackbar = SnackBar(
        content: Text("Faca login"),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    } else {
      AvaliacaoService avaliacaoService = Provider.of<AvaliacaoService>(context, listen: false);
      var result = await avaliacaoService.avaliarNoticia(widget.noticiaModel.IdNoticia, tipoAvaliar);
      tratarQuantidadeAvaliacao(result, tipoAvaliar);
    }
  }

  tratarQuantidadeAvaliacao(bool result, tipoAvaliar){
    if(result){
      setState(() {
        if(widget.noticiaModel.UsuarioAvaliacao != null){
          if(widget.noticiaModel.UsuarioAvaliacao == tipoAvaliar){
            widget.noticiaModel.UsuarioAvaliacao = 0;
            if(tipoAvaliar == 1){
              widget.noticiaModel.QuantidadeLike--;
            }else{
              widget.noticiaModel.QuantidadeDeslike--;
            }
          }else{
            if(tipoAvaliar == 1){
              widget.noticiaModel.QuantidadeLike++;
            }else{
              widget.noticiaModel.QuantidadeDeslike++;
            }
            widget.noticiaModel.UsuarioAvaliacao = tipoAvaliar;
          }
        }else{
          if(tipoAvaliar == 1){
            widget.noticiaModel.QuantidadeLike++;
          }else{
            widget.noticiaModel.QuantidadeDeslike++;
          }
          widget.noticiaModel.UsuarioAvaliacao = tipoAvaliar;
        }
      });
    }
  }

  String obterOrigemNoticia(int origemNoticia) {
    switch (origemNoticia){
      case 1:
        {
          return "assets/logo_noticias/googlenews.png";
        }
        break;
      case 2:
        {
          return "assets/logo_noticias/g1.png";
        }
        break;
      case 3:
        {
        return "assets/logo_noticias/ig.png";
        }
        break;
      default:
        {
          return "assets/logo_noticias/facebook.png";
        }
        break;
    }
  }

  void listarComentarios(BuildContext context) async {
    var listaComentarioResponse = await comentarioService.listarComentario(widget.noticiaModel.IdNoticia);
    setState(() {
      this.listaDeComentarios = listaComentarioResponse;
    });
  }

  Future fazerComentario(BuildContext context, String comentario) async {
    UsuarioService usuarioService = Provider.of<UsuarioService>(context, listen: false);
    UsuarioModel usuarioLogado = await usuarioService.obterUsuarioLogado();
    var usuarioId = 32;
    widget.noticiaModel.IdNoticia = 149;
    var fazerComentarioResponse = await comentarioService.fazerComentario(comentario, widget.noticiaModel.IdNoticia, usuarioId);
  }
}