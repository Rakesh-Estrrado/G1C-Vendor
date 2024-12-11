import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/image_constant.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/CommonButton.dart';
import '../../../../utils/widgets/CommonDropDown2.dart';
import '../../../../utils/widgets/CommonTextField.dart';
import '../../../widgets/custom_image_view.dart';
import '../bloc/profile_bloc.dart';
import '../model/service_categories_model.dart';

class BusinessStep1 extends StatelessWidget {
  final ServiceCategoriesData? serviceCategoriesList;
  final ProfileBloc profileBloc;

  const BusinessStep1({super.key, this.serviceCategoriesList, required this.profileBloc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) =>
              previous.selectedOption != current.selectedOption,
          builder: (context, state) {
            return Row(
              children: [
                _buildRadioOption(
                    "Business", state.selectedOption.toString(), context),
                SizedBox(width: 10),
                _buildRadioOption(
                    "Individual", state.selectedOption.toString(), context)
              ],
            );
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.businessNameController,
          builder: (context, businessNameController) {
            return CommonTextField(
                labelText: "Business Name",
                hintText: "Business Name",
                controller: businessNameController,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.registrationNumberController,
          builder: (context, registrationNumberController) {
            return CommonTextField(
                labelText: "Registration Number.",
                hintText: "Registration Number",
                controller: registrationNumberController,
                isRequired: true,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, File?>(
          selector: (state) => state.logo,
          builder: (context, logo) {
            return uploadImage("Upload Logo", logo, "logo" );
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.directorNameController,
          builder: (context, directorNameController) {
            return CommonTextField(
                labelText: "Director Name",
                hintText: "Director Name",
                controller: directorNameController,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        
        BlocSelector<ProfileBloc, ProfileState, File?>(
        selector: (state) => state.avatar,
        builder: (context, avatar) {
            return uploadImage("Upload Profile Pic",avatar, "avatar");
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.emailController,
          builder: (context, emailController) {
            return CommonTextField(
                labelText: "Email",
                hintText: "Email",
                controller: emailController,
                keyboardType: TextInputType.text,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.phoneNoController,
          builder: (context, phoneNoController) {
            return CommonTextField(
                labelText: "Phone Number",
                hintText: "Phone Number",
                controller: phoneNoController,
                onChanged: (val) {});

          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, String?>(
          selector: (state) => state.selectedServiceType,
          builder: (context, selectedServiceCategory) {
            List<String> serviceTypes = serviceCategoriesList?.categories.values.toList() ?? [];
            serviceTypes.remove("Lifestyle");
            return CommonDropDown2(
              labelText: "Service Category",
              dropDownList: serviceTypes,
              selectedValue: (val){
                String? selectedKey = serviceCategoriesList?.categories.entries.firstWhere((entry) => entry.value == val).key;
                profileBloc.selectServiceType(selectedKey??"",val);
              },
              showSelected: selectedServiceCategory == null ||
                      selectedServiceCategory.isEmpty
                  ? serviceTypes.isEmpty?"":serviceTypes[0]
                  : selectedServiceCategory,
            );
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.descriptionController,
          builder: (context, descriptionController) {
            return CommonTextField(
                labelText: "Description",
                hintText: "Description",
                controller: descriptionController,
                maxLines: 3,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: 120,
            child: CommonButton(
              onTap: () => context.read<ProfileBloc>().validateAndMove(),
              label: "Next",
            ),
          ),
        )
      ]),
    ));
  }

  Widget _buildRadioOption(
      String option, String selectedRadio, BuildContext context) {
    bool isSelected = selectedRadio == option;
    return InkWell(
      onTap: () => context.read<ProfileBloc>()..selectProfileOption(option),
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

  Widget uploadImage(String label, File? selectedFile, String type, {bool isRequired = false}) {
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
                      onTap: () {
                        showImagePicker(type, profileBloc: profileBloc);
                      },
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
                      onTap: () => profileBloc..deleteFileImage(selectedFile, type, 0),
                      child: CustomImageView(imagePath: icDelete)),
                ),
            ],
          ),
        )
      ],
    );
  }
}
