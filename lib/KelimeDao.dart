import 'package:sozluk_app/Kelimeler.dart';
import 'package:sozluk_app/veritabaniYardimcisi.dart';

class KelimeDao {

  Future<List<Kelimeler>> tumKelimeler() async {

    var db =await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (i) {
      var satir= maps [i];

      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });


  }

  Future<List<Kelimeler>> aramaKelime(String kelime) async {

    var db =await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$kelime%'");

    return List.generate(maps.length, (i) {
      var satir= maps [i];

      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });


  }
}