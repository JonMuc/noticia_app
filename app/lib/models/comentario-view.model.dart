class ComentarioViewModel{
  int Id;
  int IdComentario;
  int QuantidadeSubComentario;
  int IdUsuario;
  String Mensagem;
  String Nome;
  String UrlFoto;
  DateTime DataComentario;
  int ComentarioAvaliado;
  // 1 = CURTIU ,  2 = DESCURTIU , 0 = NAO TEVE ACAO
  int QuantidadeLike;
  int QuantidadeDeslike;


  ComentarioViewModel.t( this.IdComentario, this.IdUsuario, this.Mensagem, this.Nome);

  ComentarioViewModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    IdComentario = json['IdComentario'];
    QuantidadeSubComentario = json['QuantidadeSubComentario'];
    IdUsuario = json['IdUsuario'];
    Mensagem = json['Mensagem'];
    Nome = json['Nome'];
    UrlFoto = json['UrlFoto'];
    DataComentario = DateTime.parse(json['DataComentario']);
    QuantidadeLike = json['QuantidadeLike'];
    QuantidadeDeslike = json['QuantidadeDeslike'];
    ComentarioAvaliado = json['ComentarioAvaliado'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['QuantidadeSubComentario'] = this.QuantidadeSubComentario;
    data['IdComentario'] = this.IdComentario;
    data['IdUsuario'] = this.IdUsuario;
    data['Mensagem'] = this.Mensagem;
    data['Nome'] = this.Nome;
    data['UrlFoto'] = this.UrlFoto;
    data['DataComentario'] = this.DataComentario;
    data['QuantidadeLike'] = this.QuantidadeLike;
    data['QuantidadeDeslike'] = this.QuantidadeDeslike;
    data['ComentarioAvaliado'] = this.ComentarioAvaliado;
    return data;
  }
}