import 'dart:io';

import 'package:g1c_vendor/data/apiService.dart';
import 'package:g1c_vendor/ui/auth/login/model/login_model.dart';
import 'package:g1c_vendor/ui/auth/model/CountryCodeModel.dart';
import 'package:g1c_vendor/ui/auth/model/terms_and_conditions_model.dart';
import 'package:g1c_vendor/ui/bookings/bloc/model/booking_detail_model.dart';
import 'package:g1c_vendor/ui/bookings/bloc/model/booking_list_model.dart';
import 'package:g1c_vendor/ui/profile/createProfileSteps/scheduleTime/model/add_schedule_response.dart';
import 'package:g1c_vendor/ui/profile/model/account_model.dart';
import 'package:g1c_vendor/ui/service/addService/bloc/add_service_bloc.dart';
import 'package:g1c_vendor/ui/service/addService/model/add_on_list_model.dart';

import '../../ui/auth/login/model/login_o_t_p_model.dart';
import '../../ui/auth/model/register_model.dart';
import '../../ui/profile/createProfileSteps/model/language_list_model.dart';
import '../../ui/profile/createProfileSteps/model/regional_list_model.dart';
import '../../ui/profile/createProfileSteps/model/service_categories_model.dart';
import '../../ui/profile/createProfileSteps/scheduleTime/model/schdule_model.dart';
import '../../ui/service/addService/model/categories_model.dart';
import '../../ui/service/model/service_list_and_filter_model.dart';
import '../../ui/service/model/sub_category_model.dart';
import '../../ui/service/serviceDetails/model/service_details_model.dart';
import '../model/success_model.dart';

class Repository {
  final ApiService apiService = ApiService();

  Future<CountryCodeModel> getCountryCodes() async {
    return await apiService.getCountryCode();
  }

  Future<LoginModel> login(String phone, String countryCode) async {
    return await apiService.login(phone, countryCode);
  }

  Future<RegisterModel> register(String phone, String countryCode) async {
    return await apiService.register(phone, countryCode);
  }

  Future<ServiceListAndFilterModel> serviceListAndFilter(
      int pageNo,
      List<String> catId,
      List<String> subCatId,
      List<String> status,
      String search) async {
    return await apiService.serviceListAndFilter(
        pageNo, catId, subCatId, status, search);
  }

  Future<SubCategoryModel> getServiceSubCategories(int catId) async {
    return await apiService.getServiceSubCategories(catId);
  }

  Future<RegisterModel> verifyOTP(
      String phone, String countryCode, String otp) async {
    return await apiService.verifyOTP(phone, countryCode, otp);
  }

  Future<LoginOtpModel> verifyOTPLogin(
      String phone, String countryCode, String otp) async {
    return await apiService.verifyOTPLogin(phone, countryCode, otp);
  }

  Future<TermsAndConditionsModel> getTermsAndConditions() async {
    return await apiService.getTermsAndConditions();
  }

  Future<BookingListModel> getBookingList(String type, int pageNo) async {
    return await apiService.getBookingList(type, pageNo);
  }

  Future<BookingDetailModel> getBookingDetails(
      String type, int bookingId) async {
    return await apiService.getBookingDetails(type, bookingId);
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
      File? businessDocument5) async {
    return await apiService.createBusinessProfile(
        providerType,
        businessName,
        registrationNumber,
        directorName,
        email,
        phoneNumber,
        countryCode,
        serviceCategories,
        businessDescription,
        address,
        country,
        zipCode,
        latitude,
        longitude,
        landmark,
        bank,
        acNo,
        acHolder,
        logo,
        avatar,
        businessDocument1,
        businessDocument2,
        businessDocument3,
        businessDocument4,
        businessDocument5);
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
    return await apiService.createIndividualProfile(
        name,
        email,
        countryCode,
        phoneNumber,
        serviceCategories,
        individualDescription,
        address,
        country,
        building,
        zipCode,
        latitude,
        longitude,
        landmark,
        bank,
        acNo,
        acHolder,
        gender,
        dob,
        jobTitle,
        company,
        education,
        university,
        height,
        weight,
        drinking,
        smoking,
        religion,
        languages,
        hobbies,
        logo,
        avatar,
        businessDocument1,
        businessDocument2,
        businessDocument3,
        businessDocument4,
        businessDocument5);
  }

  Future<ServiceCategoriesModel> getServiceCategories() async {
    return await apiService.getServiceCategories();
  }

  Future<RegionalListModel> getRegionalList() async {
    return await apiService.getRegionalList();
  }

  Future<LanguageListModel> getLanguageList() async {
    return await apiService.getLanguageList();
  }

  Future<AddScheduleResponse> addScheduleTime(
      int sellerId,
      String dayOfWeek,
      String startTime,
      String endTime,
      String maxBookings,
      String slotType) async {
    return await apiService.addScheduleTime(
        sellerId, dayOfWeek, startTime, endTime, maxBookings, slotType);
  }

  Future<SuccessModel> deleteScheduleTime(int slotId) async {
    return await apiService.deleteScheduleTime(slotId);
  }

  Future<ScheduleModel> getScheduleTimeList(int sellerId) async {
    return await apiService.getScheduleTimeList(sellerId);
  }

  Future<CategoriesModel> getCategories() async {
    return await apiService.getCategories();
  }

  Future<AddOnListModel> getAddOnList() async {
    return await apiService.getAddOnLists();
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
    return await apiService.addServiceBasic(
        catId,
        subCatId,
        serviceName,
        description,
        totalHours,
        price,
        disPrice,
        startDate,
        endDate,
        addOnList);
  }

  Future<ServiceDetailsModel> getServiceDetails(int id) async {
    return await apiService.getServiceDetails(id);
  }

  /*Future<PreferenceListModel> getPreferenceList(int catId, int subCatId) async {
    return await apiService.getPreferenceList(catId,subCatId);
  }*/

  Future<SuccessModel> deleteService(int id) async {
    return await apiService.deleteService(id);
  }

  Future<SuccessModel> updateServiceStatus(int id) async {
    return await apiService.updateServiceStatus(id);
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
    return await apiService.updateServiceBasic(
        serviceId,
        catId,
        subCatId,
        serviceName,
        description,
        totalHours,
        price,
        disPrice,
        startDate,
        endDate,
        addOnList);
  }

  Future<SuccessModel> deleteServiceMedia(int serviceId, int fileId) async {
    return await apiService.deleteServiceMedia(serviceId, fileId);
  }

  Future<SuccessModel> updateServiceMedia(
      int serviceId, List<String> serviceFiles) async {
    return await apiService.updateServiceMedia(serviceId, serviceFiles);
  }

  Future<SuccessModel> removeAddOn(int serviceId, int id) async {
    return await apiService.removeAddOn(serviceId, id);
  }

  Future<SuccessModel> updatePreferences(
      int serviceId, List<PreferenceList> updatedPreferences) async {
    return await apiService.updatePreferences(serviceId, updatedPreferences);
  }

  Future<SuccessModel> submitServiceApproval(int serviceId) async {
    return await apiService.submitServiceApproval(serviceId);
  }

  Future<AccountModel> getAccountDetails() async {
    return await apiService.getAccountDetails();
  }

  Future<SuccessModel> updateAccountDetails(name, email, imageFile) async {
    return await apiService.updateAccountDetails(name, email, imageFile);
  }

  Future<SuccessModel> deleteBusinessDoc(int documentId) async {
    return await apiService.deleteBusinessDoc(documentId);
  }

  Future<SuccessModel> updateCompanyDetails(
      String businessName,
      String registrationNumber,
      int serviceCategories,
      String address,
      String landmark,
      imgLogo) async {
    return await apiService.updateCompanyDetails(businessName,
        registrationNumber, serviceCategories, address, landmark, imgLogo);
  }

  Future<SuccessModel> updateBankDetails(
      String bankName, String accName, String accNo) async {
    return await apiService.updateBankDetails(bankName, accName, accNo);
  }

  Future<SuccessModel> acceptRejectRequest(String action, int bookingId) async {
    return await apiService.acceptRejectRequest(action, bookingId);
  }

  Future<SuccessModel> completingBooking(
      int bookingId, int rating, String review) async {
    return await apiService.completeBooking(bookingId, rating, review);
  }
}
