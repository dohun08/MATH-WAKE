import 'package:flutter/material.dart';
import 'package:math_wake/pages/addition-problem.dart';
import 'package:math_wake/pages/addition-time.dart';
import 'package:math_wake/pages/main.dart';
import 'package:math_wake/pages/solve.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Wake',
      initialRoute: '/',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
        ),

        scaffoldBackgroundColor: Color(0xFF0D0D0D),
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