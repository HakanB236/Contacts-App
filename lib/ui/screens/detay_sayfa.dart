import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:flutter/material.dart';

class DetaySayfa extends StatefulWidget {
  Kisiler kisi;

  DetaySayfa({required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();
  Future<void> guncelle (int kisi_id , String kisi_ad , String kisi_tel) async {
    print("Kişi güncelle : $kisi_id - $kisi_tel - $kisi_ad");
  }
  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_adi;
    tfKisiTel.text = kisi.kisi_tel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kişi Detay"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 50.0,left: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAdi,decoration: InputDecoration(hintText: "Kişi ad"),),
              TextField(controller: tfKisiTel,decoration: InputDecoration(hintText: "Kişi tel"),),
              ElevatedButton(onPressed: () {
                guncelle(widget.kisi.kisi_id, tfKisiAdi.text, tfKisiTel.text);

              }, child: Text("Güncelle")),
            ],
          ),
        ),
      ),
    );
  }
}
