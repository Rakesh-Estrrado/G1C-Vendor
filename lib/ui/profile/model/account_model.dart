/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

AccountModel accountModelFromJson(String str) => AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
    AccountModel({
        required this.data,
        required this.message,
        required this.httpcode,
        required this.status,
    });

    Data data;
    String message;
    int httpcode;
    String status;

    factory AccountModel.fromJson(Map<dynamic, dynamic> json) => AccountModel(
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
        required this.basicDetails,
        required this.businessDetails,
        required this.bankDetails,
        required this.individualDetails,
    });

    BasicDetails basicDetails;
    BusinessDetails businessDetails;
    BankDetails bankDetails;
    IndividualDetails individualDetails;

    factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
        basicDetails: BasicDetails.fromJson(json["basic_details"]),
        businessDetails: BusinessDetails.fromJson(json["business_details"]),
        bankDetails: BankDetails.fromJson(json["bank_details"]),
             individualDetails: IndividualDetails.fromJson(json["individual_details"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "basic_details": basicDetails.toJson(),
        "business_details": businessDetails.toJson(),
        "bank_details": bankDetails.toJson(),
        "individual_details": individualDetails.toJson(),
    };
}

class BankDetails {
    BankDetails({
        required this.acHolder,
        required this.bank,
        required this.acNo,
    });

    String acHolder;
    String bank;
    String acNo;

    factory BankDetails.fromJson(Map<dynamic, dynamic> json) => BankDetails(
        acHolder: json["ac_holder"],
        bank: json["bank"],
        acNo: json["ac_no"],
    );

    Map<dynamic, dynamic> toJson() => {
        "ac_holder": acHolder,
        "bank": bank,
        "ac_no": acNo,
    };
}

class BasicDetails {
    BasicDetails({
        required this.providerType,
        required this.fname,
        required this.businessName,
        required this.countryCode,
        required this.lname,
        required this.phone,
        required this.logo,
        required this.individualName,
        required this.avatar,
        required this.sellerId,
        required this.email,
    });

    String providerType;
    String fname;
    String businessName;
    String countryCode;
    String lname;
    String phone;
    String logo;
    String individualName;
    String avatar;
    int sellerId;
    String email;

    factory BasicDetails.fromJson(Map<dynamic, dynamic> json) => BasicDetails(
        providerType: json["provider_type"],
        fname: json["fname"],
        businessName: json["business_name"],
        countryCode: json["country_code"],
        lname: json["lname"],
        phone: json["phone"],
        logo: json["logo"],
        individualName: json["individual_name"],
        avatar: json["avatar"],
        sellerId: json["seller_id"],
        email: json["email"],
    );

    Map<dynamic, dynamic> toJson() => {
        "provider_type": providerType,
        "fname": fname,
        "business_name": businessName,
        "country_code": countryCode,
        "lname": lname,
        "phone": phone,
        "logo": logo,
        "individual_name": individualName,
        "avatar": avatar,
        "seller_id": sellerId,
        "email": email,
    };
}

class IndividualDetails {
    IndividualDetails({
        required this.education,
        required this.drinking,
        required this.dob,
        required this.gender,
        required this.languages,
        required this.university,
        required this.weight,
        required this.individualName,
        required this.religion,
        required this.hobbies,
        required this.smoking,
        required this.company,
        required this.jobTitle,
        required this.height,
    });

    String education;
    int drinking;
    String gender;
    String dob;
    List<String> languages;
    String university;
    int weight;
    String individualName;
    int religion;
    String hobbies;
    int smoking;
    String company;
    String jobTitle;
    int height;

    factory IndividualDetails.fromJson(Map<dynamic, dynamic> json) => IndividualDetails(
        education: json["education"]??"",
        drinking: json["drinking"]??0,
        gender: json["gender"]??"",
        dob: json["dob"]??"",
        languages: json["languages"]==null?[]:List<String>.from(json["languages"].map((x) => x)),
        university: json["university"]??"",
        weight: json["weight"]??0,
        individualName: json["individual_name"]??"",
        religion: json["religion"]??0,
        hobbies:json["hobbies"]??"",
        smoking: json["smoking"]??0,
        company: json["company"]??"",
        jobTitle: json["job_title"]??"",
        height: json["height"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "education": education,
        "drinking": drinking,
        "gender": gender,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "university": university,
        "weight": weight,
        "individual_name": individualName,
        "religion": religion,
        "hobbies": hobbies,
        "smoking": smoking,
        "company": company,
        "job_title": jobTitle,
        "height": height,
        "dob": dob,
    };
}


class BusinessDetails {
    BusinessDetails({
        required this.businessName,
        required this.address,
        required this.categoryId,
        required this.registrationNumber,
        required this.logo,
        required this.landmark,
        required this.building,
        required this.businessDocuments,
    });

    String businessName;
    String address;
    int categoryId;
    String registrationNumber;
    String logo;
    String landmark;
    String building;
    List<BusinessDocument> businessDocuments;

    factory BusinessDetails.fromJson(Map<dynamic, dynamic> json) => BusinessDetails(
        businessName: json["business_name"]??"",
        address: json["address"]??"",
        categoryId: json["category_id"]??0,
        registrationNumber: json["registration_number"]??"",
        logo: json["logo"]??"",
        landmark: json["landmark"]??"",
        building: json["building"]??"",
        businessDocuments: json["business_documents"]!=null?List<BusinessDocument>.from(json["business_documents"].map((x) => BusinessDocument.fromJson(x))):[],
    );

    Map<dynamic, dynamic> toJson() => {
        "business_name": businessName,
        "address": address,
        "category_id": categoryId,
        "registration_number": registrationNumber,
        "logo": logo,
        "landmark": landmark,
        "building": building,
        "business_documents": List<dynamic>.from(businessDocuments.map((x) => x.toJson())),
    };
}


class BusinessDocument {
    BusinessDocument({
        required this.file,
        required this.id,
    });

    String file;
    int id;

    factory BusinessDocument.fromJson(Map<dynamic, dynamic> json) => BusinessDocument(
        file: json["file"]??"",
        id: json["id"]??0,
    );

    Map<dynamic, dynamic> toJson() => {
        "file": file,
        "id": id,
    };
}