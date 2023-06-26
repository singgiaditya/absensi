import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History"),),
      body: ListView.builder(itemCount: 10, itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              margin: EdgeInsets.only(left:20, right: 20, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Absen Masuk Tanggal ${index+1}"),
                    Text("06:00:00 WIB")
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left:20, right: 20, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Absen Pulang Tanggal ${index+1}"),
                    Text("06:00:00 WIB")
                  ],
                ),
              ),
            ),
          ],
        );
      },),
    );
  }
}