import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/auth/register/bloc/register_bloc.dart';
import 'package:g1c_vendor/ui/termsAndConditions/TermsAndConditions.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  final List<String> countryCodes;

  RegisterScreen({super.key, required this.countryCodes});

  static Widget builder(BuildContext context, List<String> countryCodes) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(context),
      child: RegisterScreen(countryCodes: countryCodes),
    );
  }

  final ValueNotifier<bool> checkedTermsAndConditions = ValueNotifier(false);
  final ValueNotifier<String> selectedCountryCode = ValueNotifier("+60");
  final mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<RegisterBloc>();
    return Background(
      resize: false,
      isAuth: true,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: CustomImageView(
                          imagePath: logo,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      "Provider Sign Up",
                      style: textStyleBoldLarge.copyWith(fontSize: 22.sp),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Phone Number",
                      style: textStyleSemiBoldMedium,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: darkBlue200,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.asset(logo, height: 24, width: 24),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 80,
                                child: ValueListenableBuilder<String?>(
                                  valueListenable: selectedCountryCode,
                                  builder: (context, val, child) {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        dropdownColor: darkBlue400,
                                        value: selectedCountryCode.value,
                                        isExpanded: true,
                                        hint: Text("Select State"),
                                        style: textStyleRegular,
                                        items: countryCodes.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          selectedCountryCode.value =
                                              val.toString();
                                        },
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: white),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: mobile,
                              style: textStyleSemiBoldMedium,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: checkedTermsAndConditions,
                            builder: (context, child, val) {
                              return Checkbox(
                                value: checkedTermsAndConditions.value,
                                // You can manage the state with a StatefulWidget or a provider
                                onChanged: (bool? value) {
                                  checkedTermsAndConditions.value = value!;
                                },
                                activeColor: Colors.white,
                                checkColor: Colors.black,
                              );
                            }),
                        const SizedBox(height: 10),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I accept to the ',
                                  style: textStyleRegularMedium.copyWith(
                                      fontSize: 15.sp),
                                ),
                                TextSpan(
                                  text: 'Terms of Use',
                                  style: textStyleRegularMedium.copyWith(
                                      fontSize: 15.sp,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigateTo(
                                          context: context,
                                          destination:
                                              TermsAndConditions.builder(
                                                  context, "Terms of Use"));
                                    },
                                ),
                                TextSpan(
                                  text: ', ',
                                  style: textStyleRegularMedium,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Privacy Policy tap
                                    },
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: textStyleRegularMedium.copyWith(
                                      fontSize: 15.sp,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigateTo(
                                          context: context,
                                          destination:
                                              TermsAndConditions.builder(
                                                  context, "Privacy Policy"));
                                    },
                                ),
                                TextSpan(
                                  text: ', ',
                                  style: textStyleRegularMedium,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle Privacy Policy tap
                                    },
                                ),
                                TextSpan(
                                  text: 'PDPA & NDA.',
                                  style: textStyleRegularMedium.copyWith(
                                      fontSize: 15.sp,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigateTo(
                                          context: context,
                                          destination:
                                              TermsAndConditions.builder(
                                                  context, "PDPA & NDA"));
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CommonButton(
                        label: "Send OTP",
                        onTap: () {
                          if (checkedTermsAndConditions.value) {
                            var phoneNo = mobile.text;
                            if (phoneNo.isEmpty) {
                              showSnackBar(
                                  context: context,
                                  msg: "Please enter a valid mobile number.");
                              return;
                            }
                            context.read<RegisterBloc>()
                              ..sendOTP(phoneNo, selectedCountryCode.value);
                          } else {
                            showSnackBar(
                                context: context,
                                msg: "Please accept terms and conditions");
                          }
                        }),
                    const SizedBox(height: 20), // Replace Spacer
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have An Account?",
                      style: textStyleSemiBoldMedium.copyWith(
                          color: Colors.white)),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text("Sign In",
                        style: textStyleSemiBoldMedium.copyWith(
                            color: Colors.red)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
