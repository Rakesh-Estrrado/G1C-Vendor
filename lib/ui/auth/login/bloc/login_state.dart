part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String message;
  final bool isLoading;
  final List<CountryCodes> countryCodes;

  const LoginState( {this.message = "",this.isLoading = false, this.countryCodes = const []});

  LoginState copyWith({bool? isLoading, List<CountryCodes>? countryCodes,String? message}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        countryCodes: countryCodes ?? this.countryCodes);
  }

  @override
  List<Object?> get props => [isLoading, countryCodes, message];
}