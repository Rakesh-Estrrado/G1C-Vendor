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

class NewBookingDetails extends StatelessWidget {
  final int bookingId;

  const NewBookingDetails({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    context.read<BookingsBloc>()..getBookingDetails("new", bookingId);

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
                    if (allBookingDetails != null) {
                      calculateTimeDifference(allBookingDetails.bookingsDetail.startTime, allBookingDetails.bookingsDetail.endTime).toString();
                    }

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
                                              child: Text(
                                                  "${allBookingDetails.bookingsDetail.duration}",
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
                                              child: Text(
                                                  "RM ${allBookingDetails.bookingsDetail.price.toStringAsFixed(2)}",
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
                              customerDetailsBloc(
                                  allBookingDetails.customerDetail, context),
                              SizedBox(height: 70),
                              ActionButtonsRow(
                                onCancel: () {
                                  context
                                      .read<BookingsBloc>()
                                      .acceptRejectRequest(
                                          bookingId, "decline");
                                },
                                onSubmit: () {
                                  showConfirmationBottomSheet(
                                      context, allBookingDetails);
                                },
                                submitText: "Accept",
                                cancelText: "Decline",
                              ),
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

  void showConfirmationBottomSheet(
      BuildContext mContext, AllBookingDetails allBookingDetails) {
    var customerDetails = allBookingDetails.customerDetail;
    showModalBottomSheet(
      context: mContext,
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
                          itemCount: 1,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  CustomImageView(
                                    imagePath: customerDetails.profileImage,
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
                                      Text("${customerDetails.name}",
                                          style: textStyleRegularMedium),
                                      /*i == 1
                                          ? gradientContainer(
                                              child: Text("RM 60/3 hrs",
                                                  style: textStyleSemiBold
                                                      .copyWith(
                                                          color: white,
                                                          fontSize:
                                                              13.sp)),
                                            )
                                          : */
                                      Text(
                                          "${customerDetails.gender}, ${customerDetails.age}",
                                          style: textStyleRegular.copyWith(
                                              color: white.withOpacity(0.5))),
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
                              Text(
                                  "${allBookingDetails.bookingsDetail.startTime.to12HourFormat()}, ${allBookingDetails.bookingsDetail.date.toDMMMY()}, ${allBookingDetails.bookingsDetail.duration}",
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
                          Expanded(
                            flex: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${allBookingDetails.bookingsDetail.venue}",
                                    style: textStyleSemiBold.copyWith(
                                        color: white)),
                                Text("Venue",
                                    style: textStyleSmall.copyWith(
                                        color: white.withOpacity(0.5))),
                              ],
                            ),
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
                          mContext
                              .read<BookingsBloc>()
                              .acceptRejectRequest(bookingId, "accept");
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

  Widget customerDetailsBloc(
      CustomerDetail customerDetail, BuildContext context) {
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
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    radius: const BorderRadius.all(Radius.circular(100.0)),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${customerDetail.name}",
                          style: textStyleRegularMedium),
                      Text(
                          "${customerDetail.gender}, ${customerDetail.birthday}",
                          style: textStyleRegular.copyWith(
                              color: white.withOpacity(0.5))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        customerDetail.preference.isEmpty
            ? SizedBox()
            : Container(
                padding: EdgeInsets.all(16),
                decoration: semiCircleBox(color: darkBlue200, radius: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Customer Preference", style: textStyleRegular),
                    SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: customerDetail.preference.length,
                        itemBuilder: (context, i) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Dance club", style: textStyleRegularMedium),
                              Text("Clubbing Experience",
                                  style: textStyleRegular.copyWith(
                                      color: white.withOpacity(0.5))),
                              SizedBox(height: 10),
                            ],
                          );
                        }),
                  ],
                ),
              ),
      ],
    );
  }
}
