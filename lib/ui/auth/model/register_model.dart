/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory RegisterModel.fromJson(Map<dynamic, dynamic> json) => RegisterModel(
        data: Data.fromJson(json["data"]??{}),
        message: json["message"]??"",
        httpcode: json["httpcode"]??0,
        status: json["status"]??"",
    );

    Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "httpcode": httpcode,
        "status": status,
    };
}

class Data {
    Data({
        required this.redirect,
        required this.countryCode,
        required this.phoneNumber,
    });

    String redirect;
    String countryCode;
    String phoneNumber;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        redirect: json["redirect"]??"",
        countryCode: json["country_code"]??"",
        phoneNumber: json["phone_number"]??"",
    );

    Map<dynamic, dynamic> toJson() => {
        "redirect": redirect,
        "country_code": countryCode,
        "phone_number": phoneNumber,
    };
}
