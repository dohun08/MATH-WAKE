import 'package:flutter/material.dart';
import 'package:math_wake/components/header.dart';
import 'package:math_wake/size.dart';
import '../components/toggle-button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  void _increaseCounter() {
    setState(() {
      counter++;
    });
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
                // ListView의 기본 패딩을 없애고 싶으면 아래 주석 해제
                // padding: EdgeInsets.zero,
                children: [
                  Container(
                    // height: 100, // ListView 안에 있는 자식 Container에 고정 높이를 주면 스크롤이 안 될 수 있습니다.
                    // 자식 Container의 높이는 내부 내용에 따라 유동적으로 조절되도록 하는 것이 일반적입니다.
                    // 하지만 알람 카드가 고정된 높이라면 유지해도 괜찮습니다.
                    padding : EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121), // const 추가
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Align 위젯은 Column의 crossAxisAlignment: CrossAxisAlignment.start 때문에 불필요.
                        Text(
                          "알람제목",
                          style: const TextStyle( // const 추가
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // 텍스트 색상 추가 (배경이 어두우므로)
                          ),
                        ),
                        SizedBox(height: mediumGap), // size.dart 파일에 정의된 변수 사용
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "07:30",
                                  style: const TextStyle( // const 추가
                                    fontSize: 40,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white, // 텍스트 색상 추가
                                  ),
                                ),
                                const SizedBox(width: 8), // const 추가
                                Text(
                                  "오전",
                                  style: const TextStyle( // const 추가
                                    fontSize: 18,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70, // 텍스트 색상 추가
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: largeGap),
                  Container(
                    // height: 100, // ListView 안에 있는 자식 Container에 고정 높이를 주면 스크롤이 안 될 수 있습니다.
                    // 자식 Container의 높이는 내부 내용에 따라 유동적으로 조절되도록 하는 것이 일반적입니다.
                    // 하지만 알람 카드가 고정된 높이라면 유지해도 괜찮습니다.
                    padding : EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121), // const 추가
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Align 위젯은 Column의 crossAxisAlignment: CrossAxisAlignment.start 때문에 불필요.
                        Text(
                          "알람제목",
                          style: const TextStyle( // const 추가
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // 텍스트 색상 추가 (배경이 어두우므로)
                          ),
                        ),
                        SizedBox(height: mediumGap), // size.dart 파일에 정의된 변수 사용
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "07:30",
                                  style: const TextStyle( // const 추가
                                    fontSize: 40,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white, // 텍스트 색상 추가
                                  ),
                                ),
                                const SizedBox(width: 8), // const 추가
                                Text(
                                  "오전",
                                  style: const TextStyle( // const 추가
                                    fontSize: 18,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70, // 텍스트 색상 추가
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: largeGap),
                  Container(
                    // height: 100, // ListView 안에 있는 자식 Container에 고정 높이를 주면 스크롤이 안 될 수 있습니다.
                    // 자식 Container의 높이는 내부 내용에 따라 유동적으로 조절되도록 하는 것이 일반적입니다.
                    // 하지만 알람 카드가 고정된 높이라면 유지해도 괜찮습니다.
                    padding : EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121), // const 추가
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Align 위젯은 Column의 crossAxisAlignment: CrossAxisAlignment.start 때문에 불필요.
                        Text(
                          "알람제목",
                          style: const TextStyle( // const 추가
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // 텍스트 색상 추가 (배경이 어두우므로)
                          ),
                        ),
                        SizedBox(height: mediumGap), // size.dart 파일에 정의된 변수 사용
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "07:30",
                                  style: const TextStyle( // const 추가
                                    fontSize: 40,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white, // 텍스트 색상 추가
                                  ),
                                ),
                                const SizedBox(width: 8), // const 추가
                                Text(
                                  "오전",
                                  style: const TextStyle( // const 추가
                                    fontSize: 18,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70, // 텍스트 색상 추가
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: largeGap),
                  Container(
                    // height: 100, // ListView 안에 있는 자식 Container에 고정 높이를 주면 스크롤이 안 될 수 있습니다.
                    // 자식 Container의 높이는 내부 내용에 따라 유동적으로 조절되도록 하는 것이 일반적입니다.
                    // 하지만 알람 카드가 고정된 높이라면 유지해도 괜찮습니다.
                    padding : EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121), // const 추가
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Align 위젯은 Column의 crossAxisAlignment: CrossAxisAlignment.start 때문에 불필요.
                        Text(
                          "알람제목",
                          style: const TextStyle( // const 추가
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // 텍스트 색상 추가 (배경이 어두우므로)
                          ),
                        ),
                        SizedBox(height: mediumGap), // size.dart 파일에 정의된 변수 사용
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "07:30",
                                  style: const TextStyle( // const 추가
                                    fontSize: 40,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white, // 텍스트 색상 추가
                                  ),
                                ),
                                const SizedBox(width: 8), // const 추가
                                Text(
                                  "오전",
                                  style: const TextStyle( // const 추가
                                    fontSize: 18,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70, // 텍스트 색상 추가
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: largeGap),
                  Container(
                    // height: 100, // ListView 안에 있는 자식 Container에 고정 높이를 주면 스크롤이 안 될 수 있습니다.
                    // 자식 Container의 높이는 내부 내용에 따라 유동적으로 조절되도록 하는 것이 일반적입니다.
                    // 하지만 알람 카드가 고정된 높이라면 유지해도 괜찮습니다.
                    padding : EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121), // const 추가
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Align 위젯은 Column의 crossAxisAlignment: CrossAxisAlignment.start 때문에 불필요.
                        Text(
                          "알람제목",
                          style: const TextStyle( // const 추가
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // 텍스트 색상 추가 (배경이 어두우므로)
                          ),
                        ),
                        SizedBox(height: mediumGap), // size.dart 파일에 정의된 변수 사용
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "07:30",
                                  style: const TextStyle( // const 추가
                                    fontSize: 40,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white, // 텍스트 색상 추가
                                  ),
                                ),
                                const SizedBox(width: 8), // const 추가
                                Text(
                                  "오전",
                                  style: const TextStyle( // const 추가
                                    fontSize: 18,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70, // 텍스트 색상 추가
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: largeGap),
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