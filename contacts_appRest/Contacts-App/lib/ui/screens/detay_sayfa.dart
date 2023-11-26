import 'package:contacts_app/data/entity/kisiler.dart';
import 'package:contacts_app/ui/cubit/detay_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {
  Kisiler kisi;

  DetaySayfa({super.key, required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();
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

              TextField(controller: tfKisiAdi,decoration: const InputDecoration(hintText: "Kişi ad"),),
              TextField(controller: tfKisiTel,decoration: const InputDecoration(hintText: "Kişi tel"),),
              ElevatedButton(onPressed: () {
                context.read<DetaySayfaCubit>().guncelle(int.parse(widget.kisi.kisi_id), tfKisiAdi.text, tfKisiTel.text);

              }, child: const Text("Güncelle")),
            ],
          ),
        ),
      ),
    );
  }
}
