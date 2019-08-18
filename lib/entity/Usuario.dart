
class Usuario{
  int idUsuario;
  int idEmpresa;
  String nome;
  String usuario;
  String senha;
  String perfil;
  String foto;

  Usuario();

  Usuario.fromJson(Map<String, dynamic> json){
    this.idUsuario=json["idUsuario"];
    this.idEmpresa=json["idEmpresa"];
    this.usuario=json["usuario"];
    this.nome=json["nome"];
    this.senha=json["senha"];
    this.perfil=json["perfil"];
    this.foto=json["foto"];
  }
}