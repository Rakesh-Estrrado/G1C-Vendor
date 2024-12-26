import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/widgets/rateServiceBottomSheet.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/NoDataView.dart';
import 'package:g1c_vendor/utils/widgets/sliderWidget.dart';
import 'package:sizer/sizer.dart';

class ActiveBookings extends StatefulWidget {
   ActiveBookings({super.key});

  @override
  State<ActiveBookings> createState() => _ActiveBookingsState();
}

class _ActiveBookingsState extends State<ActiveBookings> {

  @override
  void initState() {
    handleRefresh();
    super.initState();
  }
  Future<void> handleRefresh() async{
    context.read<BookingsBloc>().getBookings("active", 1);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      color: red,
      backgroundColor: Colors.transparent,
      child: BlocBuilder<BookingsBloc, BookingsState>(builder: (context, state) {

        return !state.isLoading && state.activeBookingList.isEmpty
            ? NoDataView(msg: "No active bookings to show..")
            : Stack(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.activeBookingList.length,
                    itemBuilder: (context, i) {
                      var activeBooking = state.activeBookingList[i];
                      var time = calculateTimeDifference(
                              activeBooking.startTime, activeBooking.endTime)
                          .toString();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          color: darkBlue,
                          surfaceTintColor: darkBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomImageView(
                                      imagePath: activeBooking.image,
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
                                          Text("${activeBooking.serviceName}",
                                              style: textStyleRegularMedium),
                                          gradientContainer(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 12.0, vertical: 2.0),
                                              child: Text(
                                                  "RM ${activeBooking.price.toStringAsFixed(2)}",
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
                                            "${activeBooking.startTime.to12HourFormat()}, ${activeBooking.date.toDMMMY()}, $time",
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${activeBooking.venue}",
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
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                        imagePath:activeBooking.customerDetail.profileImage,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                        radius:
                                            BorderRadius.all(Radius.circular(100.0))),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${activeBooking.customerDetail.name}",
                                            style: textStyleSemiBold.copyWith(
                                                color: white)),
                                        Text("Customer",
                                            style: textStyleSmall.copyWith(
                                                color: white.withOpacity(0.5))),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: ()=>showSnackBar(context: context,msg: "under construction"),
                                      child: gradientContainer(
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
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SlideToCompleteWidget(
                                  completed: () {
                                    showReviewBottomSheet(
                                        context, activeBooking.bookingId);
                                  },
                                ),
                                /*i % 2 == 0
                                    ? SlideToCompleteWidget(
                                        completed: () {
                                          showReviewBottomSheet(context);
                                        },
                                      )
                                    : gradientContainer(
                                        child: SizedBox(
                                          width: 100.w,
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                              "Assign Worker",
                                              style: textStyleSemiBoldMedium,
                                            ),
                                          ),
                                        ),
                                      ),*/
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
      }),
    );
  }

  void showReviewBottomSheet(BuildContext mContext, int bookingId) {
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
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // To adjust for the keyboard
          ),
          child: BlocProvider(
            create: (context) => BookingsBloc(mContext),
            child: RateServiceBottomSheet(bookingId: bookingId),
          ),
        );
      },
    );
  }
}
