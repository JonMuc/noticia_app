import 'package:app/models/noticia.model.dart';
import 'package:app/models/response.model.dart';
import 'package:app/settings.dart';
import 'package:dio/dio.dart';


class UsuarioRepository {
  Future criarUsuario() async {
    var url = "${Settings.apiUrl}/usuario/salvar-usuario";
    print("repositorio");
    var modelo = {

      "Id": 0,
      "CriadoEm": "2021-10-10T17:28:13.703Z",
      "AtualizadoEm": "2021-10-10T17:28:13.703Z",
      "IdAtualizadoPor": 0,
      "IdCriadoPor": 0,
      "StatusRegistro": 0,
      "Nome": "string",
      "Email": "string",
      "Senha": "string",
      "Telefone": "string",
      "Foto": "string",
      "IdGoogle": "string",
      "IdFacebook": "string",
      "PerfilLinkedin": "string",
      "PerfilInstagram": "string",
      "PerfilTwitter": "string",
      "Descricao": "string"
    };

    Dio dio = new Dio();
  //  dio.options.headers['TIO_AUTH_TK'] = appCode;
    Response response = await dio.post(url, data: modelo);
  //   ResponseModel responseModel = ResponseModel.fromJson(response.data);
  //   return (responseModel.Objeto as List)
  //       .map((noticia) => NoticiaModel.fromJson(noticia))
  //       .toList();
  }
}
