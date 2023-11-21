import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/sqlite/veritabani_yardimcisi.dart';

class KisilerDaoRepository{ // data access object


  Future<void> kaydet(String kisi_ad,String kisi_tel) async{
    print("Kişi kaydet $kisi_ad - $kisi_tel");

  }

  Future<void> guncelle (int kisi_id , String kisi_ad , String kisi_tel) async {
    print("Kişi güncelle : $kisi_id - $kisi_tel - $kisi_ad");
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
    print("Kişi sil : $kisi_id");

  }
  Future<List<Kisiler>> ara(String aramaKelimesi) async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_adi: "Ahmet", kisi_tel: "1111");
    var k2 = Kisiler(kisi_id: 2, kisi_adi: "Zeynep", kisi_tel: "2222");
    var k3 = Kisiler(kisi_id: 3, kisi_adi: "Beyza", kisi_tel: "3333");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    Iterable<Kisiler> filtreleme = kisilerListesi.where((kisiNesnesi) {
      return kisiNesnesi.kisi_adi.toLowerCase().contains(aramaKelimesi.toLowerCase());

    });

    return filtreleme.toList();
  }


}