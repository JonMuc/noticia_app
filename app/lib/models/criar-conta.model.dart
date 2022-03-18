class CriarContaModel{
  String Nome;
  String NomeUsuario;
  String Email;
  String Senha;
  String ConfirmarSenha;
  String UrlFoto;

  CriarContaModel(this.Nome, this.Email, this.Senha, this.ConfirmarSenha, this.UrlFoto, this.NomeUsuario);



  CriarContaModel.fromJson(Map<String, dynamic> json) {
    Nome = json['Nome'];
    Email = json['Email'];
    Senha = json['Senha'];
    ConfirmarSenha = json['ConfirmarSenha'];
    UrlFoto = json['UrlFoto'];
    NomeUsuario = json['NomeUsuario'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nome'] = this.Nome;
    data['Email'] = this.Email;
    data['Senha'] = this.Senha;
    data['ConfirmarSenha'] = this.ConfirmarSenha;
    data['UrlFoto'] = this.UrlFoto;
    data['NomeUsuario'] = this.NomeUsuario;
    return data;
  }

}