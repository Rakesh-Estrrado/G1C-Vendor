import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/auth/register/bloc/register_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:sizer/sizer.dart';

class OTPVerificationScreen extends StatelessWidget {
  final phone;
  final countryCode;
  OTPVerificationScreen({super.key, required this.phone,required  this.countryCode});

  static Widget builder(BuildContext context, String phone, String countryCode, String from) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(context),
      child: OTPVerificationScreen(phone: phone,countryCode: countryCode),
    );
  }

  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    return Background(
        isAuth: true,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: Padding(padding: const EdgeInsets.only(top: 40.0),child: CustomImageView(imagePath: logo)),),
                  const SizedBox(height: 100),
                  Text("OTP Verification", style: textStyleBoldLarge.copyWith(fontSize: 22.sp)),
                  const SizedBox(height: 30),
                  Text("Enter OTP", style: textStyleSemiBoldMedium),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildInputBox(context,0),
                      buildInputBox(context,1),
                      buildInputBox(context,2),
                      buildInputBox(context,3),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CommonButton(label: "Verify", onTap: () {
                    var otp = "";
                    _controllers.forEach((e){
                      otp = "$otp${e.text}";
                    });

                    if(otp.length < 3){
                      showSnackBar(context: context, msg: "please enter a valid otp");
                      return;
                    }
                    myFocusNode.unfocus();
                    context.read<RegisterBloc>()..verifyOTP(phone, countryCode, otp);

                  }),
                ],
              ),
            ),
          ),
        ),
      );
}

  Widget buildInputBox(BuildContext context,int index) {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(width: 1,color: darkBlue400),
          color: darkBlue200),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _controllers[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        focusNode: _focusNodes[index],
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.symmetric(vertical: 9.sp),
          border: InputBorder.none,
        ),
        style: textStyleRegularMedium,
        onChanged: (value) {
          if (value.length == 1 && index < _focusNodes.length - 1) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }
}


