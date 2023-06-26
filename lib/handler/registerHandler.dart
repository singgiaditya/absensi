import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:absensi/Screen/LoginScreen.dart';

class RegisterHandler {
  final db = FirebaseFirestore.instance;

  Future<void> openwhatsapp(String nama, String nis, String imei, String nohp) async {
    String whatsapp = "+6282228040463";
    String pesanText = "Nama : ${nama}\nNIS/NIP/NIG: ${nis}\nImei : ${imei}\nNo hp orangtua : ${nohp}";

    String whatsappURlAndroid = "https://wa.me/ $whatsapp?text=$pesanText";
    final Uri url = Uri.parse(whatsappURlAndroid);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
}

  void register(BuildContext context,String nama, String nisnipnig, String imei, String noHpOrangtua) async {
    try {
      final data = <String, dynamic>{
        "Nama": nama,
        "NIS/NIP/NIG": nisnipnig,
        "Imei": imei,
        "No_Hp_OrangTua": noHpOrangtua,
        "role": "Siswa"
      };
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.currentUser
            ?.updateDisplayName(nama);
        db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set(data)
            .onError((e, _) => print("Error writing document: $e"));
        openwhatsapp(nama, nisnipnig,
            imei, noHpOrangtua);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login_Screen(),
            ));
      }
    } catch (e) {
      print(e);
    }
  }
}
