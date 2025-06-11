import 'package:flutter/material.dart';

class TimeboxPicker extends StatefulWidget {
  final int maxValue;

  const TimeboxPicker({super.key, required this.maxValue});

  @override
  State<TimeboxPicker> createState() => _TimeboxPickerState();
}

class _TimeboxPickerState extends State<TimeboxPicker> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListWheelScrollView.useDelegate(
            itemExtent: 80,
            diameterRatio: 2,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.maxValue + 1, // 0 ~ maxValue
              builder: (context, index) {
                final isSelected = index == selectedIndex;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      '$index',
                      style: TextStyle(
                        fontSize: isSelected ? 40 : 24,
                        color: isSelected ? Colors.white : Colors.grey,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 위쪽 선
          const Positioned(
            top: 55,
            child: DividerLine(),
          ),
          // 아래쪽 선
          const Positioned(
            top: 145,
            child: DividerLine(),
          ),
        ],
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 2,
      color: Colors.white,
    );
  }
}