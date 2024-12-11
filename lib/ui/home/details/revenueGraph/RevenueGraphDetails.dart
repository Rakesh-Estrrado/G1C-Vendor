import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/home/home_screen.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class RevenueGraphDetails extends StatelessWidget {
  RevenueGraphDetails({super.key});

  final ValueNotifier<String> selectedRange = ValueNotifier("Custom Range");

  @override
  Widget build(BuildContext context) {
    final List<String> serviceTypes = ["Custom Range", "Electric Repairs"];
    return Background(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar2(title: "Revenue Graph"),
          SizedBox(height: 20),
          Container(
            decoration: semiCircleBox(color: darkBlue200, radius: 10),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                CommonDropDown(
                  labelText: "",
                  dropDownList: serviceTypes,
                  showLabel: false,
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
          const SizedBox(height: 36),
          Card(
              elevation: 2,
              color: darkBlue200,
              surfaceTintColor: darkBlue200,
              shape: cardShape,
              child: Container(
                height: 260,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: RevenueGraph(),
              )),
        ],
      ),
    ));
  }
}