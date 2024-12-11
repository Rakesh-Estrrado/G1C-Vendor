import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/earnings/bloc/earnings_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/NoDataView.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class Earnings extends StatelessWidget {
  const Earnings({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => EarningsBloc(context), child: Earnings());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar2(title: "Earnings",showMenuIcons: true),
          SizedBox(height: 10),
          true?Container(margin: EdgeInsets.only(top: 40.h),child: NoDataView(msg: "No Earnings Yet..")):Expanded(
            child: Column(
              children: [
                Container(
                  decoration: semiCircleBox(color: darkBlue, radius: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                  ),
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    CustomImageView(imagePath: earningsCard, width: 100.w),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Total", style: textStyleSemiBoldMedium),
                          Text("RM 2000.00", style: textStyleBoldLarge),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: semiCircleBox(color: darkBlue200, radius: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("#BK123", style: textStyleSmall),
                                  Spacer(),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2.0),
                                      decoration: semiCircleBox(
                                          color: switchGreen.withOpacity(0.5),
                                          radius: 4),
                                      child: Text("Paid",
                                          style: textStyleSmall.copyWith(
                                              color: switchGreen))),
                                ],
                              ),
                              Text("John Doe", style: textStyleRegularMedium),
                              Row(
                                children: [
                                  Text("Deep Cleaning", style: textStyleSmall),
                                  Spacer(),
                                  SizedBox(
                                      width: 100,
                                      child: gradientContainer(
                                          height: 24,
                                          child: Center(
                                              child: Text("RM 120.00",
                                                  style: textStyleSemiBold)))),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
