import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class Summary extends StatelessWidget {
   Summary({super.key});

  final ValueNotifier<String> selectedRange =
  ValueNotifier("Custom Range");

  @override
  Widget build(BuildContext context) {
    final List<String> serviceTypes = ["Custom Range", "Electric Repairs"];
    return Background(child: Padding(padding: EdgeInsets.all(16.0),child: Column(
      children: [
        CustomAppBar2(title: "Summary"),
        SizedBox(height: 20),
        Container(
          decoration: semiCircleBox(color: darkBlue200, radius: 10),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              CommonDropDown(
                labelText: "",
                dropDownList: serviceTypes,
                showLabel :false,
                selectedValue: selectedRange,
                onSelected: (val){},
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: CommonTextField(
                          labelText: "From",
                          hintText: "dd/mm/yyyy",
                          suffixIcon: icCalendarText)),
                  SizedBox(width: 10),
                  Expanded(
                      child: CommonTextField(
                          labelText: "To",
                          hintText: "dd/mm/yyyy",
                          suffixIcon: icCalendarText)),
                ],
              ),

            ],

          ),
        ),

        const SizedBox(height: 36.0),
        Row(
          children: [
            Expanded(
                child: summaryCards(
                    cardPurple, icEarnings, "Earnings", "0")),
            const SizedBox(width: 16.0),
            Expanded(
                child: summaryCards(
                    cardOrange, icCardBookings, "Bookings", "0")),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
                child: summaryCards(
                    cardBlue, icCardService, "Upcoming Services", "0")),
            const SizedBox(width: 16.0),
            Expanded(
                child: summaryCards(
                    cardRed, icTodayService, "Today's Services", "0")),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    ),));
  }

   Widget summaryCards(Color color, String icon, String label, String count) {
     return SizedBox(
       height: 165,
       child: Card(
         color: color,
         surfaceTintColor: color,
         shape:
         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
         child: Padding(
           padding: const EdgeInsets.all(18.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomImageView(imagePath: icon, width: 30.sp, height: 30.sp),
               const SizedBox(height: 10),
               Text(label,
                   style: textStyleRegularMedium.copyWith(fontSize: 15.sp)),
               Text(count, style: textStyleRegularLarge),
             ],
           ),
         ),
       ),
     );
   }

}
