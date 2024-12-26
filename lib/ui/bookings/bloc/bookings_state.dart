part of 'bookings_bloc.dart';

class BookingsState extends Equatable {
  BookingsState(
      {this.isLoading = false,
      this.allBookingDetails,
      this.countDownTime="00:00:00",
      this.newBookingList = const [],
      this.openBookingList = const [],
      this.activeBookingList = const [],
      this.completedBookingList = const [],
      this.cancelledBookingList = const []});

  final bool isLoading;
  final String countDownTime;
  final List<BookingsList> newBookingList;
  final List<BookingsList> openBookingList;
  final List<BookingsList> activeBookingList;
  final List<BookingsList> completedBookingList;
  final List<BookingsList> cancelledBookingList;
  final AllBookingDetails? allBookingDetails;

  @override
  List<Object?> get props => [
        isLoading,
        countDownTime,
        allBookingDetails,
        newBookingList,
        openBookingList,
        activeBookingList,
        completedBookingList,
        cancelledBookingList
      ];

  BookingsState copyWith(
      {bool? isLoading,
      String? countDownTime,
      AllBookingDetails? allBookingDetails,
      List<BookingsList>? newBookingList,
      List<BookingsList>? openBookingList,
      List<BookingsList>? activeBookingList,
      List<BookingsList>? completedBookingList,
      List<BookingsList>? cancelledBookingList}) {
    return BookingsState(
        isLoading: isLoading ?? this.isLoading,
        countDownTime: countDownTime ?? this.countDownTime,
        allBookingDetails: allBookingDetails ?? this.allBookingDetails,
        newBookingList: newBookingList ?? this.newBookingList,
        openBookingList: openBookingList ?? this.openBookingList,
        activeBookingList: activeBookingList ?? this.activeBookingList,
        completedBookingList: completedBookingList ?? this.completedBookingList,
        cancelledBookingList:
            cancelledBookingList ?? this.cancelledBookingList);
  }
}
