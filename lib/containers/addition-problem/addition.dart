import 'package:flutter/material.dart';
import 'package:math_wake/size.dart';

class ProblermPicker extends StatefulWidget {
  final ImageProvider image;

  const ProblermPicker({super.key, required this.image});

  @override
  State<ProblermPicker> createState() => _ProblermPickerState();
}

class _ProblermPickerState extends State<ProblermPicker> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("해당문제를", style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500
          ),),
          Text("등록하시겠습니까?", style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: mediumGap),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF212121),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Image(
                  image: widget.image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: largeGap),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '정답을 입력해주세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: largeGap),
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
                        onPressed: () {
                          Navigator.pushNamed(context, "/");
                        },
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
            ),
          )
        ],
      ),
    );
  }
}