import 'package:flutter/material.dart';

class Anggota extends StatefulWidget {
  const Anggota({super.key});

  @override
  State<Anggota> createState() => _AnggotaState();
}

class _AnggotaState extends State<Anggota> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anggota"),),
      body: ListView.builder(
              itemCount: 11,
              itemBuilder: (context, index) {
                return Card(
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(radius: 35, backgroundImage: NetworkImage("https://www.its.ac.id/international/wp-content/uploads/sites/66/2020/02/blank-profile-picture-973460_1280-300x300.jpg"),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama Murid ${index+1}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                            Text("Kelas Ipa 1", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}