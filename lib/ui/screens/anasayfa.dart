import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/ui/cubit/anasayfa_cubit.dart';
import 'package:contacts_app/ui/screens/detay_sayfa.dart';
import 'package:contacts_app/ui/screens/kayit_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}


class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;


  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().kisileriYukle(); // başlangıçta boş bir liste döndürmemesi adına initte çağırılır.
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
            context.read<AnaSayfaCubit>().kisileriYukle();
          }, icon: const Icon(Icons.clear) ) :
          IconButton(onPressed: () {
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: const Icon(Icons.search)),
        ],
        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu) {
            context.read<AnaSayfaCubit>().ara(aramaSonucu);
          },
        ) :
        const Text("Kişiler"),
      ),
      body: BlocBuilder<AnaSayfaCubit,List<Kisiler>>(
        builder: (context, kisilerListesi) {
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context, index) {
                var kisi = kisilerListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisi)))
                        .then((value){
                      context.read<AnaSayfaCubit>().kisileriYukle();
                    });
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
                                  context.read<AnaSayfaCubit>().sil(kisi.kisi_id);
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
            context.read<AnaSayfaCubit>().kisileriYukle();
          });
      },),
    );
  }
}
