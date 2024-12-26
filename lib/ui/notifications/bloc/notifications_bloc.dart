import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc(BuildContext context) : super(NotificationsInitial()) {
    on<NotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
