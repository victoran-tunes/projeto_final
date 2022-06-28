import 'package:flutter/material.dart';
import 'package:projeto_final/views/views.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _iconIcon(){
    return Positioned(
      top: 50.0,
      left: 180.0,
      child: Icon(
        Icons.add_shopping_cart,
        size: 100.0,
        color: Colors.deepPurpleAccent,
      ),
    );
  }

  _buttonRegister(BuildContext context){
    return Positioned(
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>RegisterProduct()));
        },
        icon: Icon(Icons.add,color: Colors.black),
        label: Text('Cadastro de produto', style: TextStyle(color: Colors.black, fontSize: 20),),
      ),);
  }
  _buttonList(BuildContext context){
    return Positioned(
      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>ListProduct()));
        },
        icon: Icon(Icons.list_alt_sharp,color: Colors.black),
        label: Text('Listar meu produtos',style: TextStyle(color: Colors.black, fontSize: 20)),
      ),);
  }

  _buttonAbout(BuildContext context){
    return Positioned(

      child: TextButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => About()));
        },
        icon: Icon(Icons.info,color: Colors.black,),
        label: Text('Sobre',style: TextStyle(color: Colors.black, fontSize: 20)),
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('Produtos'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
        children: [
          _iconIcon(),
          _buttonRegister(context),
          _buttonList(context),
          _buttonAbout(context),
        ],
      ),
    );
  }
}

