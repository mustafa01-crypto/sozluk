import 'package:flutter/material.dart';
import 'package:sozluk_app/Kelimeler.dart';

class Detay extends StatefulWidget {

  Kelimeler kelime;


  Detay({this.kelime});

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sözlük Uygulaması"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text(widget.kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink,fontSize: 40),),
            Text(widget.kelime.turkce,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),

          ],
        ),
      ),

    );
  }
}
