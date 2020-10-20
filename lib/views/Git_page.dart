import 'package:flutter/material.dart';
import 'package:share/share.dart';

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

        /*ação, para compartilhart o giph*/
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(_gifData['images']['fixed_height']['url'],);
              }),
        ],
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
