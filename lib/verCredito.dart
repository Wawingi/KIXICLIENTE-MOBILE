import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'includes/CustomAppBar.dart';

class VerCredito extends StatelessWidget {
  final String? peCodigo;

  const VerCredito({Key? key, required this.peCodigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Maria Pedro",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loan: HH/P/K1234",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white54)),
                    SizedBox(
                      height: 25,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on_sharp,
                          color: Colors.orange,
                        ),
                        Text("Montante",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 18, color: Colors.orange))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("3.000.000,00",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white54,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: new Color.fromRGBO(15, 91, 59, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: EdgeInsets.all(15),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "PAGAMENTOS",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                        ),
                      ),
                      DataTable(columns: [
                        DataColumn(label: Text("Nº Prestação")),
                        DataColumn(label: Text("Data Vencimento")),
                        DataColumn(label: Text("Valor Prestação")),
                        DataColumn(label: Text("Estado")),
                      ], rows: [
                        DataRow(cells: [
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                          DataCell(Text("AAAA")),
                        ])
                      ])
                    ]),
                margin: EdgeInsets.all(35),
              )
            ],
          ),
        ));
  }
}
