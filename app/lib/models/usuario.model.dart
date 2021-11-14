class UsuarioModel{
  String Nome;
  String Email;
  String Senha;
  int Id;
  DateTime CriadoEm;
  DateTime AtualizadoEm;
  int IdAtualizadoPor;
  int IdCriadoPor;
  int StatusRegistro;
  String Telefone;
  String Foto;
  String IdGoogle;
  String IdFacebook;
  String PerfilLikedin;
  String PerfilInstagram;
  String PerfilTwitter;
  String Descricao;


  UsuarioModel(
      this.Nome,
      this.Email,
      this.Senha,
      this.Id,
      this.CriadoEm,
      this.AtualizadoEm,
      this.IdAtualizadoPor,
      this.IdCriadoPor,
      this.StatusRegistro,
      this.Telefone,
      this.Foto,
      this.IdGoogle,
      this.IdFacebook,
      this.PerfilLikedin,
      this.PerfilInstagram,
      this.PerfilTwitter,
      this.Descricao);

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    Nome = json['Nome'];
    Email = json['Email'];
    Senha = json['Senha'];
    Id = json['Id'];
    // CriadoEm = DateTime.parse(json['CriadoEm']);
    // AtualizadoEm = json['AtualizadoEm'] == null ? null : DateTime.parse(json['AtualizadoEm']);
    IdAtualizadoPor = json['IdAtualizadoPor'];
    IdCriadoPor = json['IdCriadoPor'];
    StatusRegistro = json['StatusRegistro'];
    Telefone = json['Telefone'];
    Foto = json['Foto'];
    IdGoogle = json['IdGoogle'];
    IdFacebook = json['IdFacebook'];
    PerfilLikedin = json['PerfilLikedin'];
    PerfilInstagram = json['PerfilInstagram'];
    PerfilTwitter = json['PerfilTwitter'];
    Descricao = json['Descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nome'] = this.Nome;
    data['Email'] = this.Email;
    data['Senha'] = this.Senha;
    data['Id'] = this.Id;
    // data['CriadoEm'] = this.CriadoEm;
    // data['AtualizadoEm'] = this.AtualizadoEm;
    data['IdAtualizadoPor'] = this.IdAtualizadoPor;
    data['IdCriadoPor'] = this.IdCriadoPor;
    data['StatusRegistro'] = this.StatusRegistro;
    data['Telefone'] = this.Telefone;
    data['Foto'] = this.Foto;
    data['IdGoogle'] = this.IdGoogle;
    data['PerfilLikedin'] = this.PerfilLikedin;
    data['PerfilInstagram'] = this.PerfilInstagram;
    data['PerfilTwitter'] = this.PerfilTwitter;
    data['Descricao'] = this.Descricao;
    return data;
  }
}
