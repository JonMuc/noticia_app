class UsuarioLoginModel{
  String Email;
  String Senha;


  UsuarioLoginModel(this.Email, this.Senha);

  UsuarioLoginModel.fromJson(Map<String, dynamic> json) {
    Email = json['Email'];
    Senha = json['Senha'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.Email;
    data['Senha'] = this.Senha;
    return data;
  }

}