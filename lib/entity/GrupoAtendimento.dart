class GrupoAtendimento{
  int idGrupo;
  String imagem;
  String descricao;

  GrupoAtendimento(this.idGrupo,this.descricao,this.imagem);

  GrupoAtendimento.fromJson(Map<String, dynamic> json){
    this.idGrupo=json["idGrupo"];
    this.imagem=json["imagem"];
    this.descricao=json["descricao"];
  }
}