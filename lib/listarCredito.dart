import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kixicliente/home.dart';
import 'package:kixicliente/includes/CustomAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:kixicliente/verCredito.dart';

class ListarCreditos extends StatelessWidget {
  final String dado;
  final int tipo;

  const ListarCreditos({Key? key, required this.dado, required this.tipo})
      : super(key: key);

  Future<List<dynamic>> pegaCreditos() async {
    try {
      var endPoint =
          'http://192.168.5.83:8080/kixicliente/public/api/pegaCreditos/';
      endPoint = endPoint + tipo.toString() + '/' + dado;

      var url = Uri.parse(endPoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print('AQUI');
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  //Pegar o cliente e o seu loan number de forma separada AC/P/K1234 : Wawingi Antonio
  String splitCliente(String nome, int tipo) {
    var divisao = nome.split(':');
    if (tipo == 0) {
      return divisao[0];
    }
    if (tipo == 1) {
      return divisao[1];
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: FutureBuilder<List>(
          future: pegaCreditos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/emptyLoan.png",
                      fit: BoxFit.contain,
                      width: 125,
                      height: 125,
                      color: Color.fromARGB(255, 247, 187, 69),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nenhum registo encontrado, verifique o dado informado e tente novamente.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color.fromARGB(255, 123, 125, 122)),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              if (snapshot.data!.length < 1) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/emptyLoan.png",
                        fit: BoxFit.contain,
                        width: 125,
                        height: 125,
                        color: Color.fromARGB(255, 247, 187, 69),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Nenhum registo encontrado, verifique os dados informados e tente novamente.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 123, 125, 122)),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shadowColor: Color.fromARGB(255, 76, 91, 77),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/loan.png",
                                  width: 60,
                                  height: 200,
                                ),
                              ],
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  splitCliente(
                                      snapshot.data![index]['Cliente'], 1),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Loan Number: ',
                                      children: <TextSpan>[
                                        TextSpan(
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                          text: snapshot.data![index]
                                              ['PeCodigo'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Cod. Cliente: ',
                                      children: <TextSpan>[
                                        TextSpan(
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                          text: splitCliente(
                                              snapshot.data![index]['Cliente'],
                                              0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerCredito(
                                            peCodigo: snapshot.data![index]
                                                ['PeCodigo'],
                                          )));
                            }),
                            //trailing: Text(snapshot.data![index]['PeDesemFecha']),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
