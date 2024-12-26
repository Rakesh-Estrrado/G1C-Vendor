import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:g1c_vendor/data/model/success_model.dart';
import 'package:g1c_vendor/data/repository/Repository.dart';
import 'package:g1c_vendor/ui/bookings/bloc/model/booking_detail_model.dart';
import 'package:g1c_vendor/ui/bookings/bloc/model/booking_list_model.dart';
import 'package:g1c_vendor/utils/loader.dart';
import 'package:g1c_vendor/utils/utils.dart';

import '../serviceCompleted/serviceCompleted.dart';

part 'bookings_event.dart';

part 'bookings_state.dart';

Map<String, int> countdownMap = {};
Timer? countdownTimer;

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsBloc(BuildContext context) : super(BookingsState()) {
    on<GetBookingsList>((event, emit) async {
      try {
        showLoaderDialog();
        emit(state.copyWith(isLoading: true));
        BookingListModel res =
            await Repository().getBookingList(event.type, event.pageNo);
        closeLoaderDialog();

        if (res.httpcode == 200) {
          if (event.type == "new") {
            emit(state.copyWith(
                newBookingList: res.data!.bookingsList, isLoading: false));
          }
          if (event.type == "open") {
            emit(state.copyWith(
                openBookingList: res.data!.bookingsList, isLoading: false));
          }

          if (event.type == "active") {
            emit(state.copyWith(
                activeBookingList: res.data!.bookingsList, isLoading: false));
          }
          if (event.type == "completed") {
            emit(state.copyWith(
                completedBookingList: res.data!.bookingsList, isLoading: false));
          }
          if (event.type == "cancelled") {
            emit(state.copyWith(
                cancelledBookingList: res.data!.bookingsList, isLoading: false));
          }
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<GetBookingsDetails>((event, emit) async {
      try {
        showLoaderDialog();
        emit(state.copyWith(isLoading: true));
        BookingDetailModel res =
            await Repository().getBookingDetails(event.type, event.bookingId);
        closeLoaderDialog();

        if (res.httpcode == 200) {
          emit(state.copyWith(allBookingDetails: res.data));
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<AcceptRejectRequest>((event, emit) async {
      try {
        showLoaderDialog();
        emit(state.copyWith(isLoading: true));
        SuccessModel res = await Repository()
            .acceptRejectRequest(event.action, event.bookingId);
        closeLoaderDialog();
        if (res.httpcode == 200) {
          showSnackBar(context: context, msg: res.message);
          Navigator.pop(context, "requestUpdated");
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<CompletingBooking>((event, emit) async {
      try {
        showLoaderDialog();
        emit(state.copyWith(isLoading: true));
        SuccessModel res = await Repository().completingBooking(event.bookingId, event.rating, event.review);
        closeLoaderDialog();
        if (res.httpcode == 200) {
          showSnackBar(context: context, msg: res.message);
          navigateTo(context: context, destination: ServiceCompleted());
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: e.toString());
      }
    });
  }

  void getBookings(String type, int pageNo) {
    add(GetBookingsList(type, pageNo));
  }

  void getBookingDetails(String type, int bookingId) {
    add(GetBookingsDetails(type, bookingId));
  }

  void acceptRejectRequest(int bookingId, String action) {
    add(AcceptRejectRequest(action, bookingId));
  }

  void completeBooking(int bookingId, String review, int rating) {
    add(CompletingBooking(bookingId, rating, review));
  }
}
