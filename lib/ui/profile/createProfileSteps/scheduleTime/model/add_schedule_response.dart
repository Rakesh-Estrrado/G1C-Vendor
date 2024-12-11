/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

AddScheduleResponse addScheduleResponseFromJson(String str) =>
    AddScheduleResponse.fromJson(json.decode(str));

String addScheduleResponseToJson(AddScheduleResponse data) =>
    json.encode(data.toJson());

class AddScheduleResponse {
  AddScheduleResponse({
    required this.data,
    required this.message,
    required this.httpcode,
    required this.status,
  });

  Data? data;
  String message;
  int httpcode;
  String status;

  factory AddScheduleResponse.fromJson(Map<dynamic, dynamic> json) =>
      AddScheduleResponse(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"],
        httpcode: json["httpcode"],
        status: json["status"],
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
    required this.timeSlots,
    required this.sellerId,
  });

  TimeSlots? timeSlots;
  int? sellerId;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
      timeSlots: json["time_slots"] != null
          ? TimeSlots.fromJson(json["time_slots"]) : null,
      sellerId: json["seller_id"] ?? 0);

  Map<dynamic, dynamic> toJson() => {
        "time_slots": timeSlots?.toJson(),
        "seller_id": sellerId,
      };
}

class TimeSlots {
  TimeSlots({
    required this.startTime,
    required this.maxBookings,
    required this.endTime,
    required this.slotType,
    required this.slotId,
  });

  int slotId;
  String startTime;
  String maxBookings;
  String endTime;
  String slotType;

  factory TimeSlots.fromJson(Map<dynamic, dynamic> json) => TimeSlots(
      slotId: json["slot_Id"] ?? 0,
      startTime: json["start_time"] ?? "",
      maxBookings: json["max_bookings"] ?? "",
      endTime: json["end_time"] ?? "",
      slotType: json["slot_type"] ?? "");

  Map<dynamic, dynamic> toJson() => {
        "slotId": slotId,
        "start_time": startTime,
        "max_bookings": maxBookings,
        "end_time": endTime,
        "slot_type": slotType
      };
}
