/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

ScheduleModel ScheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String ScheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
    ScheduleModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    ScheduleData data;
    String message;
    int httpcode;
    String status;

    factory ScheduleModel.fromJson(Map<dynamic, dynamic> json) => ScheduleModel(
        data: ScheduleData.fromJson(json["data"]),
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

class ScheduleData {
    ScheduleData({
        required this.schedulesList,
        required this.sellerId,
    });

    List<SchedulesList> schedulesList;
    int sellerId;

    factory ScheduleData.fromJson(Map<dynamic, dynamic> json) => ScheduleData(
        schedulesList: List<SchedulesList>.from(json["schedules_list"].map((x) => SchedulesList.fromJson(x))),
        sellerId: json["seller_id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "schedules_list": List<dynamic>.from(schedulesList.map((x) => x.toJson())),
        "seller_id": sellerId,
    };
}

class SchedulesList {
    SchedulesList({
        required this.timeSlots,
        required this.timeslotsCount,
        required this.day,
    });

    List<TimeSlot> timeSlots;
    int timeslotsCount;
    String day;

    factory SchedulesList.fromJson(Map<dynamic, dynamic> json) => SchedulesList(
        timeSlots: List<TimeSlot>.from(json["time_slots"].map((x) => TimeSlot.fromJson(x))),
        timeslotsCount: json["timeslots_count"],
        day: json["day"],
    );

    Map<dynamic, dynamic> toJson() => {
        "time_slots": List<dynamic>.from(timeSlots.map((x) => x.toJson())),
        "timeslots_count": timeslotsCount,
        "day": day,
    };
}

class TimeSlot {
    TimeSlot({
        required this.startTime,
        required this.slotId,
        required this.maxBookings,
        required this.endTime,
        required this.slotType,
    });

    String startTime;
    int slotId;
    int maxBookings;
    String endTime;
    SlotType slotType;

    factory TimeSlot.fromJson(Map<dynamic, dynamic> json) => TimeSlot(
        startTime: json["start_time"],
        slotId: json["slot_id"],
        maxBookings: json["max_bookings"],
        endTime: json["end_time"],
        slotType: slotTypeValues.map[json["slot_type"]]!,
    );

    Map<dynamic, dynamic> toJson() => {
        "start_time": startTime,
        "slot_id": slotId,
        "max_bookings": maxBookings,
        "end_time": endTime,
        "slot_type": slotTypeValues.reverse[slotType],
    };
}

enum SlotType { SINGLE, MULTIPLE }

final slotTypeValues = EnumValues({
    "multiple": SlotType.MULTIPLE,
    "single": SlotType.SINGLE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
