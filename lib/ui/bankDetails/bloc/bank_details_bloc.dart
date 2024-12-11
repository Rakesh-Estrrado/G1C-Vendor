import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bank_details_event.dart';
part 'bank_details_state.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  BankDetailsBloc() : super(BankDetailsInitial()) {
    on<BankDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
