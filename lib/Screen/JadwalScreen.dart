import 'package:flutter/material.dart';

class Jadwal extends StatefulWidget {
  const Jadwal({super.key});

  @override
  State<Jadwal> createState() => _JadwalState();
}

class _JadwalState extends State<Jadwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jadwal"),),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Senin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        Text("Matematika", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Inggris", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Indonesia", style: TextStyle(fontSize: 20),),
                        Text("Biologi", style: TextStyle(fontSize: 20),),
                        Text("Kimia", style: TextStyle(fontSize: 20),),
                        Text("Fisika", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Selasa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        Text("Matematika", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Inggris", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Indonesia", style: TextStyle(fontSize: 20),),
                        Text("Biologi", style: TextStyle(fontSize: 20),),
                        Text("Kimia", style: TextStyle(fontSize: 20),),
                        Text("Fisika", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rabu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        Text("Matematika", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Inggris", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Indonesia", style: TextStyle(fontSize: 20),),
                        Text("Biologi", style: TextStyle(fontSize: 20),),
                        Text("Kimia", style: TextStyle(fontSize: 20),),
                        Text("Fisika", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kamis", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        Text("Matematika", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Inggris", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Indonesia", style: TextStyle(fontSize: 20),),
                        Text("Biologi", style: TextStyle(fontSize: 20),),
                        Text("Kimia", style: TextStyle(fontSize: 20),),
                        Text("Fisika", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jumat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        Text("Matematika", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Inggris", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Indonesia", style: TextStyle(fontSize: 20),),
                        Text("Biologi", style: TextStyle(fontSize: 20),),
                        Text("Kimia", style: TextStyle(fontSize: 20),),
                        Text("Fisika", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sabtu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        Text("Matematika", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Inggris", style: TextStyle(fontSize: 20),),
                        Text("Bahasa Indonesia", style: TextStyle(fontSize: 20),),
                        Text("Biologi", style: TextStyle(fontSize: 20),),
                        Text("Kimia", style: TextStyle(fontSize: 20),),
                        Text("Fisika", style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}