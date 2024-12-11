/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

SuccessModel successModelFromJson(String str) => SuccessModel.fromJson(json.decode(str));

String successModelToJson(SuccessModel data) => json.encode(data.toJson());

class SuccessModel {
    SuccessModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory SuccessModel.fromJson(Map<dynamic, dynamic> json) => SuccessModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        httpcode: json["httpcode"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        // "data": data.toJson(),
        "message": message,
        "httpcode": httpcode,
        "status": status,
    };
}

class Data {
    Data({
        required this.sellerId,
        required this.serviceId,
    });

    String sellerId;
    int serviceId;

    factory Data.fromJson(Map<dynamic, dynamic>? json) => Data(
        sellerId: json?["seller_id"].toString()??"",
        serviceId: json?["service_id"] != null
            ? int.tryParse(json!["service_id"].toString()) ?? 0
            : 0,

    );

    Map<dynamic, dynamic> toJson() => {
        "seller_id": sellerId,
        "service_id": serviceId,
    };
}
