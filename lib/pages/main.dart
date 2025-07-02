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
  List<Map<String, dynamic>> problems = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();

    final keys = prefs.getKeys();
    print('📋 SharedPreferences 전체 저장소:');
    final sampleAlarms = [
      {
        "title": "알람입니당",
        "hour": 7,
        "minute": 30,
        "status": true
      },
      {
        "title": "이건 꼭 일어나야함",
        "hour": 8,
        "minute": 0,
        "status": false
      }
    ];
    for (String key in keys) {
      final value = prefs.getString(key);
      print('키: $key, 값: $value');

      // 예: problemList가 있으면 상태에 저장
      if (key == 'problemList' && value != null) {
        List<dynamic> problemJsonList = jsonDecode(value);
        List<Map<String, dynamic>> problemList =
        problemJsonList.map((e) => Map<String, dynamic>.from(e)).toList();
        setState(() {
          problems = problemList;  // problems는 상태변수라고 가정
        });
      }

      // 예: alarmList가 있으면 상태에 저장
      if (key == 'alarmList' && value != null) {
        List<dynamic> alarmJsonList = jsonDecode(value);
        List<Map<String, dynamic>> alarmList =
        alarmJsonList.map((e) => Map<String, dynamic>.from(e)).toList();
        final mergedAlarms = [...alarmList, ...sampleAlarms];

        setState(() {
          _alarmList = mergedAlarms;
        });

        for (var alarm in _alarmList) {
          print('title: ${alarm['title']}, hour: ${alarm['hour']}, minute: ${alarm['minute']}');
        }
      }

      // 필요하면 여기에 다른 키들도 비슷하게 처리 가능
    }
  }

  void _toggleAlarmStatus(int index, bool newStatus) async {
    setState(() {
      _alarmList[index]['status'] = newStatus;
    });

    // SharedPreferences에 업데이트 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alarmList', jsonEncode(_alarmList));

    print("알람 ${_alarmList[index]['title']} 상태 변경: $newStatus");
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
                ElevatedButton(onPressed: () async {
                  // 알람 추가 페이지로 이동
                  final result = await Navigator.pushNamed(context, '/addition/time');

                  // 돌아왔을 때 result가 'updated'라면 데이터 다시 불러오기
                  if (result == 'updated') {
                    await _loadSavedData();
                  }
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
                  for (int i = 0; i < _alarmList.length; i++) ...[
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
                            _alarmList[i]['title'] ?? '제목 없음',
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
                                    '${(_alarmList[i]['hour'] ?? 0).toString().padLeft(2, '0')}:${(_alarmList[i]['minute'] ?? 0).toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 40,
                                      letterSpacing: 3.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    (_alarmList[i]['hour'] != null && _alarmList[i]['hour']! >= 12) ? '오후' : '오전',
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
                                isOn: _alarmList[i]['status'] ?? false,
                                onToggle: (bool value) {
                                  _toggleAlarmStatus(i, value);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: largeGap),
                  ]

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