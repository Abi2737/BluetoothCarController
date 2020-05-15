import 'package:carcontroller/pages/Home.dart';
import 'package:flutter/material.dart';

import 'pages/ControllerPage.dart';

void main() {
  runApp(CarControllerApp());
}

class CarControllerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cor Controller',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      routes: {
        "/": (context) => HomePage(),
        "/controller": (context) => ControllerPage()
      },
    );
  }
}

