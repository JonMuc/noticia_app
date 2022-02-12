class UsuarioModel {
  String Nome;
  String NomeUsuario;
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
  String PerfilLinkedin;
  String PerfilInstagram;
  String PerfilTwitter;
  String PerfilFacebook;
  String Descricao;
  String Token;

  UsuarioModel.d();

  UsuarioModel(
      this.Nome,
      this.NomeUsuario,
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
      this.PerfilLinkedin,
      this.PerfilInstagram,
      this.PerfilTwitter,
      this.PerfilFacebook,
      this.Descricao,
      this.Token);

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    Nome = json['Nome'];
    NomeUsuario = json['NomeUsuario'];
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
    PerfilLinkedin = json['PerfilLinkedin'];
    PerfilInstagram = json['PerfilInstagram'];
    PerfilTwitter = json['PerfilTwitter'];
    PerfilFacebook = json['PerfilFacebook'];
    Descricao = json['Descricao'];
    Token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nome'] = this.Nome;
    data['NomeUsuario'] = this.NomeUsuario;
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
    data['PerfilLinkedin'] = this.PerfilLinkedin;
    data['PerfilInstagram'] = this.PerfilInstagram;
    data['PerfilTwitter'] = this.PerfilTwitter;
    data['PerfilFacebook'] = this.PerfilFacebook;
    data['Descricao'] = this.Descricao;
    data['Token'] = this.Token;
    return data;
  }
}
