import 'dart:io';

import 'package:dio/dio.dart';
import 'package:g1c_vendor/di/AppLocator.dart';
import 'package:g1c_vendor/ui/auth/login/model/login_model.dart';
import 'package:g1c_vendor/ui/auth/model/CountryCodeModel.dart';
import 'package:g1c_vendor/ui/service/addService/bloc/add_service_bloc.dart';
import 'package:g1c_vendor/ui/service/addService/model/add_on_list_model.dart';
import 'package:g1c_vendor/ui/service/addService/model/categories_model.dart';
import 'package:g1c_vendor/ui/service/serviceDetails/model/service_details_model.dart';
import 'package:g1c_vendor/utils/loader.dart';
import 'package:g1c_vendor/utils/navigator_service.dart';
import 'package:g1c_vendor/utils/sessionManager.dart';
import 'package:g1c_vendor/utils/utils.dart';

import '../ui/auth/login/model/login_o_t_p_model.dart';
import '../ui/auth/model/register_model.dart';
import '../ui/auth/model/terms_and_conditions_model.dart';
import '../ui/profile/createProfileSteps/model/language_list_model.dart';
import '../ui/profile/createProfileSteps/model/regional_list_model.dart';
import '../ui/profile/createProfileSteps/model/service_categories_model.dart';
import '../ui/profile/createProfileSteps/scheduleTime/model/add_schedule_response.dart';
import '../ui/profile/createProfileSteps/scheduleTime/model/schdule_model.dart';
import '../ui/profile/model/account_model.dart';
import '../ui/service/model/service_list_and_filter_model.dart';
import '../ui/service/model/sub_category_model.dart';
import 'model/success_model.dart';

class ApiService {
  // String baseUrl = "https://uat-g1c.estrradoweb.com/sellers/api";
  String baseUrl = "https://qa-g1c.estrradoweb.com/sellers/api";

  final SessionManager sessionManager = AppLocator.instance<SessionManager>();
  Map<String, Set<String>> handledErrors = {};
  bool errorCaptured = false;
  Dio dio = Dio();

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException error, handler) {
        if (error.response?.statusCode == 401) {
          closeLoaderDialog();
          if (!errorCaptured) {
            NavigatorService.goBack();
            errorCaptured = true;
          }
          Future.delayed(Duration(seconds: 2), () {
            errorCaptured = false;
          });

          return;
        } else if (error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.sendTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          closeLoaderDialog();
          if (!errorCaptured) {
            NavigatorService.pushToNoInternet();
            errorCaptured = true;
          }
          Future.delayed(Duration(seconds: 2), () {
            errorCaptured = false;
          });
          return;
        } else {
          handler.next(error);
        }
      },
    ));

    dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true));
  }

  Future<CountryCodeModel> getCountryCode() async {
    try {
      print("api call");
      final response = await dio.post("$baseUrl/country-codes",
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return CountryCodeModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<LoginModel> login(String phone, String countryCode) async {
    try {
      var deviceInfo = await getDeviceDetails();
      final response = await dio.post("$baseUrl/seller/login-phone",
          data: {
            "phone": phone,
            "isd_code": countryCode.replaceAll("+", ""),
            "deviceToken": "UnKnown",
            "deviceId": deviceInfo['deviceId'],
            "deviceName": deviceInfo['deviceName'],
            "os": Platform.isAndroid ? "ANDROID" : "IOS"
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return LoginModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<RegisterModel> register(String phone, String countryCode) async {
    try {
      final response = await dio.post(
        "$baseUrl/seller/generate-register-otp",
        data: {"phone": phone, "country_code": countryCode},
      );
      return RegisterModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<ServiceListAndFilterModel> serviceListAndFilter(
      int pageNo,
      List<String> catId,
      List<String> subCatId,
      List<String> status,
      String search) async {
    var selectedCatId = catId.join(',');
    var selectedSubCatId = subCatId.join(',');
    var selectedStatus = status.join(',');
    try {
      final response = await dio.post(
        "$baseUrl/seller/services-list",
        data: {
          "access_token": sessionManager.token,
          "limit": 10,
          "page": pageNo,
          "category_id": selectedCatId,
          "subcategory_id": selectedSubCatId,
          "status": selectedStatus,
          "keyword": search
        },
      );
      return ServiceListAndFilterModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SubCategoryModel> getServiceSubCategories(int catId) async {
    try {
      final response =
          await dio.post("$baseUrl/seller/subcategory-list", data: {
        "access_token": sessionManager.token,
        "category_id": catId == 0 ? "" : catId,
      });
      return SubCategoryModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<RegisterModel> verifyOTP(
      String phoneNumber, String countryCode, String otp) async {
    try {
      final response = await dio.post("$baseUrl/seller/verify-register-otp",
          data: {
            "phone_number": phoneNumber,
            "country_code": countryCode,
            "otp": otp
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return RegisterModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<LoginOtpModel> verifyOTPLogin(
      String phoneNumber, String countryCode, String otp) async {
    try {

      var deviceInfo = await getDeviceDetails();
      final response = await dio.post("$baseUrl/seller/confirm-otp",
          data: {
            "otp": otp,
            "seller_id": sessionManager.sellerId,
            "deviceToken": "UNKNOWN",
            "deviceId": deviceInfo["deviceId"],
            "deviceName": deviceInfo["deviceName"],
            "os": Platform.isAndroid ? "ANDROID" : "IOS"
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return LoginOtpModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<TermsAndConditionsModel> getTermsAndConditions() async {
    try {
      final response = await dio.post("$baseUrl/seller/terms-conditions",
          data: {"type": "seller"},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return TermsAndConditionsModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<ServiceCategoriesModel> getServiceCategories() async {
    try {
      final response = await dio.get("$baseUrl/seller/service-categories",
          data: {"type": "seller"},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return ServiceCategoriesModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<RegionalListModel> getRegionalList() async {
    try {
      final response = await dio.get("$baseUrl/seller/religions",
          data: {"type": "seller"},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return RegionalListModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<LanguageListModel> getLanguageList() async {
    try {
      final response = await dio.get("$baseUrl/seller/languages",
          data: {"type": "seller"},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return LanguageListModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> createBusinessProfile(
    String providerType,
    String businessName,
    String registrationNumber,
    String directorName,
    String email,
    String phoneNumber,
    String countryCode,
    String serviceCategories,
    String businessDescription,
    String address,
    String country,
    String zipCode,
    String latitude,
    String longitude,
    String landmark,
    String bank,
    String acNo,
    String acHolder,
    File? logo,
    File? avatar,
    File? businessDocument1,
    File? businessDocument2,
    File? businessDocument3,
    File? businessDocument4,
    File? businessDocument5,
  ) async {
    var formData = FormData.fromMap({
      'logo': logo == null
          ? null
          : await MultipartFile.fromFile(logo.path, filename: "logo"),
      'avatar': avatar == null
          ? null
          : await MultipartFile.fromFile(avatar.path, filename: "avatar"),
      'business_document_1': businessDocument1 == null
          ? null
          : await MultipartFile.fromFile(businessDocument1.path,
              filename: "business_document_1"),
      'business_document_2': businessDocument2 == null
          ? null
          : await MultipartFile.fromFile(businessDocument2.path,
              filename: "business_document_2"),
      'business_document_3': businessDocument3 == null
          ? null
          : await MultipartFile.fromFile(businessDocument3.path,
              filename: "business_document_3"),
      'business_document_4': businessDocument4 == null
          ? null
          : await MultipartFile.fromFile(businessDocument4.path,
              filename: "business_document_4"),
      'business_document_5': businessDocument5 == null
          ? null
          : await MultipartFile.fromFile(businessDocument5.path,
              filename: "business_document_5"),
      "provider_type": providerType,
      "business_name": businessName,
      "registration_number": registrationNumber,
      "director_name": directorName,
      "email": email,
      "phone_number": phoneNumber,
      "country_code": countryCode,
      "service_categories": serviceCategories,
      "business_description": businessDescription,
      "address": address,
      "country": country,
      "zip_code": zipCode,
      "latitude": latitude,
      "longitude": longitude,
      "landmark": landmark,
      "bank": bank,
      "ac_no": acNo,
      "ac_holder": acHolder,
    });

    print("FormData Fields:");
    formData.fields.forEach((field) {
      print("${field.key}: ${field.value}");
    });

    print("\nFormData Files:");
    formData.files.forEach((file) {
      print("${file.key}: ${file.value.filename}, ${file.value.contentType}");
    });

    try {
      final response = await dio.post("$baseUrl/seller/business-register",
          data: formData,
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> createIndividualProfile(
    String name,
    String email,
    String countryCode,
    String phoneNumber,
    String serviceCategories,
    String individualDescription,
    String address,
    String country,
    String building,
    String zipCode,
    String latitude,
    String longitude,
    String landmark,
    String bank,
    String acNo,
    String acHolder,
    String gender,
    String dob,
    String jobTitle,
    String company,
    String education,
    String university,
    String height,
    String weight,
    String drinking,
    String smoking,
    String religion,
    String languages,
    String hobbies,
    File? logo,
    File? avatar,
    File? businessDocument1,
    File? businessDocument2,
    File? businessDocument3,
    File? businessDocument4,
    File? businessDocument5,
  ) async {
    var formData = FormData.fromMap({
      'logo': logo == null
          ? null
          : await MultipartFile.fromFile(logo.path, filename: "logo"),
      'avatar': avatar == null
          ? null
          : await MultipartFile.fromFile(avatar.path, filename: "avatar"),
      'business_document_1': businessDocument1 == null
          ? null
          : await MultipartFile.fromFile(businessDocument1.path,
              filename: "business_document_1"),
      'business_document_2': businessDocument2 == null
          ? null
          : await MultipartFile.fromFile(businessDocument2.path,
              filename: "business_document_2"),
      'business_document_3': businessDocument3 == null
          ? null
          : await MultipartFile.fromFile(businessDocument3.path,
              filename: "business_document_3"),
      'business_document_4': businessDocument4 == null
          ? null
          : await MultipartFile.fromFile(businessDocument4.path,
              filename: "business_document_4"),
      'business_document_5': businessDocument5 == null
          ? null
          : await MultipartFile.fromFile(businessDocument5.path,
              filename: "business_document_5"),
      "provider_type": "individual",
      "individual_name": name,
      "email": email,
      "country_code": countryCode,
      "phone_number": phoneNumber,
      "service_categories": serviceCategories,
      "individual_description": individualDescription,
      "address": address,
      "country": country,
      "building": building,
      "zip_code": zipCode,
      "latitude": latitude,
      "longitude": longitude,
      "landmark": landmark,
      "bank": bank,
      "ac_no": acNo,
      "ac_holder": acHolder,
      "gender": gender,
      "dob": dob,
      "job_title": jobTitle,
      "company": company,
      "education": education,
      "university": university,
      "height": height,
      "weight": weight,
      "drinking": drinking,
      "smoking": smoking,
      "religion": religion,
      "languages": languages,
      "hobbies": hobbies,
    });

    formData.fields.forEach((field) {
      print("${field.key}: ${field.value}");
    });

    formData.files.forEach((file) {
      print("${file.key}: ${file.value.filename}, ${file.value.contentType}");
    });
    try {
      final response = await dio.post("$baseUrl/seller/individual-register",
          data: formData,
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<AddScheduleResponse> addScheduleTime(
      int sellerId,
      String dayOfWeek,
      String startTime,
      String endTime,
      String maxBookings,
      String slotType) async {
    try {
      final response = await dio.post("$baseUrl/seller/schedules/add",
          data: {
            "seller_id": sellerId,
            "day_of_week": dayOfWeek,
            "start_time": startTime,
            "end_time": endTime,
            "max_bookings": maxBookings,
            "slot_type": slotType,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return AddScheduleResponse.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> deleteScheduleTime(int slotId) async {
    try {
      final response = await dio.post("$baseUrl/seller/schedules/delete",
          data: {"slot_id": slotId},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<ScheduleModel> getScheduleTimeList(int sellerId) async {
    try {
      final response = await dio.post("$baseUrl/seller/schedules",
          data: {"seller_id": sellerId},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return ScheduleModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<CategoriesModel> getCategories() async {
    try {
      final response = await dio.post("$baseUrl/seller/category-list",
          data: {"access_token": sessionManager.token},
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return CategoriesModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<AddOnListModel> getAddOnLists() async {
    try {
      final response = await dio.post("$baseUrl/seller/addon-list",
          data: {"access_token": sessionManager.token});
      return AddOnListModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> addServiceBasic(
      int catId,
      int subCatId,
      String serviceName,
      String description,
      String totalHours,
      String price,
      String disPrice,
      String startDate,
      String endDate,
      List<AddServiceAddOns> addOnList) async {
    try {
      FormData data = FormData.fromMap(
      {
        "access_token": sessionManager.token,
        "category_id": catId,
        "subcategory_id": subCatId,
        "service_name": serviceName,
        "description": description,
        "total_hours": totalHours,
        "price": price,
        "discount_price": disPrice,
        "discount_start_date": startDate,
        "discount_end_date": endDate,
        "save_as_draft": 1,

        ...addOnList
            .asMap()
            .map((i, addon) => MapEntry("addons[$i][addon_id]", addon.id))
          ..addAll(addOnList
              .asMap()
              .map((i, addon) => MapEntry("addons[$i][time]", addon.time.text)))
          ..addAll(addOnList
              .asMap()
              .map((i, addon) => MapEntry("addons[$i][price]", addon.price.text))),
      });


      final response =
          await dio.post("$baseUrl/seller/add-service-basic-details",
              data: data,
              options: Options(
                headers: {
                  'Authorization': "Bearer ${sessionManager.token}",
                  'Other-Header': 'Header-Value',
                },
              ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

/*
  Future<PreferenceListModel> getPreferenceList(int catId,int subCatId) async {
    try {

      final response = await dio.post("$baseUrl/seller/service-preferences-list",
          data: {
            "access_token":sessionManager.token,
            "category_id":catId,
            "subcategory_id":subCatId,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return PreferenceListModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }*/

  Future<SuccessModel> deleteService(int id) async {
    try {
      final response = await dio.post("$baseUrl/seller/delete-service",
          data: {
            "access_token": sessionManager.token,
            "service_id": id,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> updateServiceStatus(int id) async {
    try {
      final response = await dio.post("$baseUrl/seller/services-change_status",
          data: {
            "access_token": sessionManager.token,
            "service_id": id,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<ServiceDetailsModel> getServiceDetails(int id) async {
    try {
      final response = await dio.post("$baseUrl/seller/services-details",
          data: {
            "access_token": sessionManager.token,
            "service_id": id,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return ServiceDetailsModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> deleteServiceMedia(int serviceId, int fileId) async {
    try {
      final response = await dio.post("$baseUrl/seller/remove-media",
          data: {
            "access_token": sessionManager.token,
            "service_id": serviceId,
            "file_id": fileId,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> removeAddOn(int serviceId, int id) async {
    try {
      final response = await dio.post("$baseUrl/seller/remove-addon",
          data: {
            "access_token": sessionManager.token,
            "service_id": serviceId,
            "addon_id": id,
          },
          options: Options(
            headers: {
              'Authorization': "Bearer ${sessionManager.token}",
              'Other-Header': 'Header-Value',
            },
          ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> updatePreferences(
      int serviceId, List<PreferenceList> updatedPreferences) async {
    try {
      // Initialize FormData
      FormData formData = FormData.fromMap(
          {"access_token": sessionManager.token, "service_id": serviceId});

      for (int i = 0; i < updatedPreferences.length; i++) {
        final preference = updatedPreferences[i];

        if (preference.values.any((e) => e.checked)) {
          var selectedIds = preference.values
              .where((e) => e.checked)
              .map((e) => e.valueId)
              .join(',');
          var values = preference.values
              .where((e) => e.checked)
              .map((e) => e.value)
              .join(',');

          formData.fields.addAll([
            MapEntry("preference_values[${preference.id}][type]",
                preference.type.toString()),
            MapEntry(
                "preference_values[${preference.id}][value_id]", selectedIds),
            MapEntry("preference_values[${preference.id}][value]", values),
          ]);
        }
      }

      // Send request
      final response = await dio.post(
        "$baseUrl/seller/update-service-preference",
        data: formData,
        options: Options(
          headers: {
            'Authorization': "Bearer ${sessionManager.token}",
          },
        ),
      );

      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed: $error');
    }
  }

  Future<SuccessModel> updateServiceBasic(
      int serviceId,
      int catId,
      int subCatId,
      String serviceName,
      String description,
      String totalHours,
      String price,
      String disPrice,
      String startDate,
      String endDate,
      List<ServiceAddon> addOnList) async {
    try {
      final data = FormData.fromMap({
        "access_token": sessionManager.token,
        "service_id": serviceId,
        "category_id": catId,
        "subcategory_id": subCatId,
        "service_name": serviceName,
        "description": description,
        "total_hours": totalHours,
        "price": price,
        "discount_price": disPrice,
        "discount_start_date": startDate.toYMD(),
        "discount_end_date": endDate.toYMD(),
        "save_as_draft": 1,
        // Add dynamic fields for addons
        ...addOnList
            .asMap()
            .map((i, addon) => MapEntry("addons[$i][addon_id]", addon.id))
          ..addAll(addOnList
              .asMap()
              .map((i, addon) => MapEntry("addons[$i][time]", addon.time)))
          ..addAll(addOnList
              .asMap()
              .map((i, addon) => MapEntry("addons[$i][price]", addon.price))),
      });

      final response =
          await dio.post("$baseUrl/seller/update-service-basic-details",
              data: data,
              options: Options(
                headers: {
                  'Authorization': "Bearer ${sessionManager.token}",
                  'Other-Header': 'Header-Value',
                },
              ));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> updateServiceMedia(
      int serviceId, List<String> serviceFiles) async {
    try {
      List<MultipartFile> fileList = [];
      for (var filePath in serviceFiles) {
        fileList.add(await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last));
      }

      var formData = FormData.fromMap({
        "access_token": sessionManager.token,
        "service_id": serviceId,
        "file[]": fileList,
      });

      // Send the POST request
      final response = await dio.post("$baseUrl/seller/update-service-media",
          data: formData);

      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to update service media: $error');
    }
  }

  Future<SuccessModel> submitServiceApproval(int serviceId) async {
    try {
      final data = {
        "access_token": sessionManager.token,
        "service_id": serviceId,
      };
      final response =
          await dio.post("$baseUrl/seller/submit-service", data: data);
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<AccountModel> getAccountDetails() async {
    try {
      final response = await dio.post("$baseUrl/seller/account-details", data: {
        "access_token": sessionManager.token,
        "seller_id": sessionManager.sellerId,
      });
      return AccountModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> updateAccountDetails(
      String name, String email, String imagePath) async {
    var formData = FormData.fromMap({
      'avatar': imagePath.isEmpty
          ? ""
          : await MultipartFile.fromFile(imagePath, filename: "avatar"),
      "access_token": sessionManager.token,
      "seller_id": sessionManager.sellerId,
      "business_name": name,
      "email": email,
    });
    try {
      final response = await dio.post("$baseUrl/seller/update-basic-details",
          data: formData);
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> deleteBusinessDoc(int documentId) async {
    try {
      final response =
          await dio.post("$baseUrl/seller/delete-business-document", data: {
        "access_token": sessionManager.token,
        "seller_id": sessionManager.sellerId,
        "doc_id": documentId
      });
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> updateCompanyDetails(
      String businessName,
      String registrationNumber,
      int serviceCategories,
      String address,
      String landmark,
      String imgLogo) async {
    try {
      final response = await dio.post("$baseUrl/seller/update-business-details",
          data: FormData.fromMap({
            'logo': imgLogo.isEmpty
                ? ""
                : await MultipartFile.fromFile(imgLogo, filename: "logo"),
            "access_token": sessionManager.token,
            "seller_id": sessionManager.sellerId,
            "business_name": businessName,
            "registration_number": registrationNumber,
            "service_categories": serviceCategories,
            "address": address,
            "latitude": "",
            "longitude": "",
            "landmark": landmark,
          }));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }

  Future<SuccessModel> updateBankDetails(
      String bankName, String accName, String accNo) async {
    try {
      final response = await dio.post("$baseUrl/seller/update-bank-details",
          data: FormData.fromMap({
            "access_token": sessionManager.token,
            "seller_id": sessionManager.sellerId,
            "bank": bankName,
            "ac_no": accNo,
            "ac_holder": accName
          }));
      return SuccessModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed  $error');
    }
  }
}
