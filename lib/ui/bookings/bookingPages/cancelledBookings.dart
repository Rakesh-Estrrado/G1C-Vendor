import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/details/CancelOrCompleteBooking.dart';
import 'package:g1c_vendor/ui/bookings/details/CancelledBookingDetails.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/NoDataView.dart';

class CancelledBookings extends StatefulWidget {
  const CancelledBookings({super.key});

  @override
  State<CancelledBookings> createState() => _CancelledBookingsState();
}

class _CancelledBookingsState extends State<CancelledBookings> {
  @override
  void initState() {
    handleRefresh();
    super.initState();
  }

  Future<void> handleRefresh() async{
    context.read<BookingsBloc>().getBookings("cancelled", 1);
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: handleRefresh,
      color: red,
      backgroundColor: Colors.transparent,
      child: BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {
        return !state.isLoading && state.cancelledBookingList.isEmpty
            ? NoDataView(msg: "No cancelled bookings to show..")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: state.cancelledBookingList.length,
                itemBuilder: (context, i) {
                  var cancelledBooking = state.cancelledBookingList[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        if (i == 1) {
                          navigateTo(
                              context: context,
                              destination: CancelOrCompleteBooking());
                        } else {
                          navigateTo(
                              context: context,
                              destination: BlocProvider(
                                create: (context) => BookingsBloc(context),
                                child: CancelledBookingDetails(
                                  bookingId: cancelledBooking.bookingId
                                ),
                              ));
                        }
                      },
                      child: Card(
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
                                    imagePath: cancelledBooking.image,
                                    width: 55,
                                    height: 55,
                                    radius: const BorderRadius.all(
                                        Radius.circular(100.0)),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${cancelledBooking.serviceName}",
                                            style: textStyleRegularMedium),
                                        gradientContainer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 2.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "RM ${cancelledBooking.price.toStringAsFixed(2)}",
                                                    style: textStyleSemiBold
                                                        .copyWith(
                                                            fontSize: 14.sp)),
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
                                        color: cardRed, radius: 4.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
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
                                      Text(
                                          "${cancelledBooking.startTime.to12HourFormat()}, ${cancelledBooking.date.toDMMMY()}, ${cancelledBooking.duration}",
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
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${cancelledBooking.venue}",
                                            style: textStyleSemiBold.copyWith(
                                                color: white)),
                                        Text("Venue",
                                            style: textStyleSmall.copyWith(
                                                color: white.withOpacity(0.5))),
                                      ],
                                    ),
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
      }),
    );
  }
}
