import 'package:app/models/noticia.model.dart';
import 'package:app/models/response.model.dart';
import 'package:app/settings.dart';
import 'package:dio/dio.dart';


class MancheteRepository {
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

}
