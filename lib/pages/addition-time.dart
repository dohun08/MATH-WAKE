import 'package:flutter/material.dart';
import 'package:math_wake/components/header.dart';
import 'package:math_wake/size.dart';
import '../components/input_filed.dart';
import '../containers/addition-time/timeBox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdditionTime(),
    );
  }
}
class AdditionTime extends StatefulWidget{
  const AdditionTime({super.key});

  @override
  State<AdditionTime> createState() => _AdditionTime();
}

class _AdditionTime extends State<AdditionTime>{
  String title = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "제목을 설정해주세요",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: mediumGap),
          CustomTextFormField("제목"),
          SizedBox(height: largeGap),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 100, child: TimeboxPicker(maxValue: 23)),
                Text(":", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),),
                SizedBox(width: 100, child: TimeboxPicker(maxValue: 59)),
              ],
            ),
          ),
          SizedBox(height: largeGap),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF616161),
                    foregroundColor: Colors.white, // 텍스트 색상
                    padding: EdgeInsets.symmetric(vertical: 16), // 높이 조절
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // ✅ border-radius 10px
                    ),
                  ),
                  child: Text("취소"),
                ),
              ),
              SizedBox(width: mediumGap),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFFFEA00),
                    foregroundColor: Colors.black, // 텍스트 색상
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // ✅ border-radius 10px
                    ),
                  ),
                  child: Text("확인"),
                ),
              ),
            ],
          )
        ],
      ),)
    );
  }
}