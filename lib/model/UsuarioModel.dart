import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:metre_mobile/entity/Usuario.dart';

class UsuarioModel{

  Usuario usuarioLogado;

  Future<bool> login() async{
    String usuario = usuarioLogado.usuario;
    String senha = usuarioLogado.senha;
    var response = await http.post("http://metre.ddns.net/services/ticket/login/${usuario}/${senha}");
    if(response.statusCode==200){
      usuarioLogado=Usuario.fromJson(json.decode(response.body));
      return true;
    }
    return false;
  }
}