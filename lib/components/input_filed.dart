import 'package:flutter/material.dart';
import 'package:math_wake/size.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final Function(String)? onChanged; // ✅ 추가된 부분

  const CustomTextFormField(
      this.text, {
        Key? key,
        required this.controller,
        this.onChanged, // ✅ 추가된 부분
      }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isHovered = false;

  static const baseColor = Colors.white;
  static const hoverColor = Color(0xFFFFEA00);

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
              controller: widget.controller,
              onChanged: widget.onChanged, // ✅ 추가된 부분
              validator: (value) =>
              value!.isEmpty ? "Please enter some text" : null,
              obscureText: widget.text.toLowerCase().contains("password"),
              cursorColor: borderColor,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: widget.text,
                hintStyle: TextStyle(color: textColor.withOpacity(0.7)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
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
