import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class CompletedBookingDetails extends StatelessWidget {
  final int bookingId;

  const CompletedBookingDetails({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    context.read<BookingsBloc>().getBookingDetails("completed", bookingId);
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
                    if (state.allBookingDetails == null) return SizedBox();
                    var booking = state.allBookingDetails;
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration:
                              semiCircleBox(color: darkBlue200, radius: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomImageView(
                                    imagePath: booking?.bookingsDetail.image,
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
                                          "${booking?.bookingsDetail.serviceName}",
                                          style: textStyleRegularMedium),
                                      Text(
                                          "${booking?.bookingsDetail.orderId}",
                                          style: textStyleRegular.copyWith(
                                              color: white.withOpacity(0.7))),
                                    ],
                                  ),
                                  const Spacer(),
                                  gradientContainer(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Center(
                                        child: Text(
                                            "RM ${booking?.bookingsDetail.price.toStringAsFixed(2)}",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${booking?.bookingsDetail.startTime.to12HourFormat()}, ${booking?.bookingsDetail.date.toDMMMY()}, ${booking?.bookingsDetail.duration}",
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
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${booking?.bookingsDetail.venue}",
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
                              SizedBox(height: 10),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        children: [
                                          CustomImageView(
                                            imagePath: booking
                                                ?.customerDetail.profileImage,
                                            width: 40,
                                            height: 40,
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
                                                  "${booking?.customerDetail.name}",
                                                  style:
                                                      textStyleRegularMedium),
                                              i == 0
                                                  ? Row(
                                                      children: [
                                                        CustomImageView(
                                                            imagePath:
                                                                icRating),
                                                        SizedBox(width: 4),
                                                        Text("4.2",
                                                            style:
                                                                textStyleSmallSemiBold
                                                                    .copyWith(
                                                                        color:
                                                                            gold))
                                                      ],
                                                    )
                                                  : Text(
                                                      "${booking?.customerDetail.gender}, ${booking?.customerDetail.age}",
                                                      style: textStyleRegular
                                                          .copyWith(
                                                              color: white
                                                                  .withOpacity(
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
                        /*Container(
                          padding: EdgeInsets.all(16),
                          decoration:
                              semiCircleBox(color: darkBlue200, radius: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Customer Preference",
                                  style: textStyleRegular),
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
                              Text("Casual Dress",
                                  style: textStyleRegularMedium),
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
                        ),*/
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration:
                              semiCircleBox(color: darkBlue200, radius: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bill Summary",
                                  style: textStyleSemiBoldMedium),
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
                                    "RM ${booking?.billingSummary.subtotal.toStringAsFixed(2)}",
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
                                    "- RM 0.00",
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
                                  Text(
                                      " RM ${booking?.billingSummary.total.toStringAsFixed(2)}",
                                      style: textStyleSemiBoldMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
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
                                    imagePath:
                                        booking?.customerDetail.profileImage,
                                    radius: BorderRadius.circular(100),
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${booking?.customerDetail.name}",
                                          style: textStyleSmallSemiBold),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        // Set this to min to wrap content
                                        children: [
                                          CustomImageView(imagePath: icRating),
                                          Text("4.2",
                                              style: textStyleSmallSemiBold
                                                  .copyWith(color: gold)),
                                          Container(width: 48.w),
                                          Text("2 days ago",
                                              style: textStyleSmall),
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
                                "Good",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
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
}
