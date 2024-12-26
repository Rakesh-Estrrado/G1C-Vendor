part of 'bookings_bloc.dart';

abstract class BookingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBookingsList extends BookingsEvent {
  final String type;
  final int pageNo;

  GetBookingsList(this.type, this.pageNo);
}

class GetBookingsDetails extends BookingsEvent {
  final String type;
  final int bookingId;

  GetBookingsDetails(this.type, this.bookingId);
}

class AcceptRejectRequest extends BookingsEvent {
  final int bookingId;
  final String action;

  AcceptRejectRequest(this.action, this.bookingId);
}

class CompletingBooking extends BookingsEvent {
  final int bookingId;
  final int rating;
  final String review;

  CompletingBooking(this.bookingId, this.rating, this.review);
}
