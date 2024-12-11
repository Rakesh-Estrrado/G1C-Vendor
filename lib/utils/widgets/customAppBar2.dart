import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/chat/ChatList.dart';
import 'package:g1c_vendor/ui/notifications/Notifications.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';

class CustomAppBar2 extends StatelessWidget {
  final String title;
  final bool showBackArrow;
  final bool showMenuIcons;
  const CustomAppBar2({super.key,  required this.title, this.showBackArrow = true, this.showMenuIcons = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showBackArrow?InkWell(onTap: ()=>Navigator.pop(context),child: Icon(Icons.arrow_back,color: white,)):SizedBox(),
        Spacer(),
        Text(title, style: textStyleSemiBoldMedium),
        Spacer(),
        if (showMenuIcons)
        const SizedBox(width: 12.0),
        if (showMenuIcons) _buildIconWithNotificationBadge(icMessenger, () {
          navigateTo(context: context, destination: ChatList.builder(context));
        }),
        if (showMenuIcons) const SizedBox(width: 12.0),
        if (showMenuIcons) _buildIconWithNotificationBadge(icNotification, () {
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
}

