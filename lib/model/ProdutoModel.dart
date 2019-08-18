import 'dart:convert';

import 'package:metre_mobile/entity/GrupoAtendimento.dart';
import 'package:http/http.dart' as http;
import 'package:metre_mobile/entity/Produto.dart';

class ProdutoModel {
  String _url = "http://metre.ddns.net/services/ticket/";

  Future<List<GrupoAtendimento>> listarGrupoAtendimentos() async {
    var response = await http.get("${_url}grupos/");
    List<GrupoAtendimento> grupos = List();
    if (response.statusCode == 200) {
      for (var item in jsonDecode(response.body)) {
        grupos.add(GrupoAtendimento.fromJson(item));
      }
    }
    return grupos;
  }

  Future<List<Produto>> listarProdutosByGrupoAtendimento(int idGrupo) async {
    var response = await http
        .get("${_url}produtos/${idGrupo == null ? "" : idGrupo.toString()}");
    List<Produto> produtos = List();
    if (response.statusCode == 200) {
      for (var item in jsonDecode(response.body)) {
        produtos.add(Produto.fromJson(item));
      }
    }
    return produtos;
  }
}
