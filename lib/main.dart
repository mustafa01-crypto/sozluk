import 'package:flutter/material.dart';
import 'package:sozluk_app/Detay.dart';
import 'package:sozluk_app/KelimeDao.dart';
import 'package:sozluk_app/Kelimeler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {


  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  bool aramaVarmi = false;
  String arama = "";

  Future<List<Kelimeler>> tumKelimeler() async {
    var kelimeListesi = await KelimeDao().tumKelimeler();
    return kelimeListesi;
  }

  Future<List<Kelimeler>> aramaYap(String kelime) async {
    var kelimeListesi = await KelimeDao().aramaKelime(kelime);
    return kelimeListesi;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaVarmi ?
            TextField(
              decoration: InputDecoration(
                hintText: "ara",
              ),
              onChanged: (aramaSonucu){
                print("Arama sonucu :$aramaSonucu");
                setState(() {
                  arama = aramaSonucu;
                });
              },
            )
            : Text("Sözlük Uygulaması"),
        actions: [
          aramaVarmi ?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                aramaVarmi = false;
                arama ="";
              });
            },
          )
          :
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                aramaVarmi = true;
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: aramaVarmi ? aramaYap(arama) : tumKelimeler(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kelimeListesi = snapshot.data;

            return ListView.builder(
              itemCount: kelimeListesi.length,
              itemBuilder: (context,index){
                var kelime = kelimeListesi[index];

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Detay(kelime: kelime,)));
                  },
                  child: SizedBox(height: 50,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(kelime.ingilizce,style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(kelime.turkce,)

                        ],
                      ),

                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      )

    );
  }
}
