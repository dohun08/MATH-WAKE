import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';  // 추가
import 'package:math_wake/pages/addition-problem.dart';
import 'package:math_wake/pages/addition-time.dart';
import 'package:math_wake/pages/main.dart';
import 'package:math_wake/pages/solve.dart';

// navigatorKey 전역 선언
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyAppWrapper());
}

class MyAppWrapper extends StatefulWidget {
  @override
  _MyAppWrapperState createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  Timer? _alarmCheckTimer;
  bool _isNavigated = false;  // 중복 이동 방지용 플래그

  @override
  void initState() {
    super.initState();

    // 주기적으로 알람 체크 (예: 1분마다)
    _alarmCheckTimer = Timer.periodic(Duration(seconds: 30), (timer) async {
      await _checkAlarmsAndNavigate();
    });
  }

  @override
  void dispose() {
    _alarmCheckTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkAlarmsAndNavigate() async {
    if (_isNavigated) return;  // 이미 이동했으면 무시

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('alarmList');
    if (jsonString == null) return;

    List<dynamic> alarmList = jsonDecode(jsonString);

    final now = DateTime.now();

    for (var alarm in alarmList) {
      bool status = alarm['status'] ?? false;
      int hour = alarm['hour'] ?? 0;
      int minute = alarm['minute'] ?? 0;

      if (status) {
        // 현재 시간과 알람 시간 비교 (시간, 분까지 정확히 맞으면)
        if (now.hour == hour && now.minute == minute) {
          _isNavigated = true;

          // Solve 페이지로 이동
          navigatorKey.currentState?.pushNamed('/solve');

          break; // 한번 이동하면 더 이상 체크 안함
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Wake',
      navigatorKey: navigatorKey,
      initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0D0D0D),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
      routes: {
        '/': (context) => HomePage(),
        '/addition/time': (context) => AdditionTime(),
        '/solve': (context) => Solve(),
        '/addition/problem': (context) => AdditionProblem(),
      },
    );
  }
}