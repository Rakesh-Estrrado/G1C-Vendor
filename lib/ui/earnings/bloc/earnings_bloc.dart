import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'earnings_event.dart';

part 'earnings_state.dart';

class EarningsBloc extends Bloc<EarningsEvent, EarningsState> {
  EarningsBloc(BuildContext context) : super(EarningsInitial()) {
    on<EarningsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
