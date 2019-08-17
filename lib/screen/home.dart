import 'package:flutter/material.dart';
import 'package:metre_mobile/entity/Mesa.dart';
import 'package:metre_mobile/model/MesaModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MesaModel mesaModel = MesaModel();
    return Scaffold(
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
            ListTile(title: Text("Mesas"),selected: true, onTap: (){},),
            ListTile(title: Text("Produtos"), onTap: (){}),
            ListTile(title: Text("Sair"), onTap: (){
              Navigator.pushReplacementNamed(context, "login");
            }),
          ],
        ),
      ),
      body: FutureBuilder(
          future: mesaModel.listar(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
              return Text("Erro ao listar");
            }
            if(snapshot.hasData){
              switch(snapshot.connectionState){
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                case ConnectionState.none:
                  return Text("Erro ao conectar no servidor");
                case ConnectionState.done:
                  List<Mesa> mesas = snapshot.data;
                  return ListView.builder(
                      itemBuilder: (context, index){
                        return Text(mesas[index].numeroMesa);
                      }
                  );
              }
            }else{
              return Text("Não possui mesa aberta");
            }
          }
      ),
    );
  }
}
