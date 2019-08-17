import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:metre_mobile/entity/Mesa.dart';

class MesaModel{

  Future<List<Mesa>> listar() async{
    var response = await http.get("http://metre.ddns.net/services/ticket/mesas/");
    if(response.statusCode==200){
      var objeto = json.decode(response.body);
      List<Mesa> lista = objeto.map((mesa)=>Mesa.fromJson(mesa)).toList();
      return lista;
    }
  }
}