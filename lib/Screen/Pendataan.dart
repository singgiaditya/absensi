
import 'package:absensi/handler/registerHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:unique_identifier/unique_identifier.dart';


class Pendataan extends StatefulWidget {
  const Pendataan({super.key});

  @override
  State<Pendataan> createState() => _PendataanState();
}

class _PendataanState extends State<Pendataan> {
  String? _deviceImei;
  final db = FirebaseFirestore.instance;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nisnipnigController = TextEditingController();
  final TextEditingController _noHpOrangtuaController = TextEditingController();
  final RegisterHandler registerHandler = RegisterHandler();

    
 @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    String? deviceImei;
    try {
      deviceImei = await UniqueIdentifier.serial;
    } catch (e) {
      print(e);
    }

    setState(() {
      _deviceImei = deviceImei!;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    

Widget imeiTextWidget;
  if (_deviceImei != null) {
    imeiTextWidget = Text("Imei: $_deviceImei");
  } else {
    imeiTextWidget = Text("Loading IMEI...");
  }

    return Scaffold(
      body: SafeArea(child: Container(
        color: Colors.teal,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Isi\nData", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SizedBox(
                width: 300,
                child: 
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                )),
            ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                width: 300,
                child: 
                TextField(
                  controller: _nisnipnigController,
                  decoration: InputDecoration(
                    hintText: "NIS/NIP/NIG",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                width: 300,
                child: 
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _noHpOrangtuaController,
                  decoration: InputDecoration(
                    hintText: "No Hp Orang Tua",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                )),
              ),
              imeiTextWidget,
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: (){
                  registerHandler.register(context, _namaController.text, _nisnipnigController.text, _deviceImei!, _noHpOrangtuaController.text);
                }, 
                child: Text("Kirim", style: TextStyle(color: Colors.blue),), style:ElevatedButton.styleFrom(backgroundColor: Colors.white)))
          ],
        ),
      )),
    );
  }
  
}