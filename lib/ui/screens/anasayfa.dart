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
  Future<List<Kisiler>> kisileriYukle() async{
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_adi: "Ahmet", kisi_tel: "1111");
    var k2 = Kisiler(kisi_id: 2, kisi_adi: "Zeynep", kisi_tel: "2222");
    var k3 = Kisiler(kisi_id: 3, kisi_adi: "Beyza", kisi_tel: "3333");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);

    return kisilerListesi;
  }
  Future<void> ara(String aramaKelimesi) async {
    print("Kişi ara: $aramaKelimesi");
  }
  Future<void> sil(int kisi_id) async{
    print("Kişi sil : $kisi_id");

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
          }, icon: const Icon(Icons.clear) ) :
          IconButton(onPressed: () {
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: const Icon(Icons.search) )
        ],
        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            ara(aramaSonucu);
          },
        ) :
        const Text("Kişiler"),
      ),
      body: FutureBuilder<List<Kisiler>>(
        future: kisileriYukle(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length,
              itemBuilder: (context, index) {
                var kisi = kisilerListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisi)));

                  },
                  child: Card(
                    child:SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kisi.kisi_adi,style: const TextStyle(fontSize: 20),),
                                Text(kisi.kisi_tel)
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${kisi.kisi_adi} silinsin mi?"),
                                action: SnackBarAction(label: "Evet", onPressed: () {
                                  sil(kisi.kisi_id);
                                },) ,
                              ),
                            );

                          }, icon: const Icon(Icons.clear,color: Colors.black54,)),
                        ],
                      ),
                    ),

                    /* ListTile(
                      subtitle: Text(kisi.kisi_tel),
                      title: Text(kisi.kisi_adi),
                      trailing: Icon(Icons.close),

                    ),*/
                  ),
                );
              },
            );
          }else{
            return const Center();

          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitSayfa()))
          .then((value){
            print("Anasayfaya dönüldü");
          });
      },),
    );
  }
}
