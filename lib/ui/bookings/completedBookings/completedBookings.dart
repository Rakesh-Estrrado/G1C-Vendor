import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/bookings/details/CompletedBookingDetails.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/NoDataView.dart';

class CompletedBookings extends StatelessWidget {
  const CompletedBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return true?NoDataView(msg: "No bookings to show.."):ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                navigateTo(
                    context: context, destination: CompletedBookingDetails());
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
                                gradientContainer(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 2.0),
                                    child: Row(
                                      children: [
                                        Text("RM 140.00",
                                            style: textStyleSemiBold.copyWith(
                                                color: white,
                                                fontSize: 14.sp,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: white)),
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
                        ],
                      ),
                      Container(
                          height: 1,
                          color: black,
                          margin: EdgeInsets.symmetric(vertical: 12.0)),
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
                                  style:
                                      textStyleSemiBold.copyWith(color: white)),
                              Text("Schedule",
                                  style: textStyleSmall.copyWith(
                                      color: white.withOpacity(0.5))),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
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
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 3),
                                  CustomImageView(
                                      imagePath: dummyImage,
                                      height: 40,
                                      width: 40,
                                      radius: const BorderRadius.all(
                                          Radius.circular(100.0))),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Jenny",
                                          style: textStyleSemiBold.copyWith(
                                              color: white)),
                                      SizedBox(height: 3),
                                      i == 0
                                          ? Text("Assigned Work",
                                              style: textStyleSmall.copyWith(
                                                  color:
                                                      white.withOpacity(0.5)))
                                          : Row(
                                              children: [
                                                CustomImageView(
                                                    imagePath: icRating),
                                                SizedBox(width: 4),
                                                Text("4.2",
                                                    style:
                                                        textStyleSmallSemiBold
                                                            .copyWith(
                                                                color: gold))
                                              ],
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
