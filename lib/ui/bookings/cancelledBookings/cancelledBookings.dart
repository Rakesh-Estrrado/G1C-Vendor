import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/bookings/details/CancelOrCompleteBooking.dart';
import 'package:g1c_vendor/ui/bookings/details/CancelledBookingDetails.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

class CancelledBookings extends StatelessWidget {
  const CancelledBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: (){
                if(i==1) {
                  navigateTo(
                      context: context, destination: CancelOrCompleteBooking());
                }else{
                  navigateTo(
                      context: context, destination: CancelledBookingDetails());
                }
              },
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: darkBlue,
                surfaceTintColor: darkBlue,
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
                            radius: const BorderRadius.all(Radius.circular(100.0)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Clubbing Partner",
                                    style: textStyleRegularMedium),
                                gradientContainer(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 2.0),
                                    child: Row(
                                      children: [
                                        Text("RM 140.00",
                                            style: textStyleSemiBold.copyWith(
                                                color: white, fontSize: 14.sp,decoration: TextDecoration.lineThrough,decorationColor: white)),
                                        Text("  RM 120.00",
                                            style: textStyleSemiBold.copyWith(
                                                color: white, fontSize: 14.sp)),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp,
                              color: white, size: 12),
                          const SizedBox(height: 6),
                        ],
                      ),

                      Container(height: 1,color: black,margin: EdgeInsets.symmetric(vertical: 12.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Status",
                              style: textStyleSemiBold.copyWith(color: white)),
                          const Spacer(),
                          Container(
                            decoration: semiCircleBox(color: cardRed, radius: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                              child: Text("Declined",
                                  style: textStyleSmall.copyWith(
                                      color: red)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8.0),
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
                                  style: textStyleSemiBold.copyWith(
                                      color: white)),
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
                                  style: textStyleSemiBold.copyWith(
                                      color: white)),
                              Text("Venue",
                                  style: textStyleSmall.copyWith(
                                      color: white.withOpacity(0.5))),
                            ],
                          ),
                          const Spacer(),
                          CustomImageView(imagePath: icNavigation,)
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
}
