class Produto{
  int idProduto;
  int idGrupo;
  String descricao;
  double preco;

  Produto(this.idGrupo,this.idProduto, this.descricao,this.preco);

  Produto.fromJson(Map<String, dynamic> json){
    this.idProduto=json["idProduto"];
    this.idGrupo=json["idGrupo"];
    this.descricao=json["descricao"];
    this.preco=json["preco"]+0.0;
  }
}