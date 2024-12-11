/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

import '../../model/service_list_and_filter_model.dart';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
    CategoriesModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory CategoriesModel.fromJson(Map<dynamic, dynamic> json) => CategoriesModel(
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
        required this.categoryList,
    });

    List<CategoryList> categoryList;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        categoryList: List<CategoryList>.from(json["category_list"].map((x) => CategoryList.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "category_list": List<dynamic>.from(categoryList.map((x) => x.toJson())),
    };
}

