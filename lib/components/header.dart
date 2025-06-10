import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:math_wake/size.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea( // 상태바와 겹치지 않도록
      child: Padding(
        padding: const EdgeInsets.only(top: 20), // 여기에 마진 탑 추가
        child: AppBar(
          backgroundColor: const Color(0xFF0d0d0d),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/logo.svg",
                height: 28,
                width: 30,
              ),
              SizedBox(width: mediumGap),
              Text(
                "Math Wake",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}