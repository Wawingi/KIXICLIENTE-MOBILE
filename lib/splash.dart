import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:kixicliente/login.dart';

class Splash extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _splashState createState() => _splashState();
}

class _splashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Image.asset("assets/images/logo.png",
                fit: BoxFit.contain, width: 150, height: 150),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.green),
              strokeWidth: 5,
            )
          ],
        ),
      ),
    );
  }
}
