import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class CompletedBookingDetails extends StatelessWidget {
  const CompletedBookingDetails({super.key});

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
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: semiCircleBox(color: darkBlue200, radius: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Clubbing Partner",
                                      style: textStyleRegularMedium),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: cardRed,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 2.0),
                                    child: Text("00:14:59",
                                        style: textStyleRegular.copyWith(
                                            color: red, fontSize: 14.sp)),
                                  ),
                                ],
                              ),
                              const Spacer(),
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
                              ),
                            ],
                          ),
                          Divider(color: black, height: 24),
                          Row(
                            children: [
                              CustomImageView(imagePath: icCalendar),
                              const SizedBox(width: 10),
                              Column(
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
                            children: [
                              CustomImageView(imagePath: icLocation),
                              const SizedBox(width: 10),
                              Column(
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
                              CustomImageView(imagePath: icNavigation),
                            ],
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: dummyImage,
                                        width: 40,
                                        height: 40,
                                        radius: const BorderRadius.all(
                                            Radius.circular(100.0)),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("John Doe",
                                              style: textStyleRegularMedium),
                                          i == 1
                                              ? Row(
                                                  children: [
                                                    CustomImageView(
                                                        imagePath: icRating),
                                                    SizedBox(width: 4),
                                                    Text("4.2",
                                                        style:
                                                            textStyleSmallSemiBold
                                                                .copyWith(
                                                                    color:
                                                                        gold))
                                                  ],
                                                )
                                              : Text("Male, 24",
                                                  style:
                                                      textStyleRegular.copyWith(
                                                          color:
                                                              white.withOpacity(
                                                                  0.5))),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
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
                          SizedBox(width: 100.w)
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
                          Container(
                              height: 1,
                              color: black,
                              margin: EdgeInsets.symmetric(vertical: 10)),
                          Row(
                            children: [
                              Text(
                                "SubTotal",
                                style: textStyleRegularMedium,
                              ),
                              Spacer(),
                              Text(
                                "RM 60.00",
                                style: textStyleRegularMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Discount",
                                style: textStyleRegularMedium,
                              ),
                              Spacer(),
                              Text(
                                "- RM 20.00",
                                style: textStyleRegularMedium,
                              ),
                            ],
                          ),
                          Container(
                              height: 1,
                              color: black,
                              margin: EdgeInsets.symmetric(vertical: 10)),
                          Row(
                            children: [
                              Text("Total", style: textStyleSemiBoldMedium),
                              Spacer(),
                              Text("- RM 20.00",
                                  style: textStyleSemiBoldMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox( height: 20),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration:
                      semiCircleBox(color: darkBlue200, radius: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer Review",
                              style: textStyleRegularMedium),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomImageView(
                                imagePath: dummyImage,
                                radius: BorderRadius.circular(100),
                                height: 40,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text("Jenny", style: textStyleSmallSemiBold),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min, // Set this to min to wrap content
                                    children: [
                                      CustomImageView(imagePath: icRating),
                                      Text("4.2", style: textStyleSmallSemiBold.copyWith(color: gold)),
                                      Container(width: 48.w),
                                      Text("2 days ago", style: textStyleSmall),
                                    ],
                                  )

                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Amazing Companion for Activities!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "I had a fantastic time hanging out with you! You’re super friendly, easy to talk to, and really fun to be around. Whether it’s grabbing a drink or watching a movie, you bring great energy and make the experience even better. We clicked instantly, and the conversation flowed effortlessly. I’d highly recommend you to anyone looking for a down-to-earth and fun person to share activities with. Looking forward to our next hangout!",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox( height: 20),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationBottomSheet(BuildContext context) {
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
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // To adjust for the keyboard
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: darkBlue,
                  border: Border.all(width: 2, color: darkBlue400),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text("Confirmation",
                              style: textStyleSemiBoldMedium)),
                      SizedBox(height: 10),
                      Center(
                          child: Text(
                        "Are you sure you want to accept and\nsend response to customer?",
                        style: textStyleRegular,
                        textAlign: TextAlign.center,
                      )),
                      SizedBox(height: 20),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("John Doe",
                                          style: textStyleRegularMedium),
                                      i == 1
                                          ? gradientContainer(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "RM 60/3 hrs",
                                                        style: textStyleSemiBold
                                                            .copyWith(
                                                                color: white,
                                                                fontSize: 13.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                decorationColor:
                                                                    white),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text("RM 60/3 hrs",
                                                          style: textStyleSemiBold
                                                              .copyWith(
                                                                  color: white,
                                                                  fontSize:
                                                                      13.sp)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Text("Male, 24",
                                              style: textStyleRegular.copyWith(
                                                  color:
                                                      white.withOpacity(0.5))),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CustomImageView(imagePath: icCalendar),
                          const SizedBox(width: 10),
                          Column(
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
                        children: [
                          CustomImageView(imagePath: icLocation),
                          const SizedBox(width: 10),
                          Column(
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
                          CustomImageView(imagePath: icNavigation),
                        ],
                      ),
                      SizedBox(height: 20),
                      ActionButtonsRow(
                        onCancel: () => Navigator.pop(context),
                        onSubmit: () {
                          Navigator.pop(context);
                        },
                        submitText: "Yes",
                        cancelText: "No",
                      ),
                      SizedBox(height: 10),
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
