import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otpverifcation_event.dart';
part 'otpverifcation_state.dart';

class OtpverifcationBloc extends Bloc<OtpverifcationEvent, OtpverifcationState> {
  OtpverifcationBloc() : super(OtpverifcationInitial()) {
    on<OtpverifcationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
