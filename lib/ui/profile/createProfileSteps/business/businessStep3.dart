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
import '../bloc/profile_bloc.dart';

class BusinessStep3 extends StatelessWidget {
  final ProfileBloc profileBloc;
  const BusinessStep3({super.key, required this.profileBloc});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(children: [
        SizedBox(height: 10),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.bankNameController,
          builder: (context, bankNameController) {
            return CommonTextField(
                labelText: "Bank Name",
                hintText: "Bank Name",
                isRequired: true,
                controller: bankNameController,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.bankAccNoController,
          builder: (context, bankAccNoController) {
            return CommonTextField(
                labelText: "Bank Account Number",
                hintText: "Bank Account Number",
                isRequired: true,
                controller: bankAccNoController,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        BlocSelector<ProfileBloc, ProfileState, TextEditingController?>(
          selector: (state) => state.bankAccNameController,
          builder: (context, bankAccNameController) {
            return CommonTextField(
                labelText: "Bank Account Name",
                hintText: "Bank Account Name",
                isRequired: true,
                controller: bankAccNameController,
                onChanged: (val) {});
          },
        ),
        SizedBox(height: 20),
        uploadDoc("Supporting Business Document"),
        SizedBox(height: 5),
        BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => previous.docs != current.docs,
          builder: (context, state) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.docs.length,
                itemBuilder: (context, i) {
                  var document = state.docs[i];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isImage(document)
                            ? Image.file(
                                document,
                                height: 32,
                              )
                            : CustomImageView(imagePath: icPDF, height: 32),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${getFileNameWithExtensions(document)}",
                                  style: textStyleSmall),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              profileBloc.deleteFileImage(document, "doc", i);
                              // context.read<ProfileBloc>()..add;
                              // state.docs.remove(document);
                            },
                            child: CustomImageView(
                                imagePath: icDelete, height: 18)),
                      ],
                    ),
                  );
                });
          },
        ),
        SizedBox(height: 35),
        Container(
          padding: EdgeInsets.all(16),
          decoration: semiCircleBoxWithBorder(color: darkBlue, radius: 16),
          child: Column(
            children: [
              Text(
                "Important Note:\n\nPlease be informed that your financial data is never shared with third parties and is used exclusively for processing payments within the G1C platform.\n\nFor more information on our data security practices and your rights, please read our full privacy policy.",
                style: textStyleSmall.copyWith(color: white.withOpacity(0.5)),
              )
            ],
          ),
        ),
        SizedBox(height: 35),
        ActionButtonsRow(
            cancelText: "Previous",
            submitText: "Next",
            onCancel: () => context.read<ProfileBloc>()..moveToPrevious(),
            onSubmit: () => context.read<ProfileBloc>()..validateAndMove()),
        SizedBox(height: 10),
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

  Widget uploadDoc(String label, {bool isRequired = false}) {
    return BlocSelector<ProfileBloc, ProfileState, List<File>?>(
      selector: (state) => state.docs,
      builder: (context, docs) {
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
                  InkWell(
                      onTap: () {
                        if (docs!.length > 4) {
                          showSnackBar(
                              context: context,
                              msg: "Max 5 Documents can be Add");
                        } else {
                          handleFilePick("file", "", "doc",profileBloc: profileBloc);
                        }
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
                            Text("Upload Document",
                                style: textStyleRegular.copyWith(
                                    color: white.withOpacity(0.6)))
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
