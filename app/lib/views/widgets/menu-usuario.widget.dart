import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/widgets/fazer-login.widget.dart';
import 'package:app_noticia/views/widgets/menu-usuario-logado.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuUsuario extends StatefulWidget{
  @override
  _MenuUsuarioWidget createState() => _MenuUsuarioWidget();
}

class _MenuUsuarioWidget extends State<MenuUsuario>{
  var usuarioExistente = false;

  @override
  initState() {
    UsuarioService service = Provider.of<UsuarioService>(context, listen: false);
    service.verificarUsuarioLogado().then((value) => {
        setState(() {
          this.usuarioExistente = value;
        })
    });
  }

  @override
  Widget build(BuildContext context){
    print(this.usuarioExistente);
    return this.usuarioExistente ? MenuUsuarioLogadoWidget() : FazerLoginWidget();
  }
}