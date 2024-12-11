import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

class TokenCreated extends StatelessWidget {
  const TokenCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        isAuth: false,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 170, horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          decoration: semiCircleBox(color: darkBlue200, radius: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: CustomImageView(imagePath: serviceCompletedSmiley)),
              const SizedBox(height: 24),
              Text(
                "Thank you for reaching\nout to us!",
                style: textStyleSemiBoldMedium.copyWith(fontSize: 17.sp),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Our customer service officer will be\nreplying you within',
                      style: textStyleSmall.copyWith(
                          color: white.withOpacity(0.5)),
                    ),
                    TextSpan(
                      text: ' 24 hours.',
                      style: textStyleSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: gradientContainer(
                    height: 45,
                    borderRadius: 12,
                    child: SizedBox(
                        width: 100.w,
                        height: 45,
                        child: Center(
                            child: Text(
                          "Ok",
                          style: textStyleSemiBoldMedium,
                        )))),
              )
            ],
          ),
        ));
  }
}