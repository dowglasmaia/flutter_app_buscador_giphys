import 'package:flutter/material.dart';

//StatelessWidget - quando não iremos realizar modificações na pagina.
class GifPage extends StatelessWidget {
  final Map _gifData;

  //construtor da pagina
  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _gifData["title"],
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),

      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          _gifData['images']['fixed_height']['url'],
        ),
      ),
    );
  }
}
