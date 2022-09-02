import 'package:app_noticia/models/usuario.model.dart';
import 'package:app_noticia/services/usuario.service.dart';
import 'package:app_noticia/views/pages/home/home.page.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilUsuarioController extends GetxController with GetSingleTickerProviderStateMixin {
  final usuarioService = Get.find<UsuarioService>();

  UsuarioModel usuarioLogado;
  List<UsuarioModel> seguidoresList = List.empty();
  List<UsuarioModel> seguindoList = List.empty();
  int totalSeguidores = 0;


  @override
  void onInit() {
    obterUsuario();

    super.onInit();
    mostrarSeguidoresTotal(usuarioLogado != null ? usuarioLogado.Id : 0);

  }


  @override
  void dispose() {
    super.dispose();
  }

  abrirChat() {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => ChatPage()))
    //     .then((value) => {
    //   if (value is UsuarioModel)
    //     {
    //       setState(() {
    //         usuarioLogado = value;
    //       })
    //     }
    // });
  }

  abrirEditarPerfil() {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => EditarPerfilPage()))
    //     .then((value) => {
    //   if (value is UsuarioModel)
    //     {
    //       setState(() {
    //         usuarioLogado = value;
    //       })
    //     }
    // });
  }

  var url = 'http://www.youtube.com';

  Future<void> launchLink(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('nao pode executar o link $url');
    }
  }

  obterUsuario() async {
    var value = await usuarioService.obterUsuarioLogado();
    var user = await usuarioService.buscarUsuarioPorId(value.Id);
    this.usuarioLogado = user;
  }

  void mostrarSeguindo(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 0;
    var value = await usuarioService.mostrarSeguindo(idUsuario, pageIndex, pageSize);
    this.seguindoList = value;
  }

  void mostrarSeguidores(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 0;
    var value = await usuarioService.mostrarSeguidores(idUsuario, pageIndex, pageSize);
    this.seguidoresList = value;
  }

  void mostrarSeguidoresTotal(int idUsuario) async {
    var pageIndex = 0;
    var pageSize = 9999;
    var value = await usuarioService.mostrarSeguidores(idUsuario, pageIndex, pageSize);
    this.totalSeguidores = value.length;
  }


  deslogarUsuario() async {
    await usuarioService.limparSecao();
    Get.offAll(HomeViewPage());
  }

}