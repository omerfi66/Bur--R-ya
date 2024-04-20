import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemini_gdsc/view/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
          ),
          Center(
            child: Image.asset(
              'assets/foto.png',
              height: 500,
              width: 500,
              fit: BoxFit.contain,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(100.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}
