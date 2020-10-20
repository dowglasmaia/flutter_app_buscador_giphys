import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_buscador_giphys/views/Git_page.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offSet = 0;

  Future<Map> _getGifs() async {
    String urlMelhoresGiphys =  "https://api.giphy.com/v1/gifs/trending?api_key=91BuIxuKXmsHNxaZ636M4W5vMWLK6QjF&limit=20&rating=g";
    String urlGiphysSearch =  "https://api.giphy.com/v1/gifs/search?api_key=91BuIxuKXmsHNxaZ636M4W5vMWLK6QjF&q=$_search&limit=19&offset=$_offSet&rating=g&lang=en";
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

              //realizando busca com paramentros na pesquisa
              onSubmitted: (texto){
               setState(() {
                 _search = texto;
                 _offSet = 0;
               });
              },
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

  int _getCount(List data){
    if(_search == null) {
      return data.length;
    }else{
        return data.length + 1;
    }
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
      itemCount: _getCount( snapshot.data['data']), // quantidade total de gigs carregas na resposta.
      // ignore: missing_return
      itemBuilder: (context, index){
          //GestureDetector() -  permite clikar na imagem e redirecionar o usuario para outra pagina caso se necessario.
        if(_search == null || index < snapshot.data['data'].length){
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
           onTap: (){
              //navegando para outro pagina com o gif clikado
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index]) ));
           },
            //compartilhar segurando butão
            onLongPress: (){
              Share.share(snapshot.data['data']
              [index]
              ['images']
              ['fixed_height']
              ['url'], );
            },
          );
        }
        else{
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // alinhamento na linha principal
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70.0,),
                  Text("Carregar mais...",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                )
                ],
              ),

              //onTap  - click
              onTap: (){
                setState(() {
                  _offSet += 19;  //carrega mas 19 ghiphs
                });
              },
            ),
          );
        }
      },

    );

  }
}


