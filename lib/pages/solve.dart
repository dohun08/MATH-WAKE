import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:math_wake/components/header.dart';
import 'package:math_wake/components/problem.dart';
import '../components/timer.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Solve(),
    );
  }
}

class Solve extends StatefulWidget {
  const Solve({super.key});

  @override
  State<Solve> createState() => _Solve();
}

class _Solve extends State<Solve> {
  List<Map<String, dynamic>> problems = [];
  int currentProblemIndex = 0;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _loadProblems();

    _audioPlayer = AudioPlayer();

    // 소리 반복 재생 모드 설정
    _audioPlayer.setReleaseMode(ReleaseMode.loop);

    print('🔊 소리 재생 시도 중...');
    _playSound();
  }
  Future<void> _playSound() async {
    try {
      // assets 폴더 경로에 맞게 조정하세요
      await _audioPlayer.play(AssetSource('sounds/sound.mp3'));
      print('✅ 소리 재생 성공');
    } catch (e) {
      print('❌ 소리 재생 실패: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadProblems() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString('problemList');
    if (existing != null) {
      List<dynamic> problemList = jsonDecode(existing);
      setState(() {
        problems = problemList.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
      });
    }

    final prefs2 = await SharedPreferences.getInstance();
    final keys = prefs2.getKeys();

    print('📋 SharedPreferences 전체 저장소:');
    for (String key in keys) {
      final value = prefs2.get(key);
      print('키: $key, 값: $value');
    }
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _onCorrectAnswer() {
    if (currentProblemIndex + 1 < problems.length) {
      setState(() {
        currentProblemIndex++;
      });
    } else {
      _goHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const int totalMillis = 500000;

    if (problems.isEmpty) {
      return Scaffold(
        appBar: Header(),
        body: const Center(
          child: Text('저장된 문제가 없습니다.', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    final currentProblem = problems[currentProblemIndex];

    final base64String = currentProblem['imageBase64'] as String?;
    final answer = currentProblem['answer'] ?? '';

    if (base64String == null || base64String.isEmpty) {
      // 이미지가 없거나 빈 문자열이면 에러 메시지 띄우거나 기본 이미지 사용 가능
      return Scaffold(
        appBar: Header(),
        body: const Center(
          child: Text('이미지를 불러올 수 없습니다.', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    Uint8List imageBytes;
    try {
      imageBytes = base64Decode(base64String);
    } catch (e) {
      return Scaffold(
        appBar: Header(),
        body: Center(
          child: Text('이미지 디코딩 실패: $e', style: const TextStyle(color: Colors.white)),
        ),
      );
    }

    Problem problem = Problem(
      image: MemoryImage(imageBytes),  // ✅ 변경된 부분
      answer: answer,
    );
    return Scaffold(
      appBar: Header(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            TimerBar(
              totalMillis: totalMillis,
              onFinish: () => _goHome(context),
            ),
            const SizedBox(height: 24),
            ProblemWidget(
              problem: problem,
              onCorrect: _onCorrectAnswer,
            ),
          ],
        ),
      ),
    );
  }
}
