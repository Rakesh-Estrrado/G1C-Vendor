import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class NewSlotDetails extends StatelessWidget {
  const NewSlotDetails({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          Row(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("John Doe",
                                      style: textStyleRegularMedium),
                                  Text("Male, 24",
                                      style: textStyleRegular.copyWith(
                                          color: white.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Choose Time Slot", style: textStyleRegular),
                    SizedBox(height: 10),
                    timeSlots(),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: semiCircleBox(color: darkBlue200, radius: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer Preference", style: textStyleRegular),
                          SizedBox(height: 10),
                          Text("Kitchen | Dining Room",
                              style: textStyleRegularMedium),
                          Text("Rooms need to be cleaned",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          Text("Window Cleaning",
                              style: textStyleRegularMedium),
                          Text("Tasks that need special attention",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          Text("Antique Furniture",
                              style: textStyleRegularMedium),
                          Text("Items that need special care",
                              style: textStyleRegular.copyWith(
                                  color: white.withOpacity(0.5))),
                          SizedBox(height: 10),
                          SizedBox(width: 100.w),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    ActionButtonsRow(
                        onCancel: () => Navigator.pop(context),
                        onSubmit: () => Navigator.pop(context),
                        cancelText: "Decline",
                        submitText: "Accept"),
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

  Widget timeSlots() {
    List<String> timeSlots = [
      "09.00am",
      "10.00am",
      "11.00am",
      "12.00pm",
      "01.00pm",
      "02.00pm",
      "03.00pm",
      "04.00pm"
    ];
    ValueNotifier<String> selectedTimeSlot = ValueNotifier("10.00am");

    return ValueListenableBuilder(
        valueListenable: selectedTimeSlot,
        builder: (context, child, val) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 10,
              childAspectRatio: 1.9,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              String time = timeSlots[index];
              bool isSelected = selectedTimeSlot.value == time;
              return InkWell(
                onTap: () => selectedTimeSlot.value = time,
                child: Container(
                  alignment: Alignment.center,
                  decoration:isSelected?gradientDecor(): semiCircleBoxWithBorder(
                      color: darkBlue200, boarderWidth: 2),
                  child: Text(time, style: textStyleRegular),
                ),
              );
            },
          );
        });
  }
}
