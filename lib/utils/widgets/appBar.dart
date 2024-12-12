import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/chat/ChatList.dart';
import 'package:g1c_vendor/ui/notifications/Notifications.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../../di/AppLocator.dart';
import '../sessionManager.dart';


class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showGlobe;
  final bool makeTitleCenter;
  const CustomAppBar({super.key,  required this.title, this.showGlobe = true, this.makeTitleCenter = false});

  @override
  Widget build(BuildContext context) {
    final sessionManager = AppLocator.instance<SessionManager>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (makeTitleCenter) Spacer(),
        if (makeTitleCenter) SizedBox(width: 35.sp),
        title.isNotEmpty
            ? Text(
          title,
          style: textStyleSemiBoldMedium,
        )
            : RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'WELCOME BACK \n',
                style: textStyleRegular.copyWith(fontSize: 14.sp),
              ),
              TextSpan(
                text: '${sessionManager.userName}',
                style: textStyleSemiBoldLarge,
              ),
            ],
          ),
        ),
        Spacer(), // This spacer separates the title section from the icons on the right
        if (showGlobe)
          InkWell(
            onTap: () {
              showBottomSheetLanguageSelection(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CustomImageView(imagePath: icGlobe, width: 20),
            ),
          ),
        const SizedBox(width: 12.0),
        _buildIconWithNotificationBadge(icMessenger, () {
          navigateTo(context: context, destination: ChatList.builder(context));
        }),
        const SizedBox(width: 12.0),
        _buildIconWithNotificationBadge(icNotification, () {
          navigateTo(context: context, destination: Notifications.builder(context));
        }),
      ],
    );

  }

  /// Builds an icon with a notification badge on the top-right
  Widget _buildIconWithNotificationBadge(String imagePath,Function() onClick) {
    return InkWell(
      onTap: ()=>onClick(),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Stack(
          clipBehavior: Clip.none, // To allow positioning outside the Stack
          children: [
            CustomImageView(imagePath: imagePath, width: 20),
            Positioned(
              right: -2, // Adjust the right position
              top: -4,   // Adjust the top position
              child: CustomImageView(imagePath: icNotiDot, width: 12),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetLanguageSelection(BuildContext context) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom, // To adjust for the keyboard
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0)),
                    color: darkBlue,
                    border: Border.all(width: 2,color: darkBlue400),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Select Language",style: textStyleRegularMedium,)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("English",style: textStyleRegular,),
                            Spacer(),
                            Icon(Icons.check,color: switchGreen,size: 18)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Malaysia",style: textStyleRegular,),
                            Spacer(),
                            // Icon(Icons.check,color: switchGreen,size: 18)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
  }
}

