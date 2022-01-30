class ViewNoticiaModel {
  int IdNoticia;
  String Titulo;
  String UrlImage;
  String Fonte;
  String Link;
  DateTime CriadoEm;
  int OrigemNoticia; //1=google new, 2=g1, 3=ig
  int TipoNoticia;
  int QuantidadeLike;
  int QuantidadeDeslike;
  int UsuarioAvaliacao;
  int IdAvaliacao;
  bool NoticiaFavorito;
  int IdFavorito;

  ViewNoticiaModel({this.IdNoticia , this.Titulo, this.UrlImage, this.Fonte, this.Link, this.CriadoEm, this.OrigemNoticia, this.IdAvaliacao,
  this.IdFavorito, this.NoticiaFavorito, this.QuantidadeDeslike, this.QuantidadeLike, this.TipoNoticia, this.UsuarioAvaliacao});

  ViewNoticiaModel.fromJson(Map<String, dynamic> json) {
    IdNoticia = json['IdNoticia'];
    Titulo = json['Titulo'];
    UrlImage = json['UrlImage'];
    Fonte = json['Fonte'];
    Link =  json['Link'];
    CriadoEm = json['CriadoEm'] == null ? null : DateTime.parse(json['CriadoEm']);
    OrigemNoticia =  json['OrigemNoticia'];
    TipoNoticia =  json['TipoNoticia'];
    QuantidadeLike =  json['QuantidadeLike'];
    QuantidadeDeslike =  json['QuantidadeDeslike'];
    UsuarioAvaliacao =  json['UsuarioAvaliacao'];
    IdAvaliacao =  json['IdAvaliacao'];
    NoticiaFavorito =  json['NoticiaFavorito'];
    IdFavorito =  json['IdFavorito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdNoticia'] = this.IdNoticia;
    data['Titulo'] = this.Titulo;
    data['UrlImage'] = this.UrlImage;
    data['Fonte'] = this.Fonte;
    data['Link'] = this.Link;
    data['OrigemNoticia'] = this.OrigemNoticia;
    data['TipoNoticia'] = this.TipoNoticia;
    data['QuantidadeLike'] = this.QuantidadeLike;
    data['QuantidadeDeslike'] = this.QuantidadeDeslike;
    data['IdAvaliacao'] = this.IdAvaliacao;
    data['NoticiaFavorito'] = this.NoticiaFavorito;
    data['IdFavorito'] = this.IdFavorito;
    return data;
  }
}