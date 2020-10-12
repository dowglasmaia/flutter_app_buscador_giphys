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
    String urlMelhoresGiphys =  "https://api.giphy.com/v1/gifs/trending?api_key=91BuIxuKXmsHNxaZ636M4W5vMWLK6QjF&limit=20&rating=g";
    String urlGiphysSearch =  "https://api.giphy.com/v1/gifs/search?api_key=91BuIxuKXmsHNxaZ636M4W5vMWLK6QjF&q=$_search&limit=20&offset=$_offSet&rating=g&lang=en";
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
    const String _imgTilte =
        'https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif';
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
          ),

          //Expanded - ocupa toda o restando da coluna.
          // FutureBuilder -  carregandos dados futuros...
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(), //dados da api
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    /*verificando os estados da resposta e definindo o que sera exibido na tela.*/
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: //caso esteja aguardando
                      case ConnectionState.none: //caso não estje fazendo nada
                        return Container(
                          //load animation
                          width: 200.0,
                          height: 200.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return Container();
                        else
                          return _createGifTable(context, snapshot);
                    }
                  })),
        ],
      ),
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio:0.9
        ),
      itemCount: snapshot.data['data'].length, // quantidade total de gigs carregas na resposta.
      itemBuilder: (context, index){
          //GestureDetector() -  permite clikar na imagem e redirecionar o usuario para outra pagina caso se necessario.
          return GestureDetector(
            child: Image.network(
              snapshot.data['data']
                           [index]
                           ['images']
                           ['fixed_height']
                           ['url'], //caminho da imagem
              height: 30.00,
              fit: BoxFit.cover,
            ),
          );
      },

    );

  }
}


