/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

ServiceListAndFilterModel serviceListAndFilterModelFromJson(String str) => ServiceListAndFilterModel.fromJson(json.decode(str));

String serviceListAndFilterModelToJson(ServiceListAndFilterModel data) => json.encode(data.toJson());

class ServiceListAndFilterModel {
    ServiceListAndFilterModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory ServiceListAndFilterModel.fromJson(Map<dynamic, dynamic> json) => ServiceListAndFilterModel(
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
        required this.pagination,
        required this.servicesList,
        required this.filterData,
    });

    Pagination pagination;
    List<ServicesList> servicesList;
    FilterData filterData;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        pagination: Pagination.fromJson(json["pagination"]),
        servicesList: List<ServicesList>.from(json["services_list"].map((x) => ServicesList.fromJson(x))),
        filterData: FilterData.fromJson(json["filter_data"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "pagination": pagination.toJson(),
        "services_list": List<dynamic>.from(servicesList.map((x) => x.toJson())),
        "filter_data": filterData.toJson(),
    };
}

class FilterData {
    FilterData({
        required this.categoryList,
        required this.approvalStatus,
    });

    List<CategoryList> categoryList;
    List<ApprovalStatus> approvalStatus;

    factory FilterData.fromJson(Map<dynamic, dynamic> json) => FilterData(
        categoryList: List<CategoryList>.from(json["category_list"].map((x) => CategoryList.fromJson(x))),
        approvalStatus: List<ApprovalStatus>.from(json["approval_status"].map((x) => ApprovalStatus.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "category_list": List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "approval_status": List<dynamic>.from(approvalStatus.map((x) => x.toJson())),
    };
}

class ApprovalStatus {
    ApprovalStatus({
        required this.status,
        required this.isChecked,
    });

    String status;
    bool isChecked;

    factory ApprovalStatus.fromJson(Map<dynamic, dynamic> json) => ApprovalStatus(
        status: json["status"],
        isChecked: false
    );

    Map<dynamic, dynamic> toJson() => {
        "status": status,
        "isChecked": isChecked,
    };
}

class CategoryList {
    CategoryList({
        required this.categoryImage,
        required this.categoryName,
        required this.categoryId,
        required this.isChecked,
    });

    String categoryImage;
    String categoryName;
    int categoryId;
    bool isChecked;

    factory CategoryList.fromJson(Map<dynamic, dynamic> json) => CategoryList(
        categoryImage: json["category_image"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        isChecked: false,
    );

    Map<dynamic, dynamic> toJson() => {
        "category_image": categoryImage,
        "category_name": categoryName,
        "category_id": categoryId,
        "isChecked": isChecked,
    };
}

class Pagination {
    Pagination({
        required this.perPage,
        required this.totalServices,
        required this.lastPage,
        required this.currentPage,
    });

    String perPage;
    int totalServices;
    int lastPage;
    int currentPage;

    factory Pagination.fromJson(Map<dynamic, dynamic> json) => Pagination(
        perPage: json["per_page"].toString(),
        totalServices: json["total_services"]??0,
        lastPage: json["last_page"]??0,
        currentPage: json["current_page"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "per_page": perPage,
        "total_services": totalServices,
        "last_page": lastPage,
        "current_page": currentPage,
    };
}

class ServicesList {
    ServicesList({
        required this.subcategoryId,
        required this.image,
        required this.categoryId,
        required this.price,
        required this.approvalStatus,
        required this.id,
        required this.title,
        required this.category,
        required this.subcategory,
        required this.salePrice,
        required this.status,
    });

    int subcategoryId;
    String image;
    int categoryId;
    int price;
    int approvalStatus;
    int id;
    String title;
    String category;
    String subcategory;
    int salePrice;
    int status;

    factory ServicesList.fromJson(Map<dynamic, dynamic> json) => ServicesList(
        subcategoryId: json["subcategory_id"],
        image: json["image"],
        categoryId: json["category_id"],
        price: json["price"],
        approvalStatus: json["approval_status"],
        id: json["id"],
        title: json["title"],
        category: json["category"],
        subcategory: json["subcategory"],
        salePrice: json["sale_price"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "subcategory_id": subcategoryId,
        "image": image,
        "category_id": categoryId,
        "price": price,
        "approval_status": approvalStatus,
        "id": id,
        "title": title,
        "category": category,
        "subcategory": subcategory,
        "sale_price": salePrice,
        "status": status,
    };
}
