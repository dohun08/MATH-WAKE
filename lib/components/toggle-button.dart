import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool isOn; // 외부에서 상태 받음
  final Color onColor;
  final Color offColor;
  final ValueChanged<bool>? onToggle;

  const ToggleButton({
    Key? key,
    required this.isOn,
    this.onColor = const Color(0xFFFFEA00), // 노란색
    this.offColor = const Color(0xFFEFEFEF), // 연한 회색
    this.onToggle,
  }) : super(key: key);

  void toggle() {
    if (onToggle != null) {
      onToggle!(!isOn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: Container(
        width: 60,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isOn ? onColor : offColor,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
