class ComentarioModel{
  String Comentario;
  int idNoticia;
  int IdCriadoPor;

  ComentarioModel(this.Comentario, this.idNoticia, this.IdCriadoPor);

  ComentarioModel.fromJson(Map<String, dynamic> json) {
    Comentario = json['Comentario'];
    idNoticia = json['idNoticia'];
    IdCriadoPor = json['IdCriadoPor'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Comentario'] = this.Comentario;
    data['idNoticia'] = this.idNoticia;
    data['IdCriadoPor'] = this.IdCriadoPor;
    return data;
  }
}