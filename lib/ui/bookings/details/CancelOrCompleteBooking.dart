import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/bookings/widgets/rateServiceBottomSheet.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:g1c_vendor/utils/widgets/sliderWidget.dart';
import 'package:sizer/sizer.dart';

class CancelOrCompleteBooking extends StatelessWidget {
  const CancelOrCompleteBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar2(title: "Booking Details"),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
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
                                  radius: const BorderRadius.all(
                                      Radius.circular(100.0)),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                                  style: textStyleSemiBold
                                                      .copyWith(
                                                      color: white,
                                                      fontSize: 14.sp,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                      white)),
                                              Text("  RM 120.00",
                                                  style: textStyleSemiBold
                                                      .copyWith(
                                                      color: white,
                                                      fontSize: 14.sp)),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Status",
                                    style: textStyleSemiBold.copyWith(
                                        color: white)),
                                const Spacer(),
                                Container(
                                  decoration: semiCircleBox(
                                      color: cardOrange, radius: 4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text("Waiting for payment",
                                        style: textStyleSmall.copyWith(
                                            color: orange)),
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
                                CustomImageView(
                                  imagePath: icNavigation,
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomImageView(
                                    imagePath: dummyImage,
                                    height: 30,
                                    width: 30,
                                    radius: BorderRadius.all(
                                        Radius.circular(100.0))),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Jenny",
                                        style: textStyleSemiBold.copyWith(
                                            color: white)),
                                    Text("Customer",
                                        style: textStyleSmall.copyWith(
                                            color: white.withOpacity(0.5))),
                                  ],
                                ),
                                const Spacer(),
                                gradientContainer(
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 2.0),
                                      child: Row(
                                        children: [
                                          CustomImageView(imagePath: icChat),
                                          const SizedBox(width: 8),
                                          Text("Chat", style: textStyleSemiBold)
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 20),
                            SlideToCompleteWidget(
                              completed: () {
                                showReviewBottomSheet(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: semiCircleBox(color: darkBlue200, radius: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer Preference", style: textStyleRegular),
                          SizedBox(height: 10),
                          Text("Dance club", style: textStyleRegularMedium),
                          Text("Clubbing Experience",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          Text("EDM, Hip-hop, Pop",
                              style: textStyleRegularMedium),
                          Text("Music Genres",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          Text("Casual Dress", style: textStyleRegularMedium),
                          Text("Dress Code",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          Text("Whisky, Beer, Cocktails",
                              style: textStyleRegularMedium),
                          Text("Preferred Drinks",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          Text("Halal", style: textStyleRegularMedium),
                          Text("Dietary Preferences",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),

                          SizedBox(width: 100.w),

                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: semiCircleBox(color: darkBlue200, radius: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bill Summary", style: textStyleSemiBoldMedium),
                          Container(height: 1, color: black, margin: EdgeInsets
                              .symmetric(vertical: 10)),
                          Row(
                            children: [
                              Text("SubTotal", style: textStyleRegularMedium,),
                              Spacer(),
                              Text("RM 60.00", style: textStyleRegularMedium,),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Discount", style: textStyleRegularMedium,),
                              Spacer(),
                              Text(
                                "- RM 20.00", style: textStyleRegularMedium,),
                            ],
                          ),
                          Container(height: 1, color: black, margin: EdgeInsets
                              .symmetric(vertical: 10)),
                          Row(
                            children: [
                              Text("Total", style: textStyleSemiBoldMedium),
                              Spacer(),
                              Text(
                                  "- RM 20.00", style: textStyleSemiBoldMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    CommonButton(
                      onTap: () => Navigator.pop(context),
                      label: "Cancel",
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showReviewBottomSheet(BuildContext mContext) {
    showModalBottomSheet(
      context: mContext,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom, // To adjust for the keyboard
          ),
          child:  RateServiceBottomSheet(bookingId: 0),

        );
      },
    );
  }
}