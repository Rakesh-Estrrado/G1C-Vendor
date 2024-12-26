import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';

import '../bloc/bookings_bloc.dart';

class RateServiceBottomSheet extends StatefulWidget {
  RateServiceBottomSheet({super.key, required this.bookingId});

  final int bookingId;

  @override
  State<RateServiceBottomSheet> createState() => _RateServiceBottomSheetState();
}

class _RateServiceBottomSheetState extends State<RateServiceBottomSheet> {
  var ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bookingBloc = context.read<BookingsBloc>();
    List<String> selectedStars = [star1, star2, star3, star4, star5];
    List<String> unSelectedStars = [stara, starb, starc, stard, stare];
    ValueNotifier<int> selectedStar = ValueNotifier(2);
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          border: Border.all(width: 2, color: borderBlue)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Confirm Service Completion",
            style: textStyleSemiBoldMedium,
          ),
          const SizedBox(height: 10),
          Text(
            "Are you sure you want to complete this service? Please rate your experience "
            "and submit your review to finalize the service.",
            textAlign: TextAlign.center,
            style: textStyleRegular,
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
              valueListenable: selectedStar,
              builder: (context, val, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                          onTap: () => selectedStar.value = index,
                          child: CustomImageView(
                            imagePath: selectedStar.value == index
                                ? selectedStars[index]
                                : unSelectedStars[index],
                            height: 50,
                          )),
                    );
                  }),
                );
              }),
          const SizedBox(height: 20),
          TextField(
            controller: ratingController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Enter here...",
              fillColor: darkBlue,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    BorderSide(width: 2, color: borderBlue), // Custom border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    width: 2, color: borderBlue), // Custom border when focused
              ),
            ),
            style: textStyleSemiBold,
          ),
          const SizedBox(height: 15),
          Text(
            "*Review is required for completing the process",
            style: textStyleSmall.copyWith(color: white.withOpacity(0.5)),
          ),
          const SizedBox(height: 24),
          ActionButtonsRow(
              onCancel: () => Navigator.pop(context),
              onSubmit: () {
                bookingBloc.completeBooking(widget.bookingId,
                    ratingController.text, selectedStar.value);
              })
        ],
      ),
    );
  }
}
