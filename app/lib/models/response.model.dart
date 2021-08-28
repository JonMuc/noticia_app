class ResponseModel {
  bool? Sucesso;
  dynamic Objeto;

  ResponseModel({this.Sucesso, this.Objeto});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    Sucesso = json['Sucesso'];
    Objeto = json['Objeto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sucesso'] = this.Sucesso;
    data['Objeto'] = this.Objeto;
    return data;
  }
}