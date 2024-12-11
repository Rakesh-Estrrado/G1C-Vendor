import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:sizer/sizer.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool isAuth;

  const Background({super.key, required this.child, this.isAuth = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                isAuth?background:background2,
                fit: BoxFit.cover,
              )),
          SafeArea(child: child)
        ],
      ),
    );
  }
}
