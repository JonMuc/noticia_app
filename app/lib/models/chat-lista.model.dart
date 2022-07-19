class ChatListaModel{
  int Id;
  String Foto;
  String Nome;

  ChatListaModel(this.Id, this.Foto, this.Nome);

  ChatListaModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Foto = json['Foto'];
    Nome = json['Nome'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['Foto'] = this.Foto;
    data['Nome'] = this.Nome;
    return data;
  }
}