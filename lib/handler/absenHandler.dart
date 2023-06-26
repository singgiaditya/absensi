import 'package:absensi/models/UserEntity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trust_location/trust_location.dart';

class absenHandler {
  final db = FirebaseFirestore.instance;
  String? latitude;
  String? longitude;
  bool? isMock;

  void requestPermission() async {
    final permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      TrustLocation.start(10);
      getLocation();
    } else if (permission == PermissionStatus.denied) {
      await Permission.location.request();
    }
  }

  void getLocation() async {
  try {
    await TrustLocation.onChange.listen((result) {
        latitude = result.latitude.toString();
        longitude = result.longitude.toString();
        isMock = result.isMockLocation;
    });
  } catch (e) {
    print("ERROR");
  }
}


  Future<Widget> absenMasuk(UserEntity userEntity, String time, String date, double maxDistance) async {
    try {
      requestPermission();
      getLocation();
      print(isMock);
      if (isMock == true) {
        return Text(
          "Absensi Ditolak",
          style: TextStyle(fontSize: 12, color: Colors.red),
        );
      } else {
        double latTarget = -7.948884481920372;
        double lonTarget = 112.60660027610783;
        double distanceInMeters = await Geolocator.distanceBetween(
          double.parse(latitude!),
          double.parse(longitude!),
          latTarget,
          lonTarget,
        );
        if(distanceInMeters <= maxDistance){
          final docRef = await db.collection("absen").doc(userEntity.id).collection("data_absen").doc("M-${date}").get();
          if(docRef.exists){
            return Text(
        "Anda sudah absen hari  ini",
        style: TextStyle(fontSize: 12, color: Colors.black),
      );
          }
          
          final data = <String, dynamic>{
          "Jenis Absen": "Absen Masuk",
          "Keterangan": "Tepat Waktu",
          "Waktu": time,
      };
      db.collection("absen").doc(userEntity.id).collection("data_absen").doc("M-${date}").set(data);
      return Text(
        "Absensi Berhasil",
        style: TextStyle(fontSize: 12, color: Colors.green),
      );
        }else{
          return Text(
          "Absensi Ditolak",
          style: TextStyle(fontSize: 12, color: Colors.red),
        );
        }
      }
    } catch (e) {
      print(e);
      return Text(
        "Absensi Gagal",
        style: TextStyle(fontSize: 12, color: Colors.red),
      );
    }
  }

  Future<Widget> absenKeluar(UserEntity userEntity, String time, String date, double maxDistance) async {
    try {
      requestPermission();
      getLocation();
      if (isMock == true) {
        return Text(
          "Absensi Ditolak",
          style: TextStyle(fontSize: 12, color: Colors.red),
        );
      } else {
        double latTarget = -7.948884481920372;
        double lonTarget = 112.60660027610783;
        double distanceInMeters = await Geolocator.distanceBetween(
          double.parse(latitude!),
          double.parse(longitude!),
          latTarget,
          lonTarget,
        );
        if(distanceInMeters <= maxDistance){
          final docRef = await db.collection("absen").doc(userEntity.id).collection("data_absen").doc("M-${date}").get();
          if(docRef.exists){
            return Text(
        "Anda sudah absen hari  ini",
        style: TextStyle(fontSize: 12, color: Colors.black),
      );
          }
          
          final data = <String, dynamic>{
          "Jenis Absen": "Absen Keluar",
          "Keterangan": "Tepat Waktu",
          "Waktu": time,
      };
      db.collection("absen").doc(userEntity.id).collection("data_absen").doc("K-${date}").set(data);
      return Text(
        "Absensi Berhasil",
        style: TextStyle(fontSize: 12, color: Colors.green),
      );
        }else{
          return Text(
          "Absensi Ditolak",
          style: TextStyle(fontSize: 12, color: Colors.red),
        );
        }
      }
    } catch (e) {
      print(e);
      return Text(
        "Absensi Gagal",
        style: TextStyle(fontSize: 12, color: Colors.red),
      );
    }
  }
}