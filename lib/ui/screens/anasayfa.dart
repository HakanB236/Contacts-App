import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/ui/screens/detay_sayfa.dart';
import 'package:contacts_app/ui/screens/kayit_sayfa.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  Future<void> ara(String aramaKelimesi) async {
    print("Kişi ara: $aramaKelimesi");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: () {
            setState(() {
              aramaYapiliyorMu = false;
            });
          }, icon: Icon(Icons.clear) ) :
          IconButton(onPressed: () {
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: Icon(Icons.search) )
        ],
        title: aramaYapiliyorMu ?
        TextField(
          decoration: InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            ara(aramaSonucu);
          },
        ) :
        const Text("Kişiler"),
      ),
      body: ElevatedButton(onPressed: () {
        var kisi = Kisiler(kisi_id: 1, kisi_adi: "Ahmet", kisi_tel: "054168");
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi:kisi)))
        .then((value){
          print("Anasayfaya dönüldü");

        });

      }, child: const Text("Detay"),),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KayitSayfa()))
          .then((value){
            print("Anasayfaya dönüldü");
          });
      },),
    );
  }
}
