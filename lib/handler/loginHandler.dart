import 'package:absensi/models/UserEntity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:absensi/Screen/Pendataan.dart';
import 'package:absensi/Screen/homeScreen.dart';

class LoginHandler {
  final db = FirebaseFirestore.instance;
  late final userEntity;

  void login(BuildContext context,String email, String password, String imei) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      final docRef =
          db.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final dataImei = docSnapshot.get('Imei');
        if (imei == dataImei) {
          userEntity = UserEntity(id: FirebaseAuth.instance.currentUser!.uid, nama: FirebaseAuth.instance.currentUser!.displayName!, role: docSnapshot.get("role"));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => home(user: userEntity,),
              ));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Imei Tidak Sesuai")));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Pendataan()));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code.toString())));
    }
  }
}
