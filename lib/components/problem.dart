import 'package:flutter/material.dart';

class Problem {
  final ImageProvider image;
  final String answer;

  Problem({required this.image, required this.answer});
}

class ProblemWidget extends StatefulWidget {
  final Problem problem;
  final void Function() onCorrect;

  const ProblemWidget({super.key, required this.problem, required this.onCorrect});

  @override
  State<ProblemWidget> createState() => _ProblemWidgetState();
}

class _ProblemWidgetState extends State<ProblemWidget> {
  final TextEditingController _answerController = TextEditingController();

  void _checkAnswer() {
    if (_answerController.text.trim() == widget.problem.answer) {
      widget.onCorrect();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('정답이 틀렸습니다! 다시 시도해주세요.')),
      );
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: widget.problem.image,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _answerController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: '정답을 입력하세요',
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white38),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _checkAnswer,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFEA00),
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text('확인'),
        ),
      ],
    );
  }
}
