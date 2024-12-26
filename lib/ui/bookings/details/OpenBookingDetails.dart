import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/model/booking_detail_model.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class OpenBookingDetails extends StatelessWidget {
  final int bookingId;

  const OpenBookingDetails({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    context.read<BookingsBloc>().getBookingDetails("open", bookingId);
    return Background(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar2(title: "Booking Details"),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<BookingsBloc, BookingsState>(
                  builder: (context, state) {
                    var allBookingDetails = state.allBookingDetails;

                    return allBookingDetails == null
                        ? SizedBox()
                        : Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: semiCircleBox(
                                    color: darkBlue200, radius: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: allBookingDetails
                                              .bookingsDetail.image,
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                          radius: const BorderRadius.all(
                                              Radius.circular(100.0)),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${allBookingDetails.bookingsDetail.serviceName}",
                                                style: textStyleRegularMedium),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: cardRed,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 2.0),
                                              child: Text("00:14:59",
                                                  style:
                                                      textStyleRegular.copyWith(
                                                          color: red,
                                                          fontSize: 14.sp)),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        gradientContainer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Center(
                                              child: Text("RM ${allBookingDetails.bookingsDetail.price.toStringAsFixed(2)}",
                                                  style: textStyleSemiBold
                                                      .copyWith(
                                                          color: white,
                                                          fontSize: 14.sp)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: black, height: 24),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        CustomImageView(imagePath: icCalendar),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${allBookingDetails.bookingsDetail.startTime.to12HourFormat()}, ${allBookingDetails.bookingsDetail.date.toDMMMY()}, ${allBookingDetails.bookingsDetail.duration}",
                                                style: textStyleSemiBold
                                                    .copyWith(color: white)),
                                            Text("Schedule",
                                                style: textStyleSmall.copyWith(
                                                    color: white
                                                        .withOpacity(0.5))),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        CustomImageView(imagePath: icLocation),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          flex: 9,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${allBookingDetails.bookingsDetail.venue}",
                                                  style: textStyleSemiBold
                                                      .copyWith(color: white)),
                                              Text("Venue",
                                                  style:
                                                      textStyleSmall.copyWith(
                                                          color:
                                                              white.withOpacity(
                                                                  0.5))),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        CustomImageView(
                                            imagePath: icNavigation),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              customerAnaPreferencesBloc(
                                  allBookingDetails.customerDetail),
                              SizedBox(height: 20),
                              billSummaryBloc(allBookingDetails.billingSummary),
                              SizedBox(height: 20),
                            ],
                          );
                  },
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

  Widget customerAnaPreferencesBloc(CustomerDetail customerDetail) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: semiCircleBox(color: darkBlue200, radius: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Customer", style: textStyleRegular),
              SizedBox(height: 10),
              Row(
                children: [
                  CustomImageView(
                    imagePath: customerDetail.profileImage,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                    radius: const BorderRadius.all(Radius.circular(100.0)),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${customerDetail.name}",
                          style: textStyleRegularMedium),
                      Text("${customerDetail.gender}, ${customerDetail.age}",
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
        customerDetail.preference.isEmpty?SizedBox():Container(
          padding: EdgeInsets.all(16),
          decoration: semiCircleBox(color: darkBlue200, radius: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer Preference", style: textStyleRegular),
              SizedBox(height: 10),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: customerDetail.preference.length,
                itemBuilder: (context, i) {
                  var parentPreference = customerDetail.preference[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${parentPreference.name}",
                        style: textStyleRegular.copyWith(fontSize: 15.sp),
                      ),
                      SizedBox(height: 5),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: parentPreference.values
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          var preferenceValue = entry.value;
                          return preferenceValue.checked
                              ? Text(
                                  "${index == 0 ? "" : "| "} ${preferenceValue.value}",
                                  style: textStyleSemiBold,
                                  textAlign: TextAlign.center,
                                )
                              : SizedBox();
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget billSummaryBloc(BillingSummary billingSummary) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: semiCircleBox(
          color: darkBlue200, radius: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bill Summary",
              style: textStyleSemiBoldMedium),
          Container(
              height: 1,
              color: black,
              margin:
              EdgeInsets.symmetric(vertical: 10)),
          Row(
            children: [
              Text(
                "SubTotal",
                style: textStyleRegularMedium,
              ),
              Spacer(),
              Text(
                "RM ${billingSummary.subtotal.toStringAsFixed(2)}",
                style: textStyleRegularMedium,
              ),
            ],
          ),
         /* SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Discount",
                style: textStyleRegularMedium,
              ),
              Spacer(),
              Text(
                "- RM ${billingSummary.discount.toStringAsFixed(2)}",
                style: textStyleRegularMedium,
              ),
            ],
          ),*/
          Container(
              height: 1,
              color: black,
              margin:
              EdgeInsets.symmetric(vertical: 10)),
          Row(
            children: [
              Text("Total",
                  style: textStyleSemiBoldMedium),
              Spacer(),
              Text("RM ${billingSummary.total.toStringAsFixed(2)}",
                  style: textStyleSemiBoldMedium),
            ],
          ),
        ],
      ),
    );
  }
}
