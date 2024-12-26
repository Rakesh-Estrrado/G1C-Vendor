import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/details/NewBookingDetails.dart';
import 'package:g1c_vendor/ui/bookings/serviceExtension/ServiceExtension.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/NoDataView.dart';
import 'package:sizer/sizer.dart';

class NewBookings extends StatefulWidget {
  const NewBookings({super.key});

  @override
  State<NewBookings> createState() => _NewBookingsState();
}

class _NewBookingsState extends State<NewBookings> {
  var scrollController = ScrollController();
  Timer? countdownTimer;

  @override
  void initState() {
    context.read<BookingsBloc>().getBookings("new", 1);
    super.initState();
  }

  Future<void> handleRefresh() async{
    context.read<BookingsBloc>().getBookings("new", 1);
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      color: red,
      backgroundColor: Colors.transparent,

      child: BlocBuilder<BookingsBloc, BookingsState>(
        builder: (context, state) {
          if (state.isLoading) return SizedBox();
          if (!state.isLoading && state.newBookingList.isEmpty)
            return NoDataView(msg: "No new bookings.");
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.newBookingList.length,
              itemBuilder: (context, i) {
                var newBooking = state.newBookingList[i];
                var time = calculateTimeDifference(
                        newBooking.startTime, newBooking.endTime)
                    .toString();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: darkBlue200,
                    surfaceTintColor: darkBlue200,
                    child: InkWell(
                      onTap: () {
                        if (i == 1) {
                          showServiceEndingBottomSheet(context);
                        } else {
                          navigateTo(
                              context: context,
                              destination: BlocProvider(
                                create: (context) => BookingsBloc(context),
                                child: NewBookingDetails(
                                    bookingId: newBooking.bookingId),
                              ),
                              updated: (val) {
                                if (val == "requestUpdated") {
                                  context
                                      .read<BookingsBloc>()
                                      .getBookings("new", 1);
                                }
                              });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: newBooking.image,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                  radius: const BorderRadius.all(
                                      Radius.circular(100.0)),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${newBooking.serviceName}",
                                          style: textStyleRegularMedium),
                                      Text("${newBooking.orderId}",
                                          style: textStyleSmall.copyWith(
                                              color: white.withOpacity(0.5))),
                                      SizedBox(height: 4),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: cardRed,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 2.0),
                                            child: Text(
                                                "${formatTime(newBooking.acceptanceEndTime)}",
                                                style: textStyleRegular.copyWith(
                                                    color: red,
                                                    fontSize: 14.sp))),
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
                                            child: Text(
                                                "RM ${newBooking.price.toStringAsFixed(2)}",
                                                style: textStyleSemiBold.copyWith(
                                                    color: white,
                                                    fontSize: 14.sp)),
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
                                    Text(
                                        "${newBooking.startTime.to12HourFormat()}, ${newBooking.date.toDMMMY()}, $time",
                                        style: textStyleSemiBold.copyWith(
                                            color: white)),
                                    Text("Schedule",
                                        style: textStyleSmall.copyWith(
                                            color: white.withOpacity(0.5)))
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
                                  flex: 9,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${newBooking.venue}",
                                          style: textStyleSemiBold.copyWith(
                                              color: white),
                                          maxLines: 2),
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
        },
      ),
    );
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                  border: Border.all(width: 2, color: borderBlue)),
              child: Column(
                children: [
                  Text("Service Ending Soon", style: textStyleSemiBoldMedium),
                  SizedBox(height: 10),
                  Text(
                    "You have 10 minutes remaining before the\nscheduled service ends. Please wrap up\nany remaining tasks and ensure everything\nis in order. If you need more time, contact the customer.",
                    style: textStyleRegular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                      label: "OK",
                      onTap: () {
                        Navigator.pop(context);

                        navigateTo(
                            context: context, destination: ServiceExtension());
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
