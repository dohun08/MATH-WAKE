import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 추가
import 'package:math_wake/size.dart';
import '../components/input_filed.dart';
import '../containers/addition-time/timeBox.dart';
import 'dart:convert';

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

class AdditionTime extends StatefulWidget {
  const AdditionTime({super.key});

  @override
  State<AdditionTime> createState() => _AdditionTime();
}

class _AdditionTime extends State<AdditionTime> {
  String title = "";
  int selectedHour = 0;
  int selectedMinute = 0;

  final TextEditingController _titleController = TextEditingController();

  void _saveToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 1. 기존에 저장된 리스트 가져오기 (없으면 빈 리스트)
    String? jsonString = prefs.getString('alarmList');
    List<dynamic> alarmList = jsonString == null ? [] : jsonDecode(jsonString);

    // 2. 새 알람 아이템 만들기
    Map<String, dynamic> newAlarm = {
      'title': title,
      'hour': selectedHour,
      'minute': selectedMinute,
    };

    // 3. 리스트에 새 아이템 추가
    alarmList.add(newAlarm);

    // 4. 다시 JSON 문자열로 변환해 저장
    await prefs.setString('alarmList', jsonEncode(alarmList));

    print("✅ 저장 완료: $title, $selectedHour:$selectedMinute");
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "제목을 설정해주세요",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: mediumGap),
            CustomTextFormField(
              "제목",
              controller: _titleController,
              onChanged: (val) => title = val,
            ),
            SizedBox(height: largeGap),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 100,
                    child: TimeboxPicker(
                      maxValue: 23,
                      onChanged: (val) {
                        selectedHour = val;
                      },
                    ),
                  ),
                  const Text(":", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 100,
                    child: TimeboxPicker(
                      maxValue: 59,
                      onChanged: (val) {
                        selectedMinute = val;
                      },
                    ),
                  ),
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
                      backgroundColor: const Color(0xFF616161),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("취소"),
                  ),
                ),
                SizedBox(width: mediumGap),
                Expanded(
                  child: TextButton(
                    onPressed: _saveToPreferences,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFFEA00),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("확인"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
