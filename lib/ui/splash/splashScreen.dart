import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/auth/login/loginScreen.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              color: darkBlue,
              child: CustomImageView(imagePath: threadBg, fit: BoxFit.cover),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => LoginScreen.builder(context)));
              },
              child: Center(
                child: Hero(tag: logo, child: CustomImageView(imagePath: logo)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}