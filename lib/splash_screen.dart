import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_project/home_screen.dart';

// ignore: camel_case_types
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

// ignore: camel_case_types
class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "We show weather for you",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        
      ),
      
    );
  }
}
