import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:metre_mobile/entity/Mesa.dart';

class MesaModel{

  Future<List<Mesa>> listar() async{
    var response = await http.get("http://metre.ddns.net/services/ticket/mesas/");
    List<Mesa> lista=List();
    if(response.statusCode==200){
      var objeto = json.decode(response.body);
      for (var item in objeto) {
        lista.add(Mesa.fromJson(item));
      }

    }
    return lista;
  }
}