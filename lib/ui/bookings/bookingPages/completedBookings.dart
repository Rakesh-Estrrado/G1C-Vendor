import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/details/CompletedBookingDetails.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/widgets/NoDataView.dart';

class CompletedBookings extends StatefulWidget {
  const CompletedBookings({super.key});

  @override
  State<CompletedBookings> createState() => _CompletedBookingsState();
}

class _CompletedBookingsState extends State<CompletedBookings> {
  @override
  void initState() {
    handleRefresh();
    super.initState();
  }

  Future<void> handleRefresh() async{
    context.read<BookingsBloc>().getBookings("completed", 1);
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      color: red,
      backgroundColor: Colors.transparent,
      child: BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {
        return !state.isLoading && state.completedBookingList.isEmpty
            ? NoDataView(msg: "No completed bookings to show..")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: state.completedBookingList.length,
                itemBuilder: (context, i) {
                  var completedBooking = state.completedBookingList[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(
                            context: context,
                            destination: BlocProvider(
                              create: (context) => BookingsBloc(context),
                              child: CompletedBookingDetails(
                                  bookingId: completedBooking.bookingId),
                            ));
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
                                    imagePath: completedBooking.image,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                    radius: const BorderRadius.all(
                                        Radius.circular(100.0)),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${completedBooking.serviceName}",
                                            style: textStyleRegularMedium),
                                        gradientContainer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 2.0),
                                            child: Text(
                                                "RM ${completedBooking.price.round().toStringAsFixed(2)}",
                                                style: textStyleSemiBold.copyWith(
                                                    fontSize: 14.sp)),
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
                                      Text(
                                          "${completedBooking.startTime.to12HourFormat()}, ${completedBooking.date.toDMMMY()}, ${completedBooking.duration}",
                                          style: textStyleSemiBold.copyWith(
                                              color: white)),
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
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${completedBooking.venue}",
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
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(width: 3),
                                          CustomImageView(
                                              imagePath: completedBooking
                                                  .customerDetail.profileImage,
                                              height: 40,
                                              width: 40,
                                              fit: BoxFit.cover,
                                              radius: const BorderRadius.all(
                                                  Radius.circular(100.0))),
                                          const SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${completedBooking.customerDetail.name}",
                                                  style: textStyleSemiBold
                                                      .copyWith(color: white)),
                                              SizedBox(height: 3),
                                              i == 1
                                                  ? Text("Assigned Work",
                                                      style:
                                                          textStyleSmall.copyWith(
                                                              color: white
                                                                  .withOpacity(
                                                                      0.5)))
                                                  : Row(
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
      }),
    );
  }
}
