/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LanguageListModel languageListModelFromJson(String str) => LanguageListModel.fromJson(json.decode(str));

String languageListModelToJson(LanguageListModel data) => json.encode(data.toJson());

class LanguageListModel {
    LanguageListModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    LanguageListData data;
    String message;
    int httpcode;
    String status;

    factory LanguageListModel.fromJson(Map<dynamic, dynamic> json) => LanguageListModel(
        data: LanguageListData.fromJson(json["data"]),
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

class LanguageListData {
    LanguageListData({
        required this.languages,
    });

    Map<String, String> languages;

    factory LanguageListData.fromJson(Map<dynamic, dynamic> json) => LanguageListData(
        languages: Map.from(json["languages"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<dynamic, dynamic> toJson() => {
        "languages": Map.from(languages).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
