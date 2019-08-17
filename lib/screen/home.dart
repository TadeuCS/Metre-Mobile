import 'package:flutter/material.dart';
import 'package:metre_mobile/entity/Mesa.dart';
import 'package:metre_mobile/model/MesaModel.dart';
import 'package:metre_mobile/screen/mesa.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    MesaModel mesaModel = MesaModel();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Metre Mobile"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              child: DrawerHeader(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text("Mesas"),
              selected: true,
              onTap: () {},
            ),
            ListTile(title: Text("Produtos"), onTap: () {}),
            ListTile(
                title: Text("Sair"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "login");
                }),
          ],
        ),
      ),
      body: FutureBuilder(future: mesaModel.listar(), builder: _gridMesas),
    );
  }

  Widget _gridMesas(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      print(snapshot.error);
      return Text("Erro ao listar");
    }
    if (snapshot.hasData) {
      switch (snapshot.connectionState) {
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );
        case ConnectionState.none:
          return Text("Erro ao conectar no servidor");
        case ConnectionState.done:
          List<Mesa> mesas = snapshot.data;
          mesas = mesas
              .where((m) => m.situacao == 'Aberta' || m.situacao == 'Recebendo')
              .toList();
          mesas.sort((m1, m2) =>
              int.parse(m1.numeroMesa).compareTo(int.parse(m2.numeroMesa)));
          return GridView.builder(
            padding: const EdgeInsets.all(2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  _validaStatusMesa(mesas[index], context);
                },
                child: Container(
                    padding: const EdgeInsets.all(6),
                    color: _getColorBySituacao(mesas[index].situacao),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          mesas[index].numeroMesa,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        Text(
                          "R\$ ${mesas[index].valorTotal.toStringAsFixed(2)}",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    )),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.75,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: mesas.length,
          );
      }
    } else {
      return Container();
    }
  }

  _validaStatusMesa(Mesa mesa, BuildContext context) {
    if (mesa.situacao == 'Recebendo') {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        content: Text("Conta em Recebimento!\nVá até o caixa para reabrir a conta!"),
      ));
    } else {
      _carregaMesa(mesa);
    }
  }

  _getColorBySituacao(String situacao) {
    switch (situacao) {
      case "Aberta":
        return Colors.green[400];
      case "Recebendo":
        return Colors.red[400];
      default:
        return Colors.blue[400];
    }
  }

  _carregaMesa(Mesa mesa) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MesaPage(mesa)));
  }
}
