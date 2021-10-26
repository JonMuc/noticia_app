class CriarContaModel{
  String Nome;
  String Email;
  String Senha;
  String ConfirmarSenha;

  CriarContaModel(this.Nome, this.Email, this.Senha, this.ConfirmarSenha);



  CriarContaModel.fromJson(Map<String, dynamic> json) {
    Nome = json['Nome'];
    Email = json['Email'];
    Senha = json['Senha'];
    ConfirmarSenha = json['ConfirmarSenha'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nome'] = this.Nome;
    data['Email'] = this.Email;
    data['Senha'] = this.Senha;
    data['ConfirmarSenha'] = this.ConfirmarSenha;
    return data;
  }

}