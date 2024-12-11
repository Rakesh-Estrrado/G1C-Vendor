class CountryCodeModel {
  CountryCodeModel({
      this.httpcode, 
      this.status, 
      this.message, 
      this.data,});

  CountryCodeModel.fromJson(dynamic json) {
    httpcode = json['httpcode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CountryData.fromJson(json['data']) : null;
  }
  int? httpcode;
  String? status;
  String? message;
  CountryData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['httpcode'] = httpcode;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class CountryData {
  CountryData({
      this.country,});

  CountryData.fromJson(dynamic json) {
    if (json['country'] != null) {
      country = [];
      json['country'].forEach((v) {
        country?.add(CountryCodes.fromJson(v));
      });
    }
  }
  List<CountryCodes>? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (country != null) {
      map['country'] = country?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CountryCodes {
  CountryCodes({
      this.id, 
      this.sortname, 
      this.countryName, 
      this.phonecode,});

  CountryCodes.fromJson(dynamic json) {
    id = json['id'];
    sortname = json['sortname'];
    countryName = json['country_name'];
    phonecode = json['phonecode'].toString();
  }
  int? id;
  String? sortname;
  String? countryName;
  String? phonecode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sortname'] = sortname;
    map['country_name'] = countryName;
    map['phonecode'] = phonecode;
    return map;
  }
}