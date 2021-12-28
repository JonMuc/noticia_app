class NoticiaModel {
  int Id;
  String Titulo;
  String UrlImage;
  String Fonte;
  String Link;
  String HoraAtras;
  int OrigemNoticia; //1=google new, 2=g1, 3=ig

  NoticiaModel({this.Id , this.Titulo, this.UrlImage, this.Fonte, this.Link, this.HoraAtras, this.OrigemNoticia});

  NoticiaModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Titulo = json['Titulo'];
    UrlImage = json['UrlImage'];
    Fonte = json['Fonte'];
    Link =  json['Link'];
    HoraAtras =  json['HoraAtras'];
    OrigemNoticia =  json['OrigemNoticia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['Titulo'] = this.Titulo;
    data['UrlImage'] = this.UrlImage;
    data['Fonte'] = this.Fonte;
    data['Link'] = this.Link;
    data['HoraAtras'] = this.HoraAtras;
    data['OrigemNoticia'] = this.OrigemNoticia;
    return data;
  }
}