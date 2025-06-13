import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../components/header.dart';
import '../containers/addition-problem/addition.dart';

class AdditionProblem extends StatefulWidget {
  @override
  _AdditionProblemState createState() => _AdditionProblemState();
}

class _AdditionProblemState extends State<AdditionProblem> {
  File? _image;

  @override
  void initState() {
    super.initState();
    _startCamera();
  }

  Future<void> _startCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      // 사용자가 사진 안 찍고 뒤로 간 경우 등 처리 가능
      Navigator.of(context).pop(); // 뒤로가기 할 수도 있음
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _image != null
            ? ProblermPicker(image: Image.file(_image!).image)
            : Text('카메라를 실행 중입니다...'),
      ),
    );
  }
}