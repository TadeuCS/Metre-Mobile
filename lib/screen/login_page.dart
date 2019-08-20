import 'package:flutter/material.dart';
import 'package:metre_mobile/entity/Usuario.dart';
import 'package:metre_mobile/model/UsuarioModel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final usuarioModel = UsuarioModel();
  @override
  void initState() {
    if (usuarioModel.usuarioLogado == null) {
      usuarioModel.usuarioLogado = Usuario();
      usuarioModel.usuarioLogado.usuario = "administrador";
      usuarioModel.usuarioLogado.senha = "olivetadmin";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              Image.asset("images/bg.png",
                  fit: BoxFit.fill, width: size.width, height: size.height),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.7,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "images/logo.png",
                              width: 85,
                              height: 85,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Metre Mobile",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white)),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.copyright,
                                color: Colors.white,
                                size: 9,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 130, bottom: 10),
                        child: TextFormField(
                          initialValue: usuarioModel.usuarioLogado.usuario,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Usuário",
                            hintText: "Digite seu usuário",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          onFieldSubmitted: (text) {
                            usuarioModel.usuarioLogado.usuario = text;
                          },
                          validator: (text) {
                            return text.trim().isEmpty
                                ? "Informe o Usuário"
                                : null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 50),
                        child: TextFormField(
                          initialValue: usuarioModel.usuarioLogado.senha,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          onFieldSubmitted: (text) {
                            usuarioModel.usuarioLogado.senha = text;
                          },
                          decoration: InputDecoration(
                            labelText: "Senha",
                            hintText: "Digite sua senha",
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (text) {
                            return text.trim().isEmpty
                                ? "Informe a Senha"
                                : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: RaisedButton(
                          textColor: Colors.white,
                          child: Text("Entrar"),
                          onPressed: () => _validaLogin(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _validaLogin(BuildContext context) {
    bool validado = _formKey.currentState.validate();
    print(validado);
    if (validado) {
      usuarioModel.login().then((onValue) {
        if (onValue) {
          Navigator.pushReplacementNamed(context, "home");
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.redAccent,
            content: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.info_outline),
                ),
                Expanded(
                    child: Text(
                        "Não foi possivel logar!\nUsuário ou senha incorretos!")),
              ],
            ),
          ));
        }
      });
    }
  }
}
