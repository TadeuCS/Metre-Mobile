import 'package:flutter/material.dart';
import 'package:metre_mobile/entity/Mesa.dart';

class MesaPage extends StatelessWidget {
  final Mesa mesa;

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
        ),
        body: _content(context),
      ),
    );
  }

  TabBarView _content(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Container(
          child: Text("1"),
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
}
