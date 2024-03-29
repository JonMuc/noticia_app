import 'package:app_noticia/models/view-noticia.model.dart';
import 'package:app_noticia/services/avaliacao.service.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/pages/comentario-noticia.page.dart';
import 'package:app_noticia/views/widgets/abrindo-link-noticia.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemNoticiaWidget extends StatefulWidget {
  ViewNoticiaModel noticiaModel;
  Function() notifyUsuarioNaoLogado;

  ItemNoticiaWidget({Key key, this.noticiaModel, this.notifyUsuarioNaoLogado}) : super(key: key);

  @override
  _ItemNoticiaWidget createState() => _ItemNoticiaWidget();
}

class _ItemNoticiaWidget extends State<ItemNoticiaWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 7.0),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 4,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                  child: Image.asset(
                                    "assets/logo_noticias/g1.png",
                                    width: 35,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.noticiaModel.Fonte,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(widget.noticiaModel.QuantidadeLike.toString()),
                              Icon(Icons.thumb_up_alt_rounded, color: Colors.blue),
                              Text(widget.noticiaModel.QuantidadeDeslike.toString()),
                              Icon(Icons.thumb_down_alt_rounded, color: Colors.blue,)
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          encaminharUrl();
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                                child: Stack(children: <Widget>[
                                  Container(
                                    foregroundDecoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.black
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0, 0, 0.6, 1],
                                      ),
                                    ),
                                    child: Image.network(
                                      widget.noticiaModel.UrlImage,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ])),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Text(
                                    widget.noticiaModel.Titulo.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0.5, 0.5),
                                            blurRadius: 10.0,
                                            color: Colors.black,
                                            // color: Color.fromARGB(50, 0, 0, 255),
                                          ),
                                          Shadow(
                                            blurRadius: 10.0,
                                            color: Colors.black,
                                            offset: Offset(0.5, 0.5),
                                          ),
                                        ]),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // spacing: 20,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: IconButton(
                                  onPressed: () {
                                    avaliar(1);
                                  },
                                  color: Colors.blue,
                                  icon: widget.noticiaModel.UsuarioAvaliacao == 1 ? Icon(Icons.thumb_up_alt_rounded) :
                                  Icon(Icons.thumb_up_alt_outlined)),
                            ),
                            IconButton(
                                onPressed: () {
                                  avaliar(2);
                                },
                                color: Colors.blue,
                                icon: widget.noticiaModel.UsuarioAvaliacao == 2 ? Icon(Icons.thumb_down_alt_rounded) :
                                Icon(Icons.thumb_down_alt_outlined)),
                            IconButton(
                                onPressed: () {},
                                color: Colors.blue,
                                icon: Icon(Icons.push_pin_outlined)),
                            IconButton(
                                onPressed: () {},
                                color: Colors.blue,
                                icon: Icon(Icons.offline_share_outlined)),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new TelaComentarioNoticia(
                                                noticiaModel:
                                                    widget.noticiaModel)),
                                  );
                                },
                                padding: EdgeInsets.all(5),
                                color: Colors.blue,
                                icon: Icon(Icons.comment_outlined))
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  encaminharUrl() async{
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new AbrindoLinkNoticiaWidget(noticiaModel: widget.noticiaModel,)));
    //await launch(widget.noticiaModel.Link, universalLinksOnly: true);
  }

  avaliar(int tipoAvaliar) async {
    UsuarioService service =
        Provider.of<UsuarioService>(context, listen: false);
    var user = await service.obterUsuarioLogado();
    if (user == null) {
      widget.notifyUsuarioNaoLogado();
    } else {
      AvaliacaoService avaliacaoService =
          Provider.of<AvaliacaoService>(context, listen: false);
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
}
