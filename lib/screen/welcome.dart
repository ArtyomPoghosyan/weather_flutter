import 'dart:async';

import 'package:flutter/material.dart';

import 'base_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          // context, MaterialPageRoute(builder: (builder) => MainScreen()));
          context,
          MaterialPageRoute(builder: (builder) => BaseScreen()));
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Image.asset("images/welcomes.jpg")),
            SizedBox(
              height: 15,
            ),
            Text.rich(TextSpan(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                      text: "Weather ", style: TextStyle(color: Colors.white)),
                  WidgetSpan(
                      child: Icon(
                    Icons.sunny_snowing,
                    color: Colors.yellow,
                  )),
                  TextSpan(
                      text: " Radar", style: TextStyle(color: Colors.white))
                ]))
          ],
        ),
      ),
    );
  }
}
