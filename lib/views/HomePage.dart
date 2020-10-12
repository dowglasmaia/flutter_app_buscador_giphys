import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offSet = 0;

  Future<Map> _getGifs() async {
    String urlMelhoresGiphys =
        "https://api.giphy.com/v1/gifs/trending?api_key=91BuIxuKXmsHNxaZ636M4W5vMWLK6QjF&limit=20&rating=g";
    String urlGiphysSearch =
        "https://api.giphy.com/v1/gifs/search?api_key=91BuIxuKXmsHNxaZ636M4W5vMWLK6QjF&q=$_search&limit=20&offset=$_offSet&rating=g&lang=en";
    http.Response response;

    if (_search == null || _search.isEmpty)
      response = await http.get(urlMelhoresGiphys);
    else
      response = await http.get(urlGiphysSearch);
    return json.decode(response.body);
  }

//https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif
  @override
  void initState() {
    super.initState();
    _getGifs().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    const String _imgTilte = 'https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(_imgTilte),
        centerTitle: true,
      ),

      //body
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui!",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
