import 'package:flutter/material.dart';
import 'package:kixicliente/includes/CustomAppBar.dart';
import 'package:kixicliente/listarCredito.dart';

class Pesquisar extends StatefulWidget {
  _pesquisar createState() => _pesquisar();
}

class _pesquisar extends State<Pesquisar> {
  int value = 0;
  String? placeholder;

  var dadoPesquisa = TextEditingController();
  bool checkDadoPesquisa = false;

  void initState() {
    setState(() {
      value = 1;
      placeholder = 'Informe o número do BI';
    });
  }

  Widget CustomRadioButtom(String text, int index, String ph) {
    return InkWell(
      onTap: () {
        setState(() {
          value = index;
          placeholder = ph;
        });
      },
      child: new Container(
        width: 70.0,
        height: 50.0,
        decoration: new BoxDecoration(
          color: (value == index)
              ? Colors.green
              : Color.fromARGB(255, 123, 125, 122),
          border: new Border.all(color: Colors.white, width: 5.0),
          borderRadius: new BorderRadius.circular(15.0),
        ),
        child: new Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pesquisar Cliente',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 65,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomRadioButtom("BI", 1, "Informe o número do BI"),
                SizedBox(
                  width: 5,
                ),
                CustomRadioButtom("Nome", 2, "Informe o nome"),
                SizedBox(
                  width: 5,
                ),
                CustomRadioButtom(
                    "Telefone", 3, "Informe o contacto telefónico"),
                SizedBox(
                  width: 5,
                ),
                CustomRadioButtom("Loan Nr", 4, "Informe o Loan Number"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: dadoPesquisa,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                labelText: placeholder,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.fromLTRB(50, 15, 20, 15),
                errorText: this.checkDadoPesquisa
                    ? 'Preencha o campo para efectivar a pesquisa'
                    : null,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            new InkWell(
              onTap: () {
                setState(() {
                  dadoPesquisa.text.isEmpty
                      ? checkDadoPesquisa = true
                      : checkDadoPesquisa = false;
                });
                if (!checkDadoPesquisa) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListarCreditos(
                                dado: dadoPesquisa.text,
                                tipo: value,
                              )));
                }
              },
              child: new Container(
                //width: 100.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  border: new Border.all(color: Colors.white, width: 2.0),
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                child: new Center(
                  child: const Text(
                    'PESQUISAR',
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
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
