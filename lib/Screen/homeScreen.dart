import 'package:absensi/Screen/AnggotaScreen.dart';
import 'package:absensi/Screen/HistoriScreen.dart';
import 'package:absensi/Screen/IzinScreen.dart';
import 'package:absensi/Screen/JadwalScreen.dart';
import 'package:absensi/handler/absenHandler.dart';
import 'package:absensi/models/UserEntity.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class home extends StatefulWidget {
  final UserEntity user;
  const home({super.key, required this.user});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String currentTime = '';
  String currentDate = '';
  Timer? timer;
  Widget statusAbsenWidget = Text('');
  final absenHandler absen = absenHandler();
  bool isAbsenMasuk = false;
  bool isAbsenPulang = false;
  String jadwalAbsen = "06:00:00 - 09:00:00";

  void updateTime() async {
    final response = await http.get(
        Uri.parse("https://timeapi.io/api/Time/current/zone?timeZone=Asia/Jakarta"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dateTime = DateTime.parse(data["dateTime"]);
      final formatterDate = DateFormat('dd MMMM yyyy');
      final formatterTime = DateFormat('HH:mm:ss');
      currentDate = formatterDate.format(dateTime);
      currentTime = formatterTime.format(dateTime);
      setState(() {
        if(jamAbsenMasuk(dateTime)){
          isAbsenMasuk = true;
          isAbsenPulang = false;
          jadwalAbsen = "06:00:00 - 09:00:00";
        }else if(jamAbsenPulang(dateTime)){
          isAbsenMasuk = false;
          isAbsenPulang = true;
          jadwalAbsen = "14:00:00 - 18:00:00";
        }else{
          isAbsenMasuk = false;
          isAbsenPulang = false;
          jadwalAbsen = "Absen telah ditutup";
        }
      });
    } else {
      print("Failed to fetch time from the API");
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => updateTime());
  }

  bool jamAbsenMasuk(DateTime dateTime) {
    final startTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 6, 0, 0);
    final endTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 9, 0, 0);
    return dateTime.isAfter(startTime) && dateTime.isBefore(endTime);
  }

  bool jamAbsenPulang(DateTime dateTime) {
    final startTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 14, 0, 0);
    final endTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 18, 0, 0);
    return dateTime.isAfter(startTime) && dateTime.isBefore(endTime);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    updateTime();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            color: Colors.cyan[700],
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage("https://www.its.ac.id/international/wp-content/uploads/sites/66/2020/02/blank-profile-picture-973460_1280-300x300.jpg"),
                            radius: 35,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.user.nama,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.user.role,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notifications)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.settings)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  "Hallo ${widget.user.nama}",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Semangat Bekerja ya!",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Padding(padding: EdgeInsets.only(bottom: 60))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            transform: Matrix4.translationValues(0.0, -40.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Izin(),));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.document_scanner_outlined, color: Colors.black), Text("Izin", style: TextStyle(color: Colors.black),)],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => History(),));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.history, color: Colors.black), Text("Histori", style: TextStyle(color: Colors.black),)],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Anggota(),));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.group, color: Colors.black), Text("Anggota", style: TextStyle(color: Colors.black, fontSize: 12), )],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Jadwal(),));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.schedule, color: Colors.black), Text("Jadwal", style: TextStyle(color: Colors.black),)],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text("Lihat Menu Lain nya ->"))),
                  Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$currentTime WIB",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: statusAbsenWidget
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(isAbsenMasuk||isAbsenPulang?"Jadwal Absen ${jadwalAbsen}" : jadwalAbsen,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: isAbsenMasuk ? 
                                  () async{
                                    final statusAbsen = await absen.absenMasuk(widget.user, currentTime, currentDate, 1000);
                                    setState(() {
                                      statusAbsenWidget = statusAbsen;
                                    });
                                  } 
                                  : null,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.back_hand),
                                      Text("Masuk")
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 60,
                              width: 130,
                              child: ElevatedButton(
                                  onPressed: isAbsenPulang ? ()async{
                                    final statusAbsen = await absen.absenKeluar(widget.user, currentTime, currentDate, 1000);
                                    setState(() {
                                      statusAbsenWidget = statusAbsen;
                                    });
                                  } 
                                  : null,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Pulang"),
                                      Icon(Icons.back_hand)
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 5, top: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Riwayat Hari ini",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.exit_to_app),
                                      Text("Absen Masuk")
                                    ],
                                  )),
                              TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text("Absen Pulang"),
                                      Transform.rotate(
                                        angle: 180 * math.pi / 180,
                                        child: Icon(Icons.output),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bulan Ini",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextButton(
                            onPressed: () {}, child: Text("Lihat jadwal ->"))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                                width: 30,
                                height: 10,
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Tepat Waktu", style: TextStyle(fontSize: 11, color: Colors.black87),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                              child: Text("2 Hari",  style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                            ],
                          ),
                      ),
                      Container(
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                                width: 30,
                                height: 10,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Izin", style: TextStyle(fontSize: 11, color: Colors.black87),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                              child: Text("2 Hari",  style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                            ],
                          ),
                      ),
                      Container(
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                                width: 30,
                                height: 10,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Lambat", style: TextStyle(fontSize: 11, color: Colors.black87),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                              child: Text("2 Hari",  style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                            ],
                          ),
                      ),
                      Container(
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5, left: 5),
                                width: 30,
                                height: 10,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("No Exit", style: TextStyle(fontSize: 11, color: Colors.black87),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                              child: Text("2 Hari",  style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                            ],
                          ),
                      ),
                      
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
