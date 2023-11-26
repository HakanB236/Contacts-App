import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/sqlite/veritabani_yardimcisi.dart';

class KisilerDaoRepository{ // data access object


  Future<void> kaydet(String kisi_ad,String kisi_tel) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    // Key string value dynamic
    var yeniKisi = Map<String,dynamic>();
    yeniKisi["kisi_ad"] = kisi_ad;
    yeniKisi["kisi_tel"] = kisi_tel;
    await db.insert("kisiler", yeniKisi);
  }

  Future<void> guncelle (int kisi_id , String kisi_ad , String kisi_tel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenenKisi = Map<String,dynamic>();
    guncellenenKisi["kisi_ad"] = kisi_ad;
    guncellenenKisi["kisi_tel"] = kisi_tel;
    await db.update("kisiler", guncellenenKisi,where: "kisi_id = ?",whereArgs: [kisi_id]);
  }

  Future<List<Kisiler>> kisileriYukle() async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> satirlar = await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(satirlar.length, (index) {
      var satir = satirlar[index];
      var kisi_id = satir["kisi_id"];
      var kisi_ad = satir["kisi_ad"];
      var kisi_tel = satir["kisi_tel"];

      return Kisiler(kisi_id: kisi_id, kisi_adi: kisi_ad, kisi_tel: kisi_tel);
    });
  }
  Future<void> sil(int kisi_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("kisiler",where: "kisi_id = ?",whereArgs: [kisi_id]);

  }
  Future<List<Kisiler>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> satirlar = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%'");

    return List.generate(satirlar.length, (index) {
      var satir = satirlar[index];
      var kisi_id = satir["kisi_id"];
      var kisi_ad = satir["kisi_ad"];
      var kisi_tel = satir["kisi_tel"];

      return Kisiler(kisi_id: kisi_id, kisi_adi: kisi_ad, kisi_tel: kisi_tel);
    });}


  }

