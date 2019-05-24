import 'package:flutter/material.dart';
import 'HomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Random User API",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

void main() => runApp(MyApp());