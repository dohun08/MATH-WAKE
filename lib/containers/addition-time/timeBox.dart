import 'package:flutter/material.dart';

class TimeboxPicker extends StatefulWidget {
  final int maxValue;
  final Function(int)? onChanged; // ✅ 콜백 추가

  const TimeboxPicker({super.key, required this.maxValue, this.onChanged});

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

              // ✅ 값 변경 시 외부로 전달
              if (widget.onChanged != null) {
                widget.onChanged!(index);
              }
            },
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.maxValue + 1,
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
          const Positioned(top: 55, child: DividerLine()),
          const Positioned(top: 145, child: DividerLine()),
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