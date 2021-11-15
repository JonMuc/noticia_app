
import 'package:app_noticia/models/comentario.model.dart';
import 'package:app_noticia/models/noticia.model.dart';
import 'package:app_noticia/models/response.model.dart';
import 'package:app_noticia/settings.dart';
import 'package:dio/dio.dart';


class NoticiaRepository {
  Future<List<NoticiaModel>> listarManchete() async {
    var url = "${Settings.apiUrl}/noticiaG1/listar-manchete";
    // final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var appCode = jsonDecode(sharedPreferences.get("appCode"));
    print(url);
    Dio dio = new Dio();
    // dio.options.headers['TIO_AUTH_TK'] = appCode;
    Response response = await dio.get(url);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    return (responseModel.Objeto as List)
        .map((noticia) => NoticiaModel.fromJson(noticia))
        .toList();
  }

  Future salvarComentario(String mensagem, int idNoticia, int idCriadoPor) async {
    print("REPOSITORY");

    var data =  {
      "Mensagem": mensagem.toString(),
      "IdNoticia": idNoticia,
      "IdCriadoPor": idCriadoPor,

    };
    var url = "${Settings.apiUrl}/comentario/salvar-comentario-noticia";
    Dio dio = new Dio();

    print(Settings.apiUrl);
    //print(jsonEncode(comentarioModel));
    Response response = await dio.post(url, data: data);
    print(response.statusCode);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    //print(responseModel.Objeto);
  }

  Future trazerComentario(ComentarioModel comentarioModel) async {
    var url = "${Settings.apiUrl}/comentario/obter-comentario-noticia/149";     //{idNoticia}
    Dio dio = new Dio();
    print(Settings.apiUrl);
    //print(jsonEncode(comentarioModel));
    Response response = await dio.get(url);
    //print(response.statusCode);
    ResponseModel responseModel = ResponseModel.fromJson(response.data);
    //print(responseModel.Objeto);
  }

}
