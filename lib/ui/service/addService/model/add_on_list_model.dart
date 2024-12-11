/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

AddOnListModel addOnListModelFromJson(String str) => AddOnListModel.fromJson(json.decode(str));

String addOnListModelToJson(AddOnListModel data) => json.encode(data.toJson());

class AddOnListModel {
    AddOnListModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory AddOnListModel.fromJson(Map<dynamic, dynamic> json) => AddOnListModel(
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
        required this.addonList,
    });

    List<AddonList> addonList;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        addonList: List<AddonList>.from(json["addon_list"].map((x) => AddonList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "addon_list": List<dynamic>.from(addonList.map((x) => x.toJson())),
    };
}

class AddonList {
    AddonList({
        required this.name,
        required this.id,
    });

    String name;
    int id;

    factory AddonList.fromJson(Map<dynamic, dynamic> json) => AddonList(
        name: json["name"],
        id: json["id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
