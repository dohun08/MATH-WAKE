import 'package:flutter/material.dart';
import 'package:math_wake/size.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;

  const CustomTextFormField(this.text, {Key? key}) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}
class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isHovered = false;

  static const baseColor = Colors.white;       // 기본 흰색으로 변경
  static const hoverColor = Color(0xFFFFEA00); // 노란색 (hover)

  @override
  Widget build(BuildContext context) {
    final borderColor = _isHovered ? hoverColor : baseColor;
    final textColor = _isHovered ? Colors.white : baseColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: smallGap),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: SizedBox(
            width: double.infinity,
            child: TextFormField(
              validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
              obscureText: widget.text.toLowerCase().contains("password"),
              cursorColor: borderColor,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: "${widget.text}",
                hintStyle: TextStyle(color: textColor.withOpacity(0.7)), // 힌트는 약간 투명하게
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 2.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}