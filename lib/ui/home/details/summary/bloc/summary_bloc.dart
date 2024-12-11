import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc() : super(SummaryInitial()) {
    on<SummaryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
