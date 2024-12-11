import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'revenu_graph_event.dart';
part 'revenu_graph_state.dart';

class RevenuGraphBloc extends Bloc<RevenuGraphEvent, RevenuGraphState> {
  RevenuGraphBloc() : super(RevenuGraphInitial()) {
    on<RevenuGraphEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
