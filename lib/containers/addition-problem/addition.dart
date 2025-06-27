import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_wake/size.dart';
import 'package:image_picker/image_picker.dart';

class ProblemPicker extends StatefulWidget {
  final ImageProvider? image;

  const ProblemPicker({super.key, this.image});

  @override
  State<ProblemPicker> createState() => _ProblemPickerState();
}

class _ProblemPickerState extends State<ProblemPicker> {
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _imageBytes;
  bool _hasTakenPicture = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!_hasTakenPicture) {
        _hasTakenPicture = true;
        takePicture();
      }
    });
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 600,
    );

    if (pickedFile == null) return;

    final bytes = await pickedFile.readAsBytes();

    setState(() {
      _imageBytes = bytes;
    });

    print('📸 이미지 바이트 크기: ${bytes.length}');
  }

  Future<void> _saveProblem() async {
    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미지를 먼저 촬영해주세요.')),
      );
      return;
    }

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('정답을 입력해주세요.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString('problemList');
    List<dynamic> problemList = existing == null ? [] : jsonDecode(existing);

    final newProblem = {
      'imageBase64': base64Encode(_imageBytes!),
      'answer': _nameController.text.trim(),
    };

    problemList.add(newProblem);

    await prefs.setString('problemList', jsonEncode(problemList));

    print('✅ 문제 저장 완료: $newProblem');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("해당문제를", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
          const Text("등록하시겠습니까?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          SizedBox(height: mediumGap),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF212121),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _imageBytes != null
                    ? Image.memory(_imageBytes!, width: 200, height: 200, fit: BoxFit.cover)
                    : (widget.image != null
                    ? Image(image: widget.image!, width: 200, height: 200, fit: BoxFit.cover)
                    : const SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(child: Text('사진이 없습니다.', style: TextStyle(color: Colors.white))))),
                const SizedBox(height: largeGap),
                ElevatedButton(
                  onPressed: takePicture,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('사진 찍기'),
                ),
                const SizedBox(height: largeGap),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: '정답을 입력해주세요',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: largeGap),
                Row(
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("취소"),
                      ),
                    ),
                    SizedBox(width: mediumGap),
                    Expanded(
                      child: TextButton(
                        onPressed: _saveProblem,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFFFEA00),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("확인"),
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
