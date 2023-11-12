import 'package:flutter/material.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> kaydet(String kisi_ad,String kisi_tel) async{
    print("Kişi kaydet $kisi_ad - $kisi_tel");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kişi Kayıt"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAdi,decoration: InputDecoration(hintText: "Kişi ad"),),
              TextField(controller: tfKisiTel,decoration: InputDecoration(hintText: "Kişi tel"),),
              ElevatedButton(onPressed: () {
                kaydet(tfKisiAdi.text, tfKisiTel.text);

              }, child: Text("Kaydet")),
            ],
          ),
        ),
      ),
    );
  }
}

