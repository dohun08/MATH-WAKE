import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_wake/components/header.dart';
import 'package:math_wake/size.dart';
import '../components/toggle-button.dart';
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
      home: HomePage(), // 여기를 HomePage()로 변경
    );
  }
}

// StatefulWidget 정의
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// State 클래스
class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _alarmList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('alarmList');

    if (jsonString == null) {
      print('저장된 알람 리스트가 없습니다.');
      return;
    }

    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Map<String, dynamic>> alarmList =
    jsonList.map((e) => Map<String, dynamic>.from(e)).toList();

    setState(() {
      _alarmList = alarmList;
    });

    for (var alarm in _alarmList) {
      print('title: ${alarm['title']}, hour: ${alarm['hour']}, minute: ${alarm['minute']}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: Header(),
      body: Container(
        padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/addition/time');
                },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(4), // 버튼 크기 조절
                    backgroundColor: Color(0xFFFFEA00), // 배경색
                  ),
                  child: const Icon(Icons.add, color: Colors.black, size: 24,),
                )
              ],
            ),
            SizedBox(height: largeGap),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (var alarm in _alarmList) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF212121),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alarm['title'] ?? '제목 없음',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: mediumGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${(alarm['hour'] ?? 0).toString().padLeft(2, '0')}:${(alarm['minute'] ?? 0).toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 40,
                                      letterSpacing: 3.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    (alarm['hour'] != null && alarm['hour']! >= 12) ? '오후' : '오전',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 3.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              ToggleButton(
                                onToggle: (bool value) {
                                  print("Toggle is now: $value");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: largeGap),
                  ],
                ],
              ),

            ),
       ],
      ),
      ),
        bottomNavigationBar: Container(
          height: 60, // 바의 높이
          padding: const EdgeInsets.all(4), // 버튼 크기 조절
          decoration: const BoxDecoration( // const 추가
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(13, 13, 13, 0.0),
                Color(0xFF0D0D0D),
              ],
              stops: [
                0.012,
                0.3517,
              ],
            ),
          ),
          child: ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/addition/problem');
          },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0), // 버튼 크기 조절
              backgroundColor: Color(0xFFFFEA00), // 배경색
            ),
            child: const Icon(Icons.camera, color: Colors.black, size: 20,),
          ),
        )
    );
  }
}