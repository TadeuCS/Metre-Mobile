import 'package:flutter/material.dart';
import 'package:metre_mobile/model/UsuarioModel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _usuarioController = TextEditingController();
  var _senhaController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
  _usuarioController.text="administrador";
  _senhaController.text="olivetadmin";
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network("http://metre.ddns.net/MetreGestao/javax.faces.resource/logo.png.xhtml?ln=img", width: 150, height: 150,),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: TextFormField(
                    controller: _usuarioController,
                    decoration: InputDecoration(
                      labelText: "Usuário",
                      hintText: "Digite seu usuário",
                      border: OutlineInputBorder()
                    ),
                    validator: (text){
                        if(text.trim().isEmpty){
                          return "Informe o Usuário";
                        } else{
                          return "";
                        }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: TextFormField(
                    obscureText: true,
                    controller: _senhaController,
                    decoration: InputDecoration(
                        labelText: "Senha",
                        hintText: "Digite sua senha",
                        border: OutlineInputBorder()
                    ),
                    validator: (text){
                      if(text.trim().isEmpty){
                        return "Informe a Senha";
                      } else{
                        return "";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: RaisedButton(
                    textColor: Colors.white,
                    child: Text("Entrar"),
                    onPressed: ()=>_LoginPage(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _LoginPage() {
    print(_usuarioController.text);
    print(_senhaController.text);
//    if(_formKey.currentState.validate()){
      UsuarioModel usuarioModel=UsuarioModel();
       usuarioModel.login(_usuarioController.text, _senhaController.text)
      .then((onValue){
         Navigator.pushReplacementNamed(context, "home");
       });


//    }
  }
}
