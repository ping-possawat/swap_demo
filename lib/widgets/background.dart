import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
        height: Get.size.height * .7,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xff8277ea),
              Color(0xffc0a5f5),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height * .8)
      ..quadraticBezierTo(
        size.width * .05,
        size.height * 1,
        size.width * .6,
        size.height * .85,
      )
      ..quadraticBezierTo(
        size.width * .72,
        size.height * .8,
        size.width * .78,
        size.height * .82,
      )
      ..quadraticBezierTo(
        size.width,
        size.height * .86,
        size.width,
        size.height * .82,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
