import 'package:flutter/material.dart';
import 'package:metre_mobile/entity/Produto.dart';
import 'package:metre_mobile/model/ProdutoModel.dart';

class ProdutoPage extends StatefulWidget {
  final int _idGrupo;

  ProdutoPage(this._idGrupo);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  ProdutoModel produtoModel = ProdutoModel();
  List<Produto> produtos = List(); // names we get from API
  List<Produto> produtosFiltrados = List();

  @override
  void initState() {
    super.initState();
    produtoModel.listarProdutosByGrupoAtendimento(widget._idGrupo).then((value) {
      produtos.addAll(value);
      _filtraProdutosListados("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          autofocus: true,
          onChanged: (text) {
            _filtraProdutosListados(text);
          },
          decoration: InputDecoration(
              alignLabelWithHint: true,
              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
              hintText: "Digite o código ou a descrição"),
        ),
      ),
      body: _content(),
    );
  }

  _filtraProdutosListados(String text) {
    print("Filtra: $text");
    text = text;
    setState(() {
      if (text.isEmpty) {
        produtosFiltrados = produtos;
      } else {
        produtosFiltrados = produtos
            .where((p) => isNumeric(text)
                ? p.idProduto == int.parse(text)
                : p.descricao
                    .toString()
                    .toLowerCase()
                    .contains(text.toLowerCase()))
            .toList();
      }
    });
  }

  bool isNumeric(String str) {
    try {
      double.parse(str);
      return true;
    } on FormatException {
      return false;      
    }
  }

  Widget _content() {
    return Container(
      child: ListView.builder(
          itemCount: produtosFiltrados.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Row(
                  children: <Widget>[
                    Expanded(child: Text(produtosFiltrados[index].descricao)),
                    Text(
                      produtosFiltrados[index].idProduto.toString(),
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, "itemPedido");
                },
                subtitle:
                    Text(produtosFiltrados[index].preco.toStringAsFixed(2)),
              ),
            );
          }),
    );
  }

  // _listaProdutos(BuildContext context) {
  //   return Container(
  //     child: FutureBuilder(
  //         future: produtoModel.listarProdutosByGrupoAtendimento(null),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasError) {
  //             return Text("Erro ao carregar os produtos");
  //           }
  //           if (snapshot.hasData) {
  //             List<Produto> produtos = snapshot.data;
  //             print(produtos.length);
  //             switch (snapshot.connectionState) {
  //               case ConnectionState.active:
  //               case ConnectionState.waiting:
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               case ConnectionState.none:
  //                 return Center(
  //                   child: Text("Sem Conexão com o servidor"),
  //                 );
  //               default:
  //                 return _content();
  //             }
  //           } else {
  //             print("vazio");
  //             return Container();
  //           }
  //         }),
  //   );
  // }
}
