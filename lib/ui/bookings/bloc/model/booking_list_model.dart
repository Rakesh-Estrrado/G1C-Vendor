
class BookingListModel {
    BookingListModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data? data;
    String message;
    int httpcode;
    String status;

    factory BookingListModel.fromJson(Map<dynamic, dynamic> json) => BookingListModel(
        data: json["data"] == null || json["data"].toString() == "[]"
            ? null
            : Data.fromJson(json["data"]),
        message: json["message"] ?? '',
        httpcode: json["httpcode"] ?? 0,
        status: json["status"] ?? '',
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "httpcode": httpcode,
        "status": status,
    };
}

class Data {
    Data({
        required this.pagination,
        required this.bookingsList,
        required this.filterData,
    });

    Pagination? pagination;
    List<BookingsList>? bookingsList;
    List<dynamic>? filterData;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        bookingsList: json["bookings_list"] == null
            ? []
            : List<BookingsList>.from(
            json["bookings_list"].map((x) => BookingsList.fromJson(x))),
        filterData: json["filter_data"] == null
            ? []
            : List<dynamic>.from(json["filter_data"].map((x) => x)),
    );

    Map<dynamic, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "bookings_list":
        bookingsList?.map((x) => x.toJson()).toList() ?? [],
        "filter_data": filterData ?? [],
    };
}

class BookingsList {
    BookingsList({
        required this.date,
        required this.acceptanceEndTime,
        required this.venue,
        required this.image,
        required this.serviceName,
        required this.customerDetail,

        required this.discountPrice,
        required this.endTime,
        required this.bookingId,
        required this.duration,
        required this.startTime,
        required this.orderStatus,
        required this.price,
        required this.orderId,
    });

    String date;
    int acceptanceEndTime;
    String venue;
    String image;
    String serviceName;
    int discountPrice;
    String endTime;
    int bookingId;
    String duration;
    String startTime;
    String orderStatus;
    double price;
    CustomerDetail customerDetail;
    String orderId;

    factory BookingsList.fromJson(Map<dynamic, dynamic> json) => BookingsList(
        date: json["date"] ?? '',
        acceptanceEndTime: json["acceptance_end_time"] ?? 0,
        venue: json["venue"] ?? '',
        image: json["image"] ?? '',
        serviceName: json["service_name"] ?? '',
        discountPrice: json["discount_price"] ?? 0,
        endTime: json["end_time"] ?? '',
        bookingId: json["booking_id"] ?? 0,
        duration: json["duration"] ?? '',
        startTime: json["start_time"] ?? '',
        orderStatus: json["order_status"] ?? '',
        customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
        price: (json["price"] ?? 0).toDouble(),
        orderId: json["order_id"] ?? '',
    );

    Map<dynamic, dynamic> toJson() => {
        "date": date,
        "acceptance_end_time": acceptanceEndTime,
        "venue": venue,
        "image": image,
        "service_name": serviceName,
        "discount_price": discountPrice,
        "end_time": endTime,
        "booking_id": bookingId,
        "duration": duration,
        "start_time": startTime,
        "order_status": orderStatus,
        "customer_detail": customerDetail,
        "price": price,
        "order_id": orderId,
    };
}

class Pagination {
    Pagination({
        required this.perPage,
        required this.lastPage,
        required this.totalBookings,
        required this.currentPage,
    });

    String perPage;
    int lastPage;
    int totalBookings;
    int currentPage;

    factory Pagination.fromJson(Map<dynamic, dynamic> json) => Pagination(
        perPage: json["per_page"] ?? '0',
        lastPage: json["last_page"] ?? 0,
        totalBookings: json["total_bookings"] ?? 0,
        currentPage: json["current_page"] ?? 0,
    );

    Map<dynamic, dynamic> toJson() => {
        "per_page": perPage,
        "last_page": lastPage,
        "total_bookings": totalBookings,
        "current_page": currentPage,
    };
}


class CustomerDetail {
    CustomerDetail({
        required this.birthday,
        required this.profileImage,
        required this.gender,
        required this.dob,
        // required this.preference,
        required this.name,
    });

    int birthday;
    String profileImage;
    String gender;
    String dob;
    // Preference preference;
    String name;

    factory CustomerDetail.fromJson(Map<dynamic, dynamic> json) => CustomerDetail(
        birthday: json["birthday"],
        profileImage: json["profile_image"],
        gender: json["gender"],
        dob: json["dob"],
        // preference: Preference.fromJson(json["preference"]),
        name: json["name"],
    );

    Map<dynamic, dynamic> toJson() => {
        "birthday": birthday,
        "profile_image": profileImage,
        "gender": gender,
        "dob": dob,
        // "preference": preference.toJson(),
        "name": name,
    };
}