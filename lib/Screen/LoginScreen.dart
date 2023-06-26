import 'package:absensi/Screen/Pendataan.dart';
import 'package:absensi/Screen/homeScreen.dart';
import 'package:absensi/handler/loginHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unique_identifier/unique_identifier.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginHandler loginHandler = LoginHandler();
  String? _deviceImei;

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
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.teal,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome \nBack",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Colors.white,
                        filled: true),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        fillColor: Colors.white,
                        filled: true),
                  )),
            ),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      loginHandler.login(context, _emailController.text, _passwordController.text, _deviceImei!);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white)))
          ],
        ),
      )),
    );
  }
}
