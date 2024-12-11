import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/ui/workers/ManageWorkers.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class AddWorker extends StatelessWidget {
  AddWorker({super.key});

  final name = TextEditingController();
  final ValueNotifier<String> selectedGender = ValueNotifier("Male");
  final ValueNotifier<String> selectedService = ValueNotifier("Cleaning");
  final List<String> services = ["Cleaning", "Repairing"];
  final ValueNotifier<File> file = ValueNotifier(File(""));

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar2(title: "Add Worker"),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: semiCircleBox(color: darkBlue200, radius: 10),
            child: Column(
              children: [
                CommonTextField(labelText: "Name", controller: name),
                SizedBox(height: 16),
                ValueListenableBuilder(
                    valueListenable: selectedGender,
                    builder: (context, child, val) {
                      return Row(
                        children: [
                          _buildRadioOption("Male", selectedGender),
                          SizedBox(width: 20),
                          _buildRadioOption("Female", selectedGender)
                        ],
                      );
                    }),
                SizedBox(height: 16),
                Text("Staff Id", style: textStyleRegular),
                SizedBox(height: 5),
                Text("ST101", style: textStyleRegularMedium),
                SizedBox(height: 16),
                CommonDropDown(
                  labelText: "Services",
                  dropDownList: services,
                  selectedValue: selectedService,
                  onSelected: (val){},
                ),
                SizedBox(height: 16),
                uploadImage("Supporting Business Document"),
                SizedBox(height: 45.h),
                ActionButtonsRow(
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSubmit: () => navigateTo(context: context, destination: ManageWorkers()),
                    submitText: "Save")
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildRadioOption(String option, ValueNotifier selectedRadio) {
    bool isSelected = selectedRadio.value == option;
    return InkWell(
      onTap: () => selectedRadio.value = option,
      child: Row(
        children: [
          // Custom Radio Button
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Circle with Border
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? red : Colors.white,
                    width: 1.4,
                  ),
                ),
                child: Container(
                  // Inner Circle with Gradient Background
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [Color(0xFFE91775), Color(0xFFFD663B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : Colors.transparent,
                  ),
                  width: 9,
                  height: 9,
                ),
              ),
            ],
          ),

          SizedBox(width: 8),
          // Label Text
          Text(option, style: textStyleRegular),
        ],
      ),
    );
  }

  Widget uploadImage(String label, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label${isRequired ? ' *' : ''}', style: textStyleRegular),
        SizedBox(height: 8.0),
        // Input field
        Container(
          height: 100,
          decoration: semiCircleBoxWithBorder(color: darkBlue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(imagePath: icUploadImage, height: 22, width: 22),
              SizedBox(width: 8),
              Text("Upload Image",
                  style:
                      textStyleRegular.copyWith(color: white.withOpacity(0.6)))
            ],
          ),
        )
      ],
    );
  }
}