import 'dart:async';
import 'package:flutter/material.dart';
import 'package:math_wake/pages/addition-problem.dart';
import 'package:math_wake/pages/addition-time.dart';
import 'package:math_wake/pages/main.dart';
import 'package:math_wake/pages/solve.dart';

// ✅ navigatorKey를 전역으로 선언
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyAppWrapper());
}

/// MyApp을 감싸는 StatefulWidget을 하나 만들어 타이머 설정
class MyAppWrapper extends StatefulWidget {
  @override
  _MyAppWrapperState createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  @override
  void initState() {
    super.initState();

    // ✅ 앱 시작 후 10초 뒤 특정 라우터로 이동
    Timer(Duration(seconds: 10), () {
      navigatorKey.currentState?.pushNamed('/addition/problem');
    });
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
      navigatorKey: navigatorKey, // ✅ navigatorKey 연결
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