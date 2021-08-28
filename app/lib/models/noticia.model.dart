class NoticiaModel {
  int? Id;
  String? Titulo;
  String? UrlImage;
  String? Fonte;
  String? Link;
  String? HoraAtras;

  NoticiaModel({this.Id , this.Titulo, this.UrlImage, this.Fonte, this.Link, this.HoraAtras});

  NoticiaModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Titulo = json['Titulo'];
    UrlImage = json['UrlImage'];
    Fonte = json['Fonte'];
    Link =  json['Link'];
    HoraAtras =  json['HoraAtras'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['Titulo'] = this.Titulo;
    data['UrlImage'] = this.UrlImage;
    data['Fonte'] = this.Fonte;
    data['Link'] = this.Link;
    data['HoraAtras'] = this.HoraAtras;
    return data;
  }
}