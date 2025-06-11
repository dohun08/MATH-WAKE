import 'package:flutter/material.dart';
import 'package:math_wake/components/header.dart';
import 'package:math_wake/size.dart';
import '../components/toggle-button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Solve(),
    );
  }
}
class Solve extends StatefulWidget{
  const Solve({super.key});

  @override
  State<Solve> createState() => _Solve();
}

class _Solve extends State<Solve>{
  int counter = 0;

  void _increaseCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header()
    );
  }
}