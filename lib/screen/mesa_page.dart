import 'package:flutter/material.dart';
import 'package:metre_mobile/entity/GrupoAtendimento.dart';
import 'package:metre_mobile/entity/Mesa.dart';
import 'package:metre_mobile/model/ProdutoModel.dart';
import 'package:metre_mobile/screen/produto_page.dart';

class MesaPage extends StatelessWidget {
  final Mesa mesa;
  final ProdutoModel produtoModel = ProdutoModel();
  MesaPage(this.mesa);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mesa ${mesa.numeroMesa}"),
          bottom: _tabBar(context),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _goToProdutosPage(context, null);
              },
            ),
          ],
        ),
        body: _content(context),
      ),
    );
  }

  TabBarView _content(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Container(
          child: _gridGrupoAtendimento(),
        ),
        Container(
          child: Text("2"),
        ),
        Container(
          child: Text("3"),
        ),
      ],
    );
  }

  Widget _tabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Theme.of(context).backgroundColor,
      tabs: <Widget>[
        Tab(
          icon: Icon(Icons.add_shopping_cart),
        ),
        Tab(
          icon: Icon(Icons.print),
        ),
        Tab(
          icon: Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  Widget _gridGrupoAtendimento() {
    return FutureBuilder(
      future: produtoModel.listarGrupoAtendimentos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Erro ao carregar os Grupos");
        }
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List<GrupoAtendimento> grupos = snapshot.data;
              return GridView.builder(
                itemCount: grupos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1.6),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _goToProdutosPage(context, grupos[index].idGrupo);
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          grupos[index].imagem.isEmpty
                              ? Icon(Icons.image)
                              : Image.network(
                                  "http://metre.ddns.net/resources/64px/${grupos[index].imagem}.png",
                                  width: 30,
                                ),
                          Text(
                            grupos[index].descricao,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            case ConnectionState.none:
              return Container();
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        } else {
          return Center(
            child: Text("Nenhum Grupo de Atendimento carregado"),
          );
        }
      },
    );
  }

  void _goToProdutosPage(BuildContext context, int idGrupo) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProdutoPage(idGrupo), fullscreenDialog: true));
  }
}
