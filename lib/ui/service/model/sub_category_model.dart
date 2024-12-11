/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
    SubCategoryModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory SubCategoryModel.fromJson(Map<dynamic, dynamic> json) => SubCategoryModel(
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
        required this.subcategories,
    });

    List<DataSubcategory> subcategories;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        subcategories: List<DataSubcategory>.from(json["subcategories"].map((x) => DataSubcategory.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
    };
}

class DataSubcategory {
    DataSubcategory({
        required this.categoryImage,
        required this.categoryName,
        required this.categoryId,
        required this.subcategory,
    });

    String categoryImage;
    String categoryName;
    int categoryId;
    List<Subcategory> subcategory;

    factory DataSubcategory.fromJson(Map<dynamic, dynamic> json) => DataSubcategory(
        categoryImage: json["category_image"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        subcategory: List<Subcategory>.from(json["subcategory"].map((x) => Subcategory.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "category_image": categoryImage,
        "category_name": categoryName,
        "category_id": categoryId,
        "subcategory": List<dynamic>.from(subcategory.map((x) => x.toJson())),
    };
}

class Subcategory {
    Subcategory({
        required this.subcategoryId,
        required this.subcategoryName,
        required this.subcategoryImage,
        required this.isChecked,
    });

    int subcategoryId;
    String subcategoryName;
    String subcategoryImage;
    bool isChecked;

    factory Subcategory.fromJson(Map<dynamic, dynamic> json) => Subcategory (
        subcategoryId: json["subcategory_id"],
        subcategoryName: json["subcategory_name"],
        subcategoryImage: json["subcategory_image"],
        isChecked: false,
    );

    Map<dynamic, dynamic> toJson() => {
        "subcategory_id": subcategoryId,
        "subcategory_name": subcategoryName,
        "subcategory_image": subcategoryImage,
        "isChecked": isChecked,
    };
}
