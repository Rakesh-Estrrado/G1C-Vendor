part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final String message;
  final TermsAndConditionsData? termsAndConditionsData;

  const RegisterState(
      {this.isLoading = false, this.message = "", this.termsAndConditionsData});

  RegisterState copyWith(
      {bool? isLoading,
      String message = "",
      TermsAndConditionsData? termsAndConditionsData}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      termsAndConditionsData:
          termsAndConditionsData ?? this.termsAndConditionsData,
      message: message,
    );
  }

  @override
  List<Object?> get props => [isLoading, termsAndConditionsData, message];
}
