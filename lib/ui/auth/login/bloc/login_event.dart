part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class GetCountryCodes extends LoginEvent {
  const GetCountryCodes();

  @override
  List<Object?> get props => [];
}
class SetLogin extends LoginEvent {
  final String phone;
  final String countryCode;
  const SetLogin(this.phone, this.countryCode);

  @override
  List<Object?> get props => [phone,countryCode];
}

class VerifyOTP extends LoginEvent {
  final phoneNo;
  final countryCode;
  final otp;
  const VerifyOTP(this.phoneNo, this.countryCode, this.otp);

  @override
  List<Object?> get props => [];
}
