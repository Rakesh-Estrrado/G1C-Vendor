import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/auth/model/terms_and_conditions_model.dart';
import 'package:g1c_vendor/ui/auth/otpVerification/otpVerifcation.dart';

import '../../../../data/repository/Repository.dart';
import '../../../../di/AppLocator.dart';
import '../../../../utils/loader.dart';
import '../../../../utils/sessionManager.dart';
import '../../../../utils/utils.dart';
import '../../../dashBoard/dashboard_screen.dart';
import '../../../profile/createProfile.dart';
import '../../model/register_model.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(BuildContext context) : super(RegisterState()) {
    on<SendOTP>((event, emit) async {
      try {
        showLoaderDialog();
        RegisterModel response =
            await Repository().register(event.phoneNo, event.countryCode);
        closeLoaderDialog();

        if (response.httpcode == 200) {
          showSnackBar(
              context: context, msg: "Otp sent the the registered mobile no.");
          Navigator.pop(context);
          navigateTo(
              context: context,
              destination: OTPVerificationScreen.builder(
                  context, event.phoneNo, event.countryCode,"registration"));
        }else{
          showSnackBar(
              context: context, msg: response.message);
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<VerifyOTP>((event, emit) async {
      try {
        showLoaderDialog();
        RegisterModel response = await Repository()
            .verifyOTP(event.phoneNo, event.countryCode, event.otp);
        closeLoaderDialog();

        if (response.httpcode == 200) {
          showSnackBar(context: context, msg: response.message);
            Navigator.pop(context);
            navigateTo(context: context, destination: CreateProfile.builder(context,event.phoneNo,event.countryCode));
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });
    on<GetTermsAndConditions>((event, emit) async {
      try {
        showLoaderDialog();
        TermsAndConditionsModel response = await Repository().getTermsAndConditions();
        closeLoaderDialog();

        if (response.httpcode == 200) {
          emit(state.copyWith(termsAndConditionsData: response.data));
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });
  }

  void sendOTP(String phoneNo, String countryCode) {
    add(SendOTP(phoneNo, countryCode));
  }

  void  verifyOTP(String phoneNo, String countryCode, String otp) {
    add(VerifyOTP(phoneNo, countryCode, otp));
  }

  void getTermsAndConditions() {
    add(GetTermsAndConditions());
  }
}
