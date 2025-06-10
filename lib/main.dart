import 'package:flutter/material.dart';
import 'package:math_wake/pages/main.dart';


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
        '/addition/time': (context) => HomePage(),
        '/solve': (context) => HomePage(),
        '/addition/problem': (context) => HomePage(),
      },
    );
  }
}