import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  _victorAbout() {
      return Column(
        children: [
          Center(
            child:
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.transparent,
              child:ClipOval(
                child:Image.asset('images/victor.jpg',),),),),
          Text('Victor Antunes', style: TextStyle(fontSize: 20)),
          Text('bpxlvictor@gmail.com', style: TextStyle(fontSize: 20)),
          Text('github.com/victoran-tunes', style: TextStyle(fontSize: 20)),
        ],
      );
  }

  _julianoAbout() {
    return Column(
      children: [
        Center(
          child:
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.transparent,
            child:ClipOval(
              child:Image.asset('images/jujucolega.jpg',),),),),

        Text('Juliano Godinho', style: TextStyle(fontSize: 20)),
        Text('julianogodinho99@gmail.com', style: TextStyle(fontSize: 20)),
        Text('github.com/JulianoGodinho', style: TextStyle(fontSize: 20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 50.0,
        centerTitle: true,
        title: Text('Sobre'),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Desenvolvedores',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _victorAbout(),
          _julianoAbout()
        ],
      ),
    );
  }

}