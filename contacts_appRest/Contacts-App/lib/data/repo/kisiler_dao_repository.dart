import 'dart:convert';
import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/data/entity/kisiler_cevap.dart';
import 'package:dio/dio.dart';

class KisilerDaoRepository{ // data access object

  List<Kisiler> parseKisilerCevap(String cevap){
    return KisilerCevap.fromJson(json.decode(cevap)).kisiler;
  }
  //dışrıdan veri istemeyen servis gettir. veri isteniyorsa posttur.
  //http://kasimadalan.pe.hu/kisiler/tum_kisiler.php


  Future<void> kaydet(String kisi_ad,String kisi_tel) async{
    var url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php";
    var veri = {"kisi_ad":kisi_ad,"kisi_tel":kisi_tel};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Kişi ekle : ${cevap.data.toString()}");
  }
  Future<void> guncelle (int kisi_id , String kisi_ad , String kisi_tel) async {
    var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    var veri = {"kisi_id":kisi_id,"kisi_ad":kisi_ad,"kisi_tel":kisi_tel};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Kişi güncelle : ${cevap.data.toString()}");


  }

  Future<List<Kisiler>> kisileriYukle() async{
   var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php";
   var cevap = await Dio().get(url);
   return parseKisilerCevap(cevap.data.toString());// dynamic türde tostring ile string olduğunu anlattık.
  }
  Future<void> sil(int kisi_id) async{
    var url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php";
    var veri = {"kisi_id":kisi_id};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Kişi sil : ${cevap.data.toString()}");

  }
  Future<List<Kisiler>> ara(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php";
    var veri = {"kisi_ad":aramaKelimesi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));

    return parseKisilerCevap(cevap.data.toString());
  }


}