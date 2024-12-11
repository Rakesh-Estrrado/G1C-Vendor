/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

TermsAndConditionsModel termsAndConditionsModelFromJson(String str) => TermsAndConditionsModel.fromJson(json.decode(str));

String termsAndConditionsModelToJson(TermsAndConditionsModel data) => json.encode(data.toJson());

class TermsAndConditionsModel {
    TermsAndConditionsModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    TermsAndConditionsData data;
    String message;
    int httpcode;
    String status;

    factory TermsAndConditionsModel.fromJson(Map<dynamic, dynamic> json) => TermsAndConditionsModel(
        data: TermsAndConditionsData.fromJson(json["data"]),
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

class TermsAndConditionsData {
    TermsAndConditionsData({
        required this.termsAndConditions,
        required this.pdpa,
        required this.privacyPolicy,
        required this.nda,
    });

    String termsAndConditions;
    String pdpa;
    String privacyPolicy;
    String nda;

    factory TermsAndConditionsData.fromJson(Map<dynamic, dynamic> json) => TermsAndConditionsData(
        termsAndConditions: json["terms_and_conditions"],
        pdpa: json["pdpa"],
        privacyPolicy: json["privacy_policy"],
        nda: json["nda"],
    );

    Map<dynamic, dynamic> toJson() => {
        "terms_and_conditions": termsAndConditions,
        "pdpa": pdpa,
        "privacy_policy": privacyPolicy,
        "nda": nda,
    };
}
