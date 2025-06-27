import 'package:flutter/material.dart';
import 'dart:io';
import '../containers/addition-problem/addition.dart';

class AdditionProblem extends StatefulWidget {
  @override
  _AdditionProblemState createState() => _AdditionProblemState();
}

class _AdditionProblemState extends State<AdditionProblem> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProblemPicker()
      ),
    );
  }
}