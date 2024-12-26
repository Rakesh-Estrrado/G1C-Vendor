import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/details/OpenBookingDetails.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/NoDataView.dart';

class OpenBookings extends StatefulWidget {
  const OpenBookings({super.key});

  @override
  State<OpenBookings> createState() => _OpenBookingsState();
}

class _OpenBookingsState extends State<OpenBookings> {
  @override
  void initState() {
    handleRefresh();
    super.initState();
  }

  Future<void> handleRefresh() async {
    context.read<BookingsBloc>().getBookings("open", 1);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      color: red,
      backgroundColor: Colors.transparent,
      child:
          BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {
        return !state.isLoading && state.openBookingList.isEmpty
            ? NoDataView(msg: "No open bookings to show..")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: state.openBookingList.length,
                itemBuilder: (context, i) {
                  var openBooking = state.openBookingList[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(
                            context: context,
                            destination: BlocProvider(
                              create: (context) => BookingsBloc(context),
                              child: OpenBookingDetails(
                                  bookingId: openBooking.bookingId),
                            ));

                        /*if (i % 2 == 0) {

                        } else {
                          navigateTo(
                              context: context, destination: NewSlotDetails());
                        }*/
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
                                    imagePath: openBooking.image,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                    radius: BorderRadius.all(
                                        Radius.circular(100.0)),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${openBooking.serviceName}",
                                            style: textStyleRegularMedium),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: cardRed,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 2.0),
                                            child: Text(
                                                "${formatTime(openBooking.acceptanceEndTime)}",
                                                style:
                                                    textStyleRegular.copyWith(
                                                        color: red,
                                                        fontSize: 14.sp)),
                                          ),
                                        )
                                      ]),
                                  const Spacer(),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(Icons.arrow_forward_ios_sharp,
                                            color: white, size: 12),
                                        const SizedBox(height: 6),
                                        gradientContainer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 2.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "RM ${openBooking.price.toStringAsFixed(2)}",
                                                    style: textStyleSemiBold
                                                        .copyWith(
                                                            fontSize: 14.sp)),
                                              ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${openBooking.startTime.to12HourFormat()}, ${openBooking.date.toDMMMY()}, ${openBooking.duration}",
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
                                    flex: 9,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${openBooking.venue}",
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
      }),
    );
  }
}
