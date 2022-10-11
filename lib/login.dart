import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kixicliente/home.dart';
import 'package:kixicliente/pesquisarCliente.dart';
import 'package:kixicliente/splash.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  final sessao = GetStorage();
  var username = TextEditingController();
  var password = TextEditingController();
  bool ver_Password = false;
  bool checkUsername = false;
  bool checkPassword = false;
  bool loading = false;

  Future<bool> login(String username, String password) async {
    try {
      var endPoint = 'http://kixiagenda.kixicredito.com/public/api/loginAPI';
      var response = await http.post(
        Uri.parse(endPoint),
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        salvarCache(map['name'], map['departamento'], map['email']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //Salvar os dados do login na sessão
  void salvarCache(String nome, String email, String departamento) {
    sessao.write('nome', nome);
    sessao.write('email', email);
    sessao.write('departamento', departamento);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 120, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset("assets/images/logo.png",
                fit: BoxFit.contain, width: 90, height: 90),
            SizedBox(
              height: 75,
            ),
            TextField(
              controller: username,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                hintText: 'Informe o nome de utilizador',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(36.0),
                ),
                errorText: this.checkUsername
                    ? 'O nome de utilizador é obrigatório'
                    : null,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !this.ver_Password,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                hintText: 'Informe a senha',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.green,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this.ver_Password ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      this.ver_Password = !this.ver_Password;
                    });
                  },
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(36.0),
                ),
                errorText: this.checkPassword ? 'A senha é obrigatória' : null,
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    strokeWidth: 5,
                  )
                : new InkWell(
                    onTap: () async {
                      setState(() {
                        username.text.isEmpty
                            ? checkUsername = true
                            : checkUsername = false;
                        password.text.isEmpty
                            ? checkPassword = true
                            : checkPassword = false;
                      });
                      if (!checkUsername && !checkPassword) {
                        loading = true;
                        bool status = await login(username.text, password.text);
                        if (status) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Erro ao efectuar login.',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      }
                    },
                    child: new Container(
                      //width: 100.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Colors.orange,
                        border: new Border.all(color: Colors.white, width: 2.0),
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      child: new Center(
                        child: const Text(
                          'LOGIN',
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
