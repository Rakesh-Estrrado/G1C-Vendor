import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:g1c_vendor/data/repository/Repository.dart';
import 'package:g1c_vendor/ui/auth/login/model/login_model.dart';
import 'package:g1c_vendor/ui/auth/model/CountryCodeModel.dart';
import 'package:g1c_vendor/utils/loader.dart';
import 'package:g1c_vendor/utils/utils.dart';

import '../../../../di/AppLocator.dart';
import '../../../../utils/sessionManager.dart';
import '../../../dashBoard/dashboard_screen.dart';
import '../../otpVerification/otpVerifcationLogin.dart';
import '../model/login_o_t_p_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionManager sessionManager = AppLocator.instance<SessionManager>();
  LoginBloc(BuildContext context) : super(LoginState()) {
    on<GetCountryCodes>((event, emit) async {
      try {
        showLoaderDialog();
        CountryCodeModel response = await Repository().getCountryCodes();
        closeLoaderDialog();
        if (response.httpcode == 200) {
          emit(state.copyWith(countryCodes: response.data?.country));
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<SetLogin>((event, emit) async {
      try {
        showLoaderDialog();
        LoginModel response =
            await Repository().login(event.phone, event.countryCode);
        closeLoaderDialog();
        if (response.httpcode == 200) {
          showSnackBar(context: context, msg: response.message);
          sessionManager.sellerId = response.data.sellerId;
          navigateTo(
              context: context,
              destination: OTPVerificationLoginScreen.builder(
              context,   event.phone, event.countryCode));
        }else{
          showSnackBar(context: context, msg: response.message);
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
        LoginOtpModel response = await Repository()
            .verifyOTPLogin(event.phoneNo, event.countryCode, event.otp);
        closeLoaderDialog();

        if (response.httpcode == 200) {
          sessionManager.isLogin = true;
          sessionManager.token = response.data.accessToken;
          sessionManager.userName = response.data.userDetails.fname;
          sessionManager.userBusinessName = response.data.userDetails.businessName;
          sessionManager.profileImage = response.data.userDetails.profileImg;
          showSnackBar(context: context, msg: response.message);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
                  (route) => false);

        }else{
          showSnackBar(context: context, msg: response.message,duration: 4);
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });
  }

  getCountryCodes() {
    add(GetCountryCodes());
  }

  setLogin(String phone, String countryCode) {
    add(SetLogin(phone,countryCode));
  }


  void  verifyOTP(String phoneNo, String countryCode, String otp) {
    add(VerifyOTP(phoneNo, countryCode, otp));
  }

}
