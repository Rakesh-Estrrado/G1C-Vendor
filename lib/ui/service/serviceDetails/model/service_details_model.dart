/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

ServiceDetailsModel serviceDetailsModelFromJson(String str) => ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) => json.encode(data.toJson());

class ServiceDetailsModel {
    ServiceDetailsModel({
        required this.preferenceData,
        required this.preferenceList,
        required this.serviceData,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    List<PreferenceData> preferenceData;
    List<PreferenceList> preferenceList;
    List<ServiceData> serviceData;
    String message;
    int httpcode;
    String status;

    factory ServiceDetailsModel.fromJson(Map<dynamic, dynamic> json) => ServiceDetailsModel(
        preferenceData: List<PreferenceData>.from(json["preference_data"].map((x) => PreferenceData.fromJson(x))),
        preferenceList: List<PreferenceList>.from(json["preference_list"].map((x) => PreferenceList.fromJson(x))),
        serviceData: List<ServiceData>.from(json["service_data"].map((x) => ServiceData.fromJson(x))),
        message: json["message"],
        httpcode: json["httpcode"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "preference_data": List<dynamic>.from(preferenceData.map((x) => x.toJson())),
        "preference_list": List<dynamic>.from(preferenceList.map((x) => x.toJson())),
        "service_data": List<dynamic>.from(serviceData.map((x) => x.toJson())),
        "message": message,
        "httpcode": httpcode,
        "status": status,
    };
}

class PreferenceData {
    PreferenceData({
        required this.preferenceId,
        required this.preferenceName,
        required this.selectedValues,
        required this.type,
    });

    int preferenceId;
    String preferenceName;
    String selectedValues;
    int type;

    factory PreferenceData.fromJson(Map<dynamic, dynamic> json) => PreferenceData(
        preferenceId: json["preference_id"],
        preferenceName: json["preference_name"],
        selectedValues: json["selected_values"],
        type: json["type"],
    );

    Map<dynamic, dynamic> toJson() => {
        "preference_id": preferenceId,
        "preference_name": preferenceName,
        "selected_values": selectedValues,
        "type": type,
    };
}

class PreferenceList {
    PreferenceList({
        required this.typeInfo,
        required this.values,
        required this.name,
        required this.isMandatory,
        required this.id,
        required this.type,
    });

    String typeInfo;
    List<Value> values;
    String name;
    int isMandatory;
    int id;
    int type;

    factory PreferenceList.fromJson(Map<dynamic, dynamic> json) => PreferenceList(
        typeInfo: json["type_info"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
        name: json["name"],
        isMandatory: json["is_mandatory"],
        id: json["id"],
        type: json["type"],
    );

    Map<dynamic, dynamic> toJson() => {
        "type_info": typeInfo,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "name": name,
        "is_mandatory": isMandatory,
        "id": id,
        "type": type,
    };
}

class Value {
    Value({
        required this.preferenceId,
        required this.checked,
        required this.valueId,
        required this.value,
    });

    int preferenceId;
    bool checked;
    int valueId;
    String value;

    factory Value.fromJson(Map<dynamic, dynamic> json) => Value(
        preferenceId: json["preference_id"],
        checked: json["checked"]==1,
        valueId: json["value_id"],
        value: json["value"],
    );

    Map<dynamic, dynamic> toJson() => {
        "preference_id": preferenceId,
        "checked": checked,
        "value_id": valueId,
        "value": value,
    };
}

class ServiceData {
    ServiceData({
        required this.serviceMedia,
        required this.serviceAddons,
        required this.serviceDescription,
        required this.servicePrice,
        required this.serviceName,
        required this.serviceTotalHours,
        required this.serviceDiscountPrice,
        required this.serviceCategory,
        required this.categoryId,
        required this.subCategoryId,
        required this.disStartDate,
        required this.disEndDate,

    });

    List<ServiceMedia> serviceMedia;
    List<ServiceAddon> serviceAddons;
    String serviceDescription;
    int servicePrice;
    String serviceName;
    int serviceDiscountPrice;
    int serviceTotalHours;
    String serviceCategory;
    int categoryId;
    int subCategoryId;
    String disStartDate;
    String disEndDate;

    factory ServiceData.fromJson(Map<dynamic, dynamic> json) => ServiceData(
        serviceMedia: List<ServiceMedia>.from(json["service_media"].map((x) => ServiceMedia.fromJson(x))),
        serviceAddons: List<ServiceAddon>.from(json["service_addons"].map((x) => ServiceAddon.fromJson(x))),
        serviceDescription: json["service_description"],
        servicePrice: json["service_price"],
        serviceTotalHours: json["service_total_hours"],
        serviceName: json["service_name"],
        serviceDiscountPrice: json["service_discount_price"]??0,
        serviceCategory: json["service_category"],
        categoryId: json["category_id"],
        subCategoryId: json["subcategory_id"],
        disStartDate: json["discount_start_date"],
        disEndDate: json["discount_end_date"],
    );

    Map<dynamic, dynamic> toJson() => {
        "service_media": List<dynamic>.from(serviceMedia.map((x) => x.toJson())),
        "service_addons": List<dynamic>.from(serviceAddons.map((x) => x.toJson())),
        "service_description": serviceDescription,
        "service_price": servicePrice,
        "service_name": serviceName,
        "service_discount_price": serviceDiscountPrice,
        "service_category": serviceCategory,
        "service_total_hours": serviceTotalHours,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "discount_start_date": disStartDate,
        "discount_end_date": disEndDate,
    };
}

class ServiceAddon {
    ServiceAddon({
        required this.addonName,
        required this.price,
        required this.id,
        required this.time,
        required this.addonId,
    });

    String addonName;
    int price;
    int id;
    int time;
    int addonId;

    factory ServiceAddon.fromJson(Map<dynamic, dynamic> json) => ServiceAddon(
        addonName: json["addon_name"],
        price: json["price"],
        id: json["id"],
        time: json["time"],
        addonId: json["addon_id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "addon_name": addonName,
        "price": price,
        "id": id,
        "time": time,
        "addon_id": addonId,
    };
}

class ServiceMedia {
    ServiceMedia({
        required this.filePath,
        required this.fileType,
        required this.id,
    });

    String filePath;
    String fileType;
    int id;

    factory ServiceMedia.fromJson(Map<dynamic, dynamic> json) => ServiceMedia(
        filePath: json["file_path"],
        fileType: json["file_type"],
        id: json["id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "file_path": filePath,
        "file_type": fileType,
        "id": id,
    };
}
