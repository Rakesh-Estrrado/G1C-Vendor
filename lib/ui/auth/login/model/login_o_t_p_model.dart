/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) => LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
    LoginOtpModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory LoginOtpModel.fromJson(Map<dynamic, dynamic> json) => LoginOtpModel(
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
        required this.accessToken,
        required this.userDetails,
    });

    String accessToken;
    UserDetails userDetails;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        accessToken: json["access_token"],
        userDetails: UserDetails.fromJson(json["user_details"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "access_token": accessToken,
        "user_details": userDetails.toJson(),
    };
}

class UserDetails {
    UserDetails({
        required this.fname,
        required this.businessName,
        required this.profileImg,
        required this.lname,
        required this.phone,
        required this.joined,
        required this.joinedAgo,
        required this.storeName,
        required this.sellerId,
        required this.email,
    });

    String fname;
    String businessName;
    String profileImg;
    String lname;
    String phone;
    String joined;
    String joinedAgo;
    String storeName;
    int sellerId;
    String email;

    factory UserDetails.fromJson(Map<dynamic, dynamic> json) => UserDetails(
        fname: json["fname"],
        businessName: json["business_name"],
        profileImg: json["profile_img"],
        lname: json["lname"],
        phone: json["phone"],
        joined: json["joined"],
        joinedAgo: json["joined_ago"],
        storeName: json["store_name"],
        sellerId: json["seller_id"],
        email: json["email"],
    );

    Map<dynamic, dynamic> toJson() => {
        "fname": fname,
        "business_name": businessName,
        "profile_img": profileImg,
        "lname": lname,
        "phone": phone,
        "joined": joined,
        "joined_ago": joinedAgo,
        "store_name": storeName,
        "seller_id": sellerId,
        "email": email,
    };
}
