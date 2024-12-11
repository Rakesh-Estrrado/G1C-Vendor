import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/ui/workers/bloc/workers_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class WorkersPersonalDetails extends StatelessWidget {
  WorkersPersonalDetails({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => WorkersBloc(), child: WorkersPersonalDetails());
  }

  final List<String> tabs = ["Step 1", "Step 2", "Step 3"];
  final ValueNotifier<int> selectedTab = ValueNotifier(0);
  final ValueNotifier<String> selectedOption = ValueNotifier("Male");
  final scrollController = ScrollController();

  final dob = TextEditingController();
  final title = TextEditingController();
  final company = TextEditingController();
  final programName = TextEditingController();
  final university = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final hobbies = TextEditingController();
  final address = TextEditingController();

  final ValueNotifier<String> selectedDrinking = ValueNotifier("Occasionally");
  final ValueNotifier<String> selectedSmoking = ValueNotifier("Non-Smoker");
  final ValueNotifier<String> selectedReligion = ValueNotifier("Agnostic");
  final ValueNotifier<String> selectedLanguages = ValueNotifier("English");
  final ValueNotifier<String> selectedServiceCategory =
      ValueNotifier("Home Services - Cleaning\, Home Service");

  final List<String> drinkingList = ["Occasionally", "Regularly"];
  final List<String> smokingList = ["Non-Smoker", "Occasionally", "Regularly"];
  final List<String> religionList = ["Agnostic", "Muslim"];
  final List<String> languagesList = ["English", "Malayalam", "Tamil"];
  final List<String> serviceCategoryList = [
    "Home Services - Cleaning, Home Service",
    "Electric Repairs"
  ];

  @override
  Widget build(BuildContext context) {
    address.text =
        "No. 123, Jalan Example, Taman Sample, Kuching, Sarawak, Malaysia";
    return Background(
        child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar2(title: "Personal Details"),
          SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: semiCircleBox(color: darkBlue200, radius: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                      valueListenable: selectedOption,
                      builder: (context, child, val) {
                        return Row(
                          children: [
                            _buildRadioOption("Male"),
                            SizedBox(width: 20),
                            _buildRadioOption("Female")
                          ],
                        );
                      }),
                  SizedBox(height: 20),
                  CommonTextField(
                      labelText: "DOB",
                      hintText: "",
                      controller: dob,
                      suffixIcon: icCalendarText,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  Text("Job", style: textStyleRegular),
                  SizedBox(height: 10),

                  CommonTextField(
                      labelText: "Title",
                      hintText: "",
                      controller: title,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  CommonTextField(
                      labelText: "Company",
                      hintText: "",
                      controller: company,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  Text("Education", style: textStyleRegular),
                  SizedBox(height: 10),

                  CommonTextField(
                      labelText: "Program Name",
                      hintText: "",
                      controller: programName,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  CommonTextField(
                      labelText: "University",
                      hintText: "",
                      controller: university,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextField(
                            labelText: "Height",
                            hintText: "",
                            controller: height,
                            onChanged: (val) {}),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CommonTextField(
                            labelText: "Weight",
                            hintText: "",
                            controller: weight,
                            onChanged: (val) {}),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CommonDropDown(
                      labelText: "Drinking",
                      selectedValue: selectedDrinking,
                      dropDownList: drinkingList,
                    onSelected: (val){}),
                  SizedBox(height: 20),
                  CommonDropDown(
                      labelText: "Smoking",
                      selectedValue: selectedSmoking,
                      dropDownList: smokingList,onSelected: (val){}),
                  SizedBox(height: 20),
                  CommonDropDown(
                      labelText: "Religion",
                      selectedValue: selectedReligion,
                      dropDownList: religionList,onSelected: (val){}),
                  SizedBox(height: 20),
                  CommonDropDown(
                      labelText: "Languages",
                      selectedValue: selectedLanguages,
                      dropDownList: languagesList,onSelected: (val){}),
                  SizedBox(height: 20),
                  CommonTextField(
                      labelText: "Hobbies",
                      hintText: "",
                      controller: hobbies,
                      maxLines: 3,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  CommonDropDown(
                      labelText: "Service Category",
                      selectedValue: selectedServiceCategory,
                      dropDownList: serviceCategoryList,onSelected: (val){}),
                  SizedBox(height: 20),
                  CommonTextField(
                      labelText: "Address",
                      hintText: "",
                      isEditable: false,
                      maxLines: 2,
                      controller: address,
                      showBoarder: false,
                      onChanged: (val) {}),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(imagePath: icPDF, height: 32),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Scan.pdf", style: textStyleSmall),
                                  Text("3 mb", style: textStyleSmall),
                                ],
                              ),
                            ),
                            CustomImageView(imagePath: icDelete, height: 18),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  CommonButton(
                      label: "Update",
                      onTap: () {
                        showSnackBar(
                            context: context, msg: "Under Construction");
                      }),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }

  Widget _buildRadioOption(String option) {
    bool isSelected = selectedOption.value == option;
    return InkWell(
      onTap: () => selectedOption.value = option,
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
                    color: isSelected ? red : white,
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
}
