/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

RegionalListModel regionalListModelFromJson(String str) => RegionalListModel.fromJson(json.decode(str));

String regionalListModelToJson(RegionalListModel data) => json.encode(data.toJson());

class RegionalListModel {
    RegionalListModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    RegionalListData data;
    String message;
    int httpcode;
    String status;

    factory RegionalListModel.fromJson(Map<dynamic, dynamic> json) => RegionalListModel(
        data: RegionalListData.fromJson(json["data"]),
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

class RegionalListData {
    RegionalListData({
        required this.religions,
    });

    Map<String, String> religions;

    factory RegionalListData.fromJson(Map<dynamic, dynamic> json) => RegionalListData(
        religions: Map.from(json["religions"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<dynamic, dynamic> toJson() => {
        "religions": Map.from(religions).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
