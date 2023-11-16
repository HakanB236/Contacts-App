import 'package:contacts_app/ui/cubit/kayit_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class KayitSayfa extends StatefulWidget {
  const KayitSayfa({Key? key}) : super(key: key);

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

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
                context.read<KayitSayfaCubit>().kaydet(tfKisiAdi.text, tfKisiTel.text);

              }, child: Text("Kaydet")),
            ],
          ),
        ),
      ),
    );
  }
}

