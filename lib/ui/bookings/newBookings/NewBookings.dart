import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/bookings/details/NewBookingDetails.dart';
import 'package:g1c_vendor/ui/bookings/serviceExtension/ServiceExtension.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/NoDataView.dart';

class NewBookings extends StatelessWidget {
  const NewBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return true?NoDataView(msg: "No bookings to show.."):ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: darkBlue200,
              surfaceTintColor: darkBlue200,
              child: InkWell(
                onTap: () {
                  if(i==1){
                    showServiceEndingBottomSheet(context);

                  }else{
                    navigateTo(context: context, destination: NewBookingDetails());
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: dummyImage,
                            width: 45,
                            height: 45,
                            radius:
                                const BorderRadius.all(Radius.circular(100.0)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Clubbing Partner",
                                    style: textStyleRegularMedium),
                                Text("BK#123",
                                    style: textStyleSmall.copyWith(color:white.withOpacity(0.5))),
                                SizedBox(height: 4),
                                Container(
                                  decoration: BoxDecoration(
                                      color: cardRed,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 2.0),
                                    child: Text("00:14:59",
                                        style: textStyleRegular.copyWith(
                                            color: red, fontSize: 14.sp)),
                                  ),
                                )
                              ]),
                          const Spacer(),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_forward_ios_sharp,
                                    color: white, size: 12),
                                const SizedBox(height: 6),
                                gradientContainer(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Center(
                                      child: Text("RM 60/3 hrs",
                                          style: textStyleSemiBold.copyWith(
                                              color: white, fontSize: 14.sp)),
                                    ),
                                  ),
                                )
                              ]),
                        ],
                      ),
                      Container(
                          height: 1,
                          color: black,
                          margin: EdgeInsets.symmetric(vertical: 12.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(imagePath: icCalendar),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("10.00am,  09 Sep 2024, 4 hrs",
                                  style:
                                      textStyleSemiBold.copyWith(color: white)),
                              Text("Schedule",
                                  style: textStyleSmall.copyWith(
                                      color: white.withOpacity(0.5))),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(imagePath: icLocation),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pitt Club KL",
                                  style:
                                      textStyleSemiBold.copyWith(color: white)),
                              Text("Venue",
                                  style: textStyleSmall.copyWith(
                                      color: white.withOpacity(0.5))),
                            ],
                          ),
                          const Spacer(),
                          CustomImageView(
                            imagePath: icNavigation,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void showServiceEndingBottomSheet(BuildContext context) {
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
            Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        border: Border.all(width: 2,color: borderBlue)
        ),
              child: Column(
                children: [
                  Text("Service Ending Soon",style: textStyleSemiBoldMedium),
                  SizedBox(height: 10),
                  Text("You have 10 minutes remaining before the\nscheduled service ends. Please wrap up\nany remaining tasks and ensure everything\nis in order. If you need more time, contact the customer.",style: textStyleRegular,textAlign: TextAlign.center,),
                  SizedBox(height: 20),
                  CommonButton(label: "OK", onTap:() {
                    Navigator.pop(context);

                    navigateTo(context: context, destination: ServiceExtension());
                  }),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
