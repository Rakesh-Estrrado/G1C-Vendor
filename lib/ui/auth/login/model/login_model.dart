/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
        data: Data.fromJson(json["data"]),
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

class Data {
    Data({
        required this.redirect,
        required this.otp,
        required this.sellerId,
    });

    String redirect;
    String otp;
    int sellerId;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        redirect: json["redirect"]??"",
        otp: json["otp"]??"",
        sellerId: json["seller_id"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "redirect": redirect,
        "otp": otp,
        "seller_id": sellerId,
    };
}
