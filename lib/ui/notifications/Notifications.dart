import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/notifications/bloc/notifications_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/appBar.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => NotificationsBloc(context),
        child: Notifications());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar(title: "Notifications", showGlobe: false,makeTitleCenter: true),
          SizedBox(height: 12),
          Expanded(child: ListView.builder(shrinkWrap: true,itemCount: 4,itemBuilder: (context, i) {
            return Container(
              decoration: semiCircleBox(color: darkBlue, radius: 10),
              margin: EdgeInsets.symmetric(vertical: 4.0),
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("04.00pm",style: textStyleSmall.copyWith(color:white.withOpacity(0.5)),),
                      Text("12/09/2024",style: textStyleSmall.copyWith(color:white.withOpacity(0.5)),)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Text("Home Cleaning Received",style: textStyleRegular.copyWith(color:white))),
                      Icon(Icons.arrow_forward_ios_rounded,size: 16,color: white,)
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("You have a new booking request from Joh Doe! Tap here to view the details and confirm your availability.",style: textStyleSmall.copyWith(color:white.withOpacity(0.5)),)

                ],
              ),
            );
          }))
        ],
      ),
    ));
  }
}
