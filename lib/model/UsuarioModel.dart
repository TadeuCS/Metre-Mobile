import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioModel{

  String auth_token="";

  Future<bool> login(String usuario, String senha) async{
    print('$usuario - $senha');
    var response = await http.get("http://metre.ddns.net/services/analize/usuario/login/?user=${usuario}&pass=${senha}");
    if(response.statusCode==200){
      auth_token=json.decode(response.body)["auth_token"];
      return true;
    }else{
      print('erro na api');
      return false;
    }
  }
}