class Mesa{
  int idEmpresa;
  int idMesa;
  String numeroMesa;
  String situacao;
  double valorTotal;

  Mesa(this.idEmpresa, this.idMesa, this.numeroMesa, this.situacao,
      this.valorTotal);

  Mesa.fromJson(Map<String, dynamic> json){
    this.idEmpresa= json["idEmpresa"];
    this.idMesa=json["idMesa"];
    this.numeroMesa=json["numeroMesa"];
    this.situacao=json["situacao"];
    this.valorTotal=json["valorTotal"] + 0.00;
  }

}