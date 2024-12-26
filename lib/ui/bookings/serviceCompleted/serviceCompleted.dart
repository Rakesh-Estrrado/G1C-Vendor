import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/bookings/assignedWorkers/AssignedWorkers.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../../dashBoard/dashboard_screen.dart';

class ServiceCompleted extends StatelessWidget {
  const ServiceCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
        isAuth: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CustomImageView(imagePath: serviceCompletedSmiley),
              ),
              const SizedBox(height: 24),
              Text("Your Service is Complete", style: textStyleSemiBoldMedium),
              const SizedBox(height: 36),
              Text(
                  "Important Note:\n\nPlease remember to leave the premises immediately once the assignment is completed. This ensures professionalism and maintains the privacy and comfort of the customer. Thank you for your cooperation!",
                  style:
                      textStyleSmall.copyWith(color: white.withOpacity(0.5))),
              const SizedBox(height: 36),
              InkWell(
                onTap: ()=> Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                        (route) => false),
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
