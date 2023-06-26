import 'package:flutter/material.dart';

class Izin extends StatefulWidget {
  const Izin({super.key});

  @override
  State<Izin> createState() => _IzinState();
}

class _IzinState extends State<Izin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Izin"),),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Alasan Izin",
              border: OutlineInputBorder()
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Tanggal Izin",
              border: OutlineInputBorder()
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text("Lampirkan Foto"))
        ],
      ),
    );
  }
}