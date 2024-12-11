part of 'register_bloc.dart';


abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class SendOTP extends RegisterEvent {
  final phoneNo;
  final countryCode;
  const SendOTP(this.phoneNo, this.countryCode);

  @override
  List<Object?> get props => [];
}

class VerifyOTP extends RegisterEvent {
  final phoneNo;
  final countryCode;
  final otp;
  const VerifyOTP(this.phoneNo, this.countryCode, this.otp);

  @override
  List<Object?> get props => [];
}

class GetTermsAndConditions extends RegisterEvent {
  const GetTermsAndConditions();

  @override
  List<Object?> get props => [];
}