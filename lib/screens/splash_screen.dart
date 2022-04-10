import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void changeScreen() {
    var path = FirebaseAuth.instance.currentUser != null ? '/' : '/login';
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushNamed(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen();

    return const Scaffold(
      body: Center(
        child: Text(
          'Netflux',
          style: TextStyle(
            fontSize: 32,
            color: Colors.blue,
            fontWeight: FontWeight.bold
          )
        ),
      ),
    );
  }
}
