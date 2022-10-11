import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kixicliente/includes/CustomAppBar.dart';
import 'package:kixicliente/login.dart';
import 'package:kixicliente/pesquisarCliente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _home createState() => _home();
}

class _home extends State<Home> {
  final sessao = GetStorage();
  String? nome, email, departamento;

  void initState() {
    super.initState();
    nome = sessao.read('nome');
    email = sessao.read('email');
    departamento = sessao.read('departamento');
  }

  @override
  Widget build(BuildContext context) {
    final drawerItems = ListView(
      children: <Widget>[
        Container(
          height: 200,
          child: DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/user.png",
                  fit: BoxFit.contain,
                  width: 80,
                  height: 80,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  nome.toString(),
                  style: TextStyle(color: Colors.orange, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  email.toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(134, 196, 99, 1), fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  departamento.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: new Color.fromRGBO(15, 91, 59, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: EdgeInsets.all(5),
          ),
        ),
        ListTile(
          title: Text('Inicio'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        Divider(color: Colors.black38),
        ListTile(
          title: Text('Pesquisar Cliente'),
          leading: Icon(Icons.search),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Pesquisar()));
          },
        ),
        Divider(color: Colors.black38),
        ListTile(
          title: Text('CIRC Interno'),
          leading: Icon(Icons.credit_card_off),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        Divider(color: Colors.black38),
        ListTile(
          title: Text('Histórico'),
          leading: Icon(Icons.history),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        Divider(color: Colors.black38),
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.logout),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (BuildContext contex) => AlertDialog(
                      title: Text(
                        "Deseja sair da conta?",
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancelar'),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            sessao.erase();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text('OK'),
                          style: TextButton.styleFrom(
                              primary: Colors.amber,
                              elevation: 2,
                              backgroundColor: Colors.black),
                        ),
                      ],
                    ));
          },
        ),
      ],
    );
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
