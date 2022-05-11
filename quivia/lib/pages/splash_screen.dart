import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quivia/pages/base_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Base()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: quiviaLogo(),
      )),
    );
  }

  Widget quiviaLogo() {
    return Container(
      child: const Text(
        "Quivia",
        style: TextStyle(
            color: Colors.white, fontSize: 50, fontWeight: FontWeight.w400),
      ),
    );
  }
}
