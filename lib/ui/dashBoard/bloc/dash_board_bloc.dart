import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc(BuildContext context) : super(DashBoardInitial()) {
    on<DashBoardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
