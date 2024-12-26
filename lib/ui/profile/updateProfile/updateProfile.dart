import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/profile/model/account_model.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

import '../../../utils/colors.dart';
import '../bloc/account_bloc.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var name = TextEditingController();
  var email = TextEditingController();
  var mobileNo = TextEditingController();

  ValueNotifier<String> imageFile = ValueNotifier("");

  @override
  Widget build(BuildContext context) {

    return Background(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar2(title: "Profile"),
            SizedBox(height: 40),
            Expanded( // Ensure this Column is within an Expanded to handle remaining space.
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        BlocSelector<AccountBloc, AccountState, BasicDetails?>(
                          selector: (state) => state.basicDetails,
                          builder: (context, basicDetails) {
                            return  ValueListenableBuilder(
                              valueListenable: imageFile,
                              builder: (context,child,val) {
                                return CustomImageView(
                                    imagePath: imageFile.value.isEmpty
                                        ? basicDetails?.avatar
                                        : imageFile.value,
                                    radius: BorderRadius.circular(100),
                                    fit: BoxFit.cover,
                                    height: 130,
                                    width: 130
                                );
                              }
                            );
                          },
                        ),
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: InkWell(
                            onTap: () => showImagePicker(),
                            child:CustomImageView(
                            imagePath: uploadCamera,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        name.text = "${state.basicDetails?.fname}";
                        email.text = "${state.basicDetails?.email}";
                        mobileNo.text = "+${state.basicDetails?.countryCode} ${state.basicDetails?.phone}";
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: CommonTextField(
                                labelText: "Name",
                                hintText: "",
                                controller: name,
                                onChanged: (val) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: CommonTextField(
                                labelText: "Email",
                                hintText: "",
                                controller: email,
                                onChanged: (val) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: CommonTextField(
                                labelText: "Mobile No.",
                                hintText: "",
                                isEditable: false,
                                showLightBlue: true,
                                controller: mobileNo,
                                onChanged: (val) {},
                              ),
                            ),
                            SizedBox(height: 20), // Add spacing instead of Spacer.
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: CommonButton(
                                label: "Update",
                                onTap: () {
                                  var profileName = name.text;
                                  var profileEmail = email.text;
                                  if (profileName.isEmpty) {
                                    showSnackBar(
                                        context: context,
                                        msg: "Please enter a valid name");
                                    return;
                                  }
                                  if (!profileEmail.isValidEmail()) {
                                    showSnackBar(
                                        context: context,
                                        msg: "Please enter a valid email id");
                                    return;
                                  }
                                  context
                                      .read<AccountBloc>()
                                      .updateProfile(profileName, profileEmail, imageFile.value);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  void showImagePicker() {
    showDialog(
      context: context,
      builder: (con) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          child: Container(
            height: 180,
            width: MediaQuery.of(con).size.width,
            margin: EdgeInsets.all(25),
            decoration: semiCircleBox(color: darkBlue200, radius: 10),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => handleFilePick("camera"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImageView(imagePath: icCamera, width: 80, height: 80),
                        SizedBox(height: 10),
                        Text("Camera", style: textStyleSemiBold)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => handleFilePick("gallery"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImageView(
                            imagePath: icGallery,
                            width: 80,
                            height: 80,
                            color: Color(0xFF8688A1)),
                        SizedBox(height: 10),
                        Text("Gallery", style: textStyleSemiBold)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      useSafeArea: false,
      barrierDismissible: true,
    ).whenComplete(() {});
  }

  Future<void> handleFilePick(String imageSource) async {
    var file = await pickFile("", imageSource, context);
    Navigator.pop(context);
    if (file != null) {
       imageFile.value = file.path;
    }
  }
}
