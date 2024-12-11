import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/image_constant.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/ActionButtonsRow.dart';
import '../../../../utils/widgets/CommonDropDown2.dart';
import '../../../../utils/widgets/CommonTextField.dart';
import '../../../widgets/custom_image_view.dart';
import '../bloc/profile_bloc.dart';
import '../model/language_list_model.dart';
import '../model/regional_list_model.dart';

class IndividualStep2 extends StatelessWidget {
  final ProfileBloc profileBloc;
  final RegionalListData? regionalListData;
  final LanguageListData? languageListData;

  IndividualStep2(
      {super.key,
      required this.profileBloc,
      this.regionalListData,
      this.languageListData});

  final List<String> drinkingList = ["Occasionally", "Regularly", "None"];
  final List<String> smokingList = ["Non-Smoker", "Occasionally", "Regularly"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: semiCircleBox(color: darkBlue200, radius: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocSelector<ProfileBloc, ProfileState, String?>(
              selector: (state) => state.selectedGender,
              builder: (context, selectedGender) {
                return Row(
                  children: [
                    _buildRadioOption("Male", selectedGender ?? ""),
                    SizedBox(width: 20),
                    _buildRadioOption("Female", selectedGender ?? "")
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
              selector: (state) => state.dobController,
               builder: (context, dobController) {
                return InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: dobController!.text.isEmpty
                                ? DateTime(1995)
                                : DateTime.tryParse(dobController!.text),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now())
                        .then((pickedDate) {
                      if (pickedDate == null) {
                        return;
                      }
                      dobController.text =
                          pickedDate.toIso8601String().toDD_MM_YYYY();
                    });
                  },
                  child: CommonTextField(
                      labelText: "DOB",
                      hintText: "dd/mm/yyyy",
                      isEditable: false,
                      controller: dobController,
                      suffixIcon: icCalendarText,
                      onChanged: (val) {}),
                );
              },
            ),
            SizedBox(height: 20),
            Text("Job", style: textStyleRegular),
            SizedBox(height: 10),
            BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
              selector: (state) => state.titleController,
              builder: (context, titleController) {
                return CommonTextField(
                    labelText: "Title",
                    hintText: "title",
                    controller: titleController,
                    onChanged: (val) {});
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
              selector: (state) => state.companyController,
              builder: (context, companyController) {
                return CommonTextField(
                    labelText: "Company",
                    hintText: "company",
                    controller: companyController,
                    onChanged: (val) {});
              },
            ),
            SizedBox(height: 20),
            Text("Education", style: textStyleRegular),
            SizedBox(height: 10),
            BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
              selector: (state) => state.programNameController,
              builder: (context, programNameController) {
                return CommonTextField(
                    labelText: "Program Name",
                    hintText: "program name",
                    controller: programNameController,
                    onChanged: (val) {});
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
              selector: (state) => state.universityController,
              builder: (context, universityController) {
                return CommonTextField(
                    labelText: "University",
                    hintText: "university",
                    controller: universityController,
                    onChanged: (val) {});
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: BlocSelector<ProfileBloc, ProfileState,
                      TextEditingController?>(
                    selector: (state) => state.heightController,
                    builder: (context, heightController) {
                      return CommonTextField(
                          labelText: "Height",
                          hintText: "height",
                          keyboardType: TextInputType.number,
                          controller: heightController,
                          onChanged: (val) {});
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: BlocSelector<ProfileBloc, ProfileState,
                      TextEditingController?>(
                    selector: (state) => state.weightController,
                    builder: (context, weightController) {
                      return CommonTextField(
                          labelText: "Weight",
                          hintText: "weight",
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          onChanged: (val) {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, String?>(
              selector: (state) => state.selectedDrinking,
              builder: (context, selectedDrinking) {
                return CommonDropDown2(
                  labelText: "Drinking",
                  dropDownList: drinkingList,
                  selectedValue: (val)=>profileBloc.selectDrinking(val),
                  showSelected: selectedDrinking??drinkingList[0],
                );
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, String?>(
              selector: (state) => state.selectedSmoking,
              builder: (context, selectedSmoking) {
                return CommonDropDown2(
                  labelText: "Smoking",
                  dropDownList: smokingList,
                  selectedValue: (val)=>profileBloc.selectSmoking(val),
                  showSelected: selectedSmoking ?? smokingList[0],
                );
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, String?>(
              selector: (state) => state.selectedReligion,
              builder: (context, selectedReligion) {
                List<String> religions =
                    regionalListData?.religions.values.toList() ?? [];

                return CommonDropDown2(
                  labelText: "Religion",
                  dropDownList: religions,
                  selectedValue: (val) {
                    String? selectedKey = regionalListData?.religions.entries.firstWhere((entry) => entry.value == val).key;
                    profileBloc.selectReligion(selectedKey??"",val);
                  },
                  showSelected: selectedReligion ?? religions[0],
                );
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, String?>(
              selector: (state) => state.selectedLanguages,
              builder: (context, selectedLanguages) {
                List<String> languages = languageListData?.languages.values.toList() ?? [];
                return CommonDropDown2(
                  labelText: "Languages",
                  dropDownList: languages,
                  selectedValue: (val) {
                    String? selectedKey = languageListData?.languages.entries.firstWhere((entry) => entry.value == val).key;
                    profileBloc.selectLanguage(selectedKey??"",val);
                  },
                  showSelected: selectedLanguages ?? languages[0],
                );
              },
            ),
            SizedBox(height: 20),
            BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
              selector: (state) => state.hobbiesController,
              builder: (context, hobbiesController) {
                return CommonTextField(
                    labelText: "Hobbies",
                    hintText: "hobbies",
                    controller: hobbiesController,
                    maxLines: 3,
                    onChanged: (val) {});
              },
            ),
            SizedBox(height: 24),
            ActionButtonsRow(
                cancelText: "Previous",
                submitText: "Next",
                onCancel: () => profileBloc.moveToPrevious(),
                onSubmit: () => profileBloc.validateAndMove()),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String option, String selectedRadio) {
    bool isSelected = selectedRadio == option;
    return InkWell(
      onTap: () => profileBloc..selectGenderOption(option),
      child: Row(
        children: [
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

  Widget uploadImage(String label, File? selectedFile, String type,
      {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label${isRequired ? ' *' : ''}', style: textStyleRegular),
        SizedBox(height: 8.0),
        Container(
          height: 100,
          width: 100.w,
          decoration: semiCircleBoxWithBorder(color: darkBlue),
          child: Stack(
            children: [
              selectedFile == null
                  ? InkWell(
                      onTap: () => showImagePicker(type),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                                imagePath: icUploadImage,
                                height: 22,
                                width: 22),
                            SizedBox(width: 8),
                            Text("Upload Image",
                                style: textStyleRegular.copyWith(
                                    color: white.withOpacity(0.6)))
                          ],
                        ),
                      ))
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(selectedFile),
                      ),
                    ),
              if (selectedFile != null)
                Positioned(
                  top: 5,
                  right: 15,
                  child: InkWell(
                      onTap: () => selectedFile = null,
                      child: CustomImageView(imagePath: icDelete)),
                ),
            ],
          ),
        )
      ],
    );
  }
}
