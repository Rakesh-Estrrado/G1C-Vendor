/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

BookingDetailModel bookingDetailModelFromJson(String str) => BookingDetailModel.fromJson(json.decode(str));

String bookingDetailModelToJson(BookingDetailModel data) => json.encode(data.toJson());

class BookingDetailModel {
    BookingDetailModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    AllBookingDetails data;
    String message;
    int httpcode;
    String status;

    factory BookingDetailModel.fromJson(Map<dynamic, dynamic> json) => BookingDetailModel(
        data: AllBookingDetails.fromJson(json["data"]),
        message: json["message"],
        httpcode: json["httpcode"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "httpcode": httpcode,
        "status": status,
    };
}

class AllBookingDetails {
    AllBookingDetails({
        required this.customerDetail,
        required this.bookingsDetail,
        required this.billingSummary,
    });

    CustomerDetail customerDetail;
    BookingsDetail bookingsDetail;
    BillingSummary billingSummary;

    factory AllBookingDetails.fromJson(Map<dynamic, dynamic> json) => AllBookingDetails(
        customerDetail: CustomerDetail.fromJson(json["customer_detail"]),
        bookingsDetail: BookingsDetail.fromJson(json["bookings_detail"]),
        billingSummary: BillingSummary.fromJson(json["billing_summary"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "customer_detail": customerDetail.toJson(),
        "bookings_detail": bookingsDetail.toJson(),
        "billing_summary": billingSummary.toJson(),
    };
}

class BillingSummary {
    BillingSummary({
        required this.total,
        required this.subtotal,
        required this.voucher,
        required this.discount,
    });

    int total;
    int subtotal;
    int voucher;
    double discount;

    factory BillingSummary.fromJson(Map<dynamic, dynamic> json) => BillingSummary(
        total: json["total"],
        subtotal: json["subtotal"],
        voucher: json["voucher"],
        discount: json["discount"]?.toDouble(),
    );

    Map<dynamic, dynamic> toJson() => {
        "total": total,
        "subtotal": subtotal,
        "voucher": voucher,
        "discount": discount,
    };
}

class BookingsDetail {
    BookingsDetail({
        required this.date,
        required this.venue,
        required this.image,
        required this.serviceName,
        required this.discountPrice,
        required this.paymentStatus,
        required this.endTime,
        required this.bookedAddonsList,
        required this.bookingId,
        required this.duration,
        required this.startTime,
        required this.orderStatus,
        required this.price,
        required this.slotId,
        required this.authorizationCode,
        required this.orderId,
        required this.dayOfWeek,
    });

    String date;
    String venue;
    String image;
    String serviceName;
    int discountPrice;
    String paymentStatus;
    String endTime;
    List<dynamic> bookedAddonsList;
    int bookingId;
    String duration;
    String startTime;
    String orderStatus;
    double price;
    String slotId;
    String authorizationCode;
    String orderId;
    String dayOfWeek;

    factory BookingsDetail.fromJson(Map<dynamic, dynamic> json) => BookingsDetail(
        date: json["date"],
        venue: json["venue"],
        image: json["image"],
        serviceName: json["service_name"],
        discountPrice: json["discount_price"],
        paymentStatus: json["payment_status"],
        endTime: json["end_time"],
        bookedAddonsList: List<dynamic>.from(json["booked_addons_list"].map((x) => x)),
        bookingId: json["booking_id"],
        duration: json["duration"],
        startTime: json["start_time"],
        orderStatus: json["order_status"],
        price: json["price"]?.toDouble(),
        slotId: json["slot_id"],
        authorizationCode: json["authorization_code"],
        orderId: json["order_id"],
        dayOfWeek: json["day_of_week"],
    );

    Map<dynamic, dynamic> toJson() => {
        "date": date,
        "venue": venue,
        "image": image,
        "service_name": serviceName,
        "discount_price": discountPrice,
        "payment_status": paymentStatus,
        "end_time": endTime,
        "booked_addons_list": List<dynamic>.from(bookedAddonsList.map((x) => x)),
        "booking_id": bookingId,
        "duration": duration,
        "start_time": startTime,
        "order_status": orderStatus,
        "price": price,
        "slot_id": slotId,
        "authorization_code": authorizationCode,
        "order_id": orderId,
        "day_of_week": dayOfWeek,
    };
}

class CustomerDetail {
    CustomerDetail({
        required this.birthday,
        required this.profileImage,
        required this.gender,
        required this.dob,
        required this.preference,
        required this.name,
        required this.age
    });

    int birthday;
    String profileImage;
    String gender;
    String dob;
    List<dynamic> preference;
    String name;
    String age;

    factory CustomerDetail.fromJson(Map<dynamic, dynamic> json) => CustomerDetail(
        birthday: json["birthday"],
        profileImage: json["profile_image"],
        gender: json["gender"],
        dob: json["dob"],
        age: json["age"]??"0",
        preference: List<dynamic>.from(json["preference"].map((x) => x)),
        name: json["name"],
    );

    Map<dynamic, dynamic> toJson() => {
        "birthday": birthday,
        "profile_image": profileImage,
        "gender": gender,
        "dob": dob,
        "preference": List<dynamic>.from(preference.map((x) => x)),
        "name": name,
        "age": age,
    };
}
