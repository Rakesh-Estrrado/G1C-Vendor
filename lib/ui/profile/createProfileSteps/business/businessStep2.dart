import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/image_constant.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/widgets/ActionButtonsRow.dart';
import '../../../../utils/widgets/CommonTextField.dart';
import '../../../widgets/custom_image_view.dart';
import '../../searchForLocation.dart';
import '../bloc/profile_bloc.dart';

class BusinessStep2 extends StatelessWidget {
  const BusinessStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        SizedBox(height: 10),
        CustomImageView(
          imagePath: map,
          height: 75.sp,
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Text("Address",
                style:
                    textStyleRegular.copyWith(color: white.withOpacity(0.7))),
            Spacer(),
            gradientContainer(
                height: 30,
                child: Center(
                  child: SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () => navigateTo(
                          context: context, destination: SearchForLocation()),
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        // Remove any button shadow
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text("Change",
                          style: textStyleRegular.copyWith(
                              color: white.withOpacity(0.9))),
                    ),
                  ),
                )),
          ],
        ),
        SizedBox(height: 20),
        BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (p, c) => p.address != c.address,
          builder: (context, state) {
            return Text("${state.address}", style: textStyleRegular);
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.buildingNoController,
          builder: (context, buildingNoController) {
            return CommonTextField(
                labelText: "Building No.",
                hintText: "Building No",
                controller: buildingNoController,
                keyboardType: TextInputType.number,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.landMarkController,
          builder: (context, landMarkController) {
            return CommonTextField(
                labelText: "LandMark (Optional)",
                hintText: "LandMark ",
                controller: landMarkController,
                maxLines: 3,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        ActionButtonsRow(
            cancelText: "Previous",
            submitText: "Next",
            onCancel: () => context.read<ProfileBloc>()..moveToPrevious(),
            onSubmit: () => context.read<ProfileBloc>()..validateAndMove())
      ]),
    ));
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
