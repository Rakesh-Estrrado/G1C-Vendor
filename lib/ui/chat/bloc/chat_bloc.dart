import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(BuildContext context) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
