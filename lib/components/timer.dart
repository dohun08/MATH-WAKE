import 'dart:async';
import 'package:flutter/material.dart';

class TimerBar extends StatefulWidget {
  final int totalMillis;
  final void Function()? onFinish;

  const TimerBar({super.key, required this.totalMillis, this.onFinish});

  @override
  State<TimerBar> createState() => _TimerBarState();
}

class _TimerBarState extends State<TimerBar> {
  double _progress = 1.0;
  Timer? _timer;
  int elapsedMillis = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      elapsedMillis += 50;
      double newProgress = 1 - (elapsedMillis / widget.totalMillis);
      if (newProgress <= 0) {
        newProgress = 0;
        timer.cancel();
        if (widget.onFinish != null) widget.onFinish!();
      }
      setState(() {
        _progress = newProgress.clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${(_progress * (widget.totalMillis / 1000)).ceil()}s",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        const SizedBox(height: 8),
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF212121),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: _progress,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEA00),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
