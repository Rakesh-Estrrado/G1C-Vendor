/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

ServiceCategoriesModel serviceCategoriesModelFromJson(String str) => ServiceCategoriesModel.fromJson(json.decode(str));

String serviceCategoriesModelToJson(ServiceCategoriesModel data) => json.encode(data.toJson());

class ServiceCategoriesModel {
    ServiceCategoriesModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    ServiceCategoriesData data;
    String message;
    int httpcode;
    String status;

    factory ServiceCategoriesModel.fromJson(Map<dynamic, dynamic> json) => ServiceCategoriesModel(
        data: ServiceCategoriesData.fromJson(json["data"]),
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

class ServiceCategoriesData {
    ServiceCategoriesData({
        required this.categories,
    });

    Map<String, String> categories;

    factory ServiceCategoriesData.fromJson(Map<dynamic, dynamic> json) => ServiceCategoriesData(
        categories: Map.from(json["categories"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<dynamic, dynamic> toJson() => {
        "categories": Map.from(categories).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
