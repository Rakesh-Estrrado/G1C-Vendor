import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:g1c_vendor/di/AppLocator.dart';
import 'package:g1c_vendor/ui/profile/createProfileSteps/scheduleTime/model/add_schedule_response.dart';
import 'package:g1c_vendor/utils/sessionManager.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../data/model/success_model.dart';
import '../../../../data/repository/Repository.dart';
import '../../../../utils/loader.dart';
import '../../../../utils/utils.dart';
import '../../createProfile.dart';
import '../model/language_list_model.dart';
import '../model/regional_list_model.dart';
import '../model/service_categories_model.dart';
import '../scheduleTime/model/schdule_model.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(BuildContext context)
      : super(ProfileState(
          businessNameController: TextEditingController(),
          registrationNumberController: TextEditingController(),
          directorNameController: TextEditingController(),
          emailController: TextEditingController(),
          phoneNoController: TextEditingController(),
          descriptionController: TextEditingController(),
          bankNameController: TextEditingController(),
          bankAccNoController: TextEditingController(),
          bankAccNameController: TextEditingController(),
          buildingNoController: TextEditingController(),
          landMarkController: TextEditingController(),
          dobController: TextEditingController(),
          titleController: TextEditingController(),
          companyController: TextEditingController(),
          programNameController: TextEditingController(),
          universityController: TextEditingController(),
          heightController: TextEditingController(),
          weightController: TextEditingController(),
          hobbiesController: TextEditingController(),
          countryCode: TextEditingController(),
        )) {
    final  sessionManager = AppLocator.instance<SessionManager>();
    on<CreateBusinessProfile>((event, emit) async {
      try {
        showLoaderDialog();
        List<String> serviceTypes =
            state.serviceCategoriesData?.categories.keys.toList() ?? [];

        SuccessModel response = await Repository().createBusinessProfile(
            "Business",
            state.businessNameController!.text,
            state.registrationNumberController!.text,
            state.directorNameController!.text,
            state.emailController!.text,
            state.phoneNoController!.text,
            state.countryCode!.text,
            state.selectedServiceId ?? serviceTypes[0],
            state.descriptionController!.text,
            state.address,
            state.country ?? "",
            state.zipCode ?? "",
            state.lat ?? "",
            state.long ?? "",
            state.landMarkController!.text,
            state.bankNameController!.text,
            state.bankAccNoController!.text,
            state.bankAccNameController!.text,
            state.logo,
            state.avatar,
            state.docs.length > 0 ? state.docs[0] : null,
            state.docs.length > 1 ? state.docs[1] : null,
            state.docs.length > 2 ? state.docs[2] : null,
            state.docs.length > 3 ? state.docs[3] : null,
            state.docs.length > 4 ? state.docs[4] : null);
        closeLoaderDialog();

        if (response.httpcode == "200") {
          emit(state.copyWith(
              selectedTab: state.selectedTab + 1,
              sellerId: response.data.sellerId));
          showSnackBar(context: context, msg: "${response.message}");
        } else {
          showSnackBar(context: context, msg: "${response.message}");
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<CreateIndividualProfile>((event, emit) async {
      try {
        showLoaderDialog();
        List<String> serviceTypes =
            state.serviceCategoriesData?.categories.keys.toList() ?? [];
        List<String> language =
            state.languageListData?.languages.keys.toList() ?? [];
        List<String> religion =
            state.regionalListData?.religions.keys.toList() ?? [];

        SuccessModel response = await Repository().createIndividualProfile(
            state.businessNameController!.text,
            state.emailController!.text,
            state.countryCode!.text,
            state.phoneNoController!.text,
            state.selectedServiceId ?? serviceTypes[0],
            state.descriptionController!.text,
            state.address,
            state.country ?? "",
            state.buildingNoController!.text,
            state.zipCode ?? "",
            state.lat ?? "",
            state.long ?? "",
            state.landMarkController!.text,
            state.bankNameController!.text,
            state.bankAccNoController!.text,
            state.bankAccNameController!.text,
            state.selectedGender,
            state.dobController!.text,
            state.titleController!.text,
            state.companyController!.text,
            state.programNameController!.text,
            state.universityController!.text,
            state.heightController!.text,
            state.weightController!.text,
            state.selectedDrinking ?? "Occasionally",
            state.selectedSmoking ?? "Non-Smoker",
            state.selectedReligion ?? religion[0],
            state.selectedLanguages ?? language[0],
            state.hobbiesController!.text,
            state.logo,
            state.avatar,
            state.docs.length > 0 ? state.docs[0] : null,
            state.docs.length > 1 ? state.docs[1] : null,
            state.docs.length > 2 ? state.docs[2] : null,
            state.docs.length > 3 ? state.docs[3] : null,
            state.docs.length > 4 ? state.docs[4] : null);
        closeLoaderDialog();

        if (response.httpcode == "200") {
          showSnackBar(context: context, msg: "${response.message}");
          emit(state.copyWith(
              selectedTab: state.selectedTab + 1,
              sellerId: response.data.sellerId));
        } else {
          showSnackBar(context: context, msg: "${response.message}");
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<AddScheduleTime>((event, emit) async {
      try {
        showLoaderDialog();
        AddScheduleResponse response = await Repository().addScheduleTime(
            event.seller_id,
            event.dayOfWeek,
            event.startTime.to24HourFormat(),
            event.endTime.to24HourFormat(),
            event.maxBookings,
            event.slotType);
        closeLoaderDialog();
        if (response.httpcode == 200) {

          final updatedSchedulesList =
              List<SchedulesList>.from(state.schedulesList);
          var newTimeSlot = TimeSlot(
            startTime: response.data!.timeSlots!.startTime,
            slotId: response.data!.timeSlots!.slotId,
            maxBookings: int.parse(response.data!.timeSlots!.maxBookings),
            endTime: response.data!.timeSlots!.endTime,
            slotType: SlotType.MULTIPLE,
          );
          updatedSchedulesList[event.dayIndex].timeSlots.add(newTimeSlot);

          updatedSchedulesList[event.dayIndex] = SchedulesList(
            day: updatedSchedulesList[event.dayIndex].day,
            timeSlots: updatedSchedulesList[event.dayIndex].timeSlots,
            timeslotsCount:
                state.schedulesList.length + 1, // Update count if needed
          );

          emit(state.copyWith(
            message: "Time slot added",
            schedulesList: updatedSchedulesList,
          ));
        } else {
          emit(state.copyWith(message: ""));
          emit(state.copyWith(message: response.message));
          showSnackBar(context: context, msg: "${response.message}");
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<DeleteScheduleTime>((event, emit) async {
      try {
        showLoaderDialog();
        SuccessModel response =
            await Repository().deleteScheduleTime(event.slotId);
        closeLoaderDialog();

        if (response.httpcode == 200) {
          final updatedTimeSlots =
              List<TimeSlot>.from(state.schedulesList[event.dayIndex].timeSlots)
                ..removeAt(event.index);

          final updatedSchedulesList = List<SchedulesList>.from(state.schedulesList);
          updatedSchedulesList[event.dayIndex] = SchedulesList(
              day: updatedSchedulesList[event.dayIndex].day,
              timeSlots: updatedTimeSlots,
              timeslotsCount: updatedTimeSlots.length);

          emit(state.copyWith(
            message: "Time slot deleted",
            schedulesList: updatedSchedulesList,
            isChanged: !state.isChanged
          ));
        } else {
          showSnackBar(context: context, msg: "${response.message}");
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<GetScheduleTimeList>((event, emit) async {
      try {
        showLoaderDialog();
        ScheduleModel response = await Repository()
            .getScheduleTimeList(int.parse(state.sellerId ?? sessionManager.sellerId.toString()));
        closeLoaderDialog();
        if (response.httpcode == 200) {
          emit(state.copyWith(
              message: response.message,
              schedulesList: response.data.schedulesList));
        } else {
          showSnackBar(context: context, msg: "${response.message}");
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<GetServiceCategories>((event, emit) async {
      try {
        showLoaderDialog();
        state.phoneNoController!.text = event.phone;
        state.countryCode!.text = event.countryCode.toString();

        final List<Future<dynamic>> apiCalls = [
          Repository().getServiceCategories(),
          Repository().getRegionalList(),
          Repository().getLanguageList(),
        ];
        closeLoaderDialog();

        final List<dynamic> responses = await Future.wait(apiCalls);

        if (responses.every((response) => response.httpcode == 200)) {
          final serviceCategoryResponse =
              responses[0] as ServiceCategoriesModel;
          final regionalResponse = responses[1] as RegionalListModel;
          final languageResponse = responses[2] as LanguageListModel;

          emit(state.copyWith(
              serviceCategoriesData: serviceCategoryResponse.data,
              regionalListData: regionalResponse.data,
              languageListData: languageResponse.data));
        } else {
          final errorMessages = responses
              .where((response) =>
                  response is SuccessModel && response.httpcode != 200)
              .map((response) => response.message.toString())
              .toList();
          closeLoaderDialog();
          showSnackBar(context: context, msg: errorMessages.toString());
        }
      } catch (error) {
        showSnackBar(context: context, msg: error.toString());
      }
    });

    on<SelectServiceType>((event, emit) async {
      emit(state.copyWith(selectedServiceType: event.selectedVal,selectedServiceId: event.selectedServiceTypeId));
    });

    on<SelectDrinking>((event, emit) async {
      emit(state.copyWith(selectedDrinking: event.selectedVal));
    });

    on<SelectReligion>((event, emit) async {
      emit(state.copyWith(selectedReligion: event.selectedVal,selectedReligionId: event.selectedId));
    });

    on<SelectLanguage>((event, emit) async {
      emit(state.copyWith(selectedLanguages: event.selectedVal,selectedLanguageId: event.selectedId));
    });

    on<SelectSmoking>((event, emit) async {
      emit(state.copyWith(selectedSmoking: event.selectedVal));
    });

    on<SelectProfileOption>((event, emit) async {
      List<String> tabs = [];
      if (event.selectedProfileType == "Individual") {
        tabs = ["Step 1", "Step 2", "Step 3", "Step 4", "Step 5"];
      } else {
        tabs = ["Step 1", "Step 2", "Step 3", "Step 4"];
      }

      emit(state.copyWith(
          selectedOption: event.selectedProfileType, tabs: tabs));
    });

    on<SelectGenderOption>((event, emit) async {
      emit(state.copyWith(selectedGender: event.selectedGender));
    });

    on<SelectDOBOption>((event, emit) async {
      emit(state.copyWith(selectedGender: event.selectedDob));
    });

    on<ValidateAndMoveToNextStep>((event, emit) async {
      if (state.selectedOption == "Individual") {
        await handelIndividual(emit, state, context);
      } else {
        await handelBusiness(emit, state, context);
      }
    });

    on<MoveToPreviousStep>((event, emit) async {
      emit(state.copyWith(selectedTab: state.selectedTab - 1));
    });

    on<AddAddressFromLocation>((event, emit) async {
      emit(state.copyWith(
          address: event.address,
          lat: event.lat,
          long: event.long,
          zipCode: event.zipCode,
          country: event.country));
    });

    on<AddFileImages>((event, emit) async {
      if (event.type == "avatar") {
        emit(state.copyWith(avatar: event.file));
      }

      if (event.type == "logo") {
        emit(state.copyWith(logo: event.file));
      }

      if (event.type == "doc") {
        final List<File> updatedDocs = List<File>.from(state.docs)
          ..add(event.file);
        emit(state.copyWith(docs: updatedDocs));
      }
    });

    on<DeleteFileImages>((event, emit) async {
      if (event.type == "avatar") {
        emit(state.copyWith(avatar: null, avatarDelete: true));
      }

      if (event.type == "logo") {
        emit(state.copyWith(logo: null, logoDelete: true));
      }

      if (event.type == "doc") {
        final List<File> updatedDocs = List<File>.from(state.docs)
          ..remove(event.file);
        emit(state.copyWith(docs: updatedDocs));
      }
    });
  }

  void getServiceCategories(phone, countryCode) {
    add(GetServiceCategories(phone, countryCode));
  }

  void selectServiceType(String selectedServiceType, String selectedVal) {
    add(SelectServiceType(selectedServiceType,selectedVal));
  }

  void selectDrinking(String selectedVal) {
    add(SelectDrinking(selectedVal,""));
  }

  void selectReligion(String selectedId,String selectedVal) {
    add(SelectReligion(selectedVal,selectedId));
  }

  void selectLanguage(String selectedId,String selectedVal) {
    add(SelectLanguage(selectedVal,selectedId));
  }

  void selectSmoking(String selectedVal) {
    add(SelectSmoking(selectedVal,""));
  }

  void validateAndMove() {
    add(ValidateAndMoveToNextStep());
  }

  void moveToPrevious() {
    add(MoveToPreviousStep());
  }

  void selectProfileOption(String selectedProfileType) {
    add(SelectProfileOption(selectedProfileType));
  }

  void selectGenderOption(String selectedGender) {
    add(SelectGenderOption(selectedGender));
  }

  void selectDOB(String selectedDOB) {
    add(SelectDOBOption(selectedDOB));
  }

  Future<void> handelBusiness(Emitter<ProfileState> emit, ProfileState state,
      BuildContext context) async {
    switch (state.selectedTab) {
      case 0:
        if (!_validateFields(context, [
          Field(
              state.businessNameController!, "Please enter your Business Name"),
          Field(state.registrationNumberController!,
              "Please enter your registration number"),

          Field(state.phoneNoController!, "Please enter your phone no."),
          Field(state.descriptionController!, "Please enter description")
        ])) return;
        emit(state.copyWith(selectedTab: state.selectedTab + 1));
        break;

      case 1:
        if (!_validateFields(context, [
          Field(state.buildingNoController!, "Please enter your Building No"),
        ])) return;
        emit(state.copyWith(selectedTab: state.selectedTab + 1));
        break;

      case 2:
        if (!_validateFields(context, [
          Field(state.bankNameController!, "Please enter your Bank Name"),
          Field(
              state.bankAccNoController!, "Please enter your Bank Account No"),
          Field(state.bankAccNameController!,
              "Please enter your Bank Account Name")
        ])) return;
        add(CreateBusinessProfile());
        break;

      default:
        emit(state.copyWith(selectedTab: state.selectedTab + 1));
        return;
    }
  }

  Future<void> handelIndividual(Emitter<ProfileState> emit, ProfileState state,
      BuildContext context) async {
    switch (state.selectedTab) {
      case 0:
        if (!_validateFields(context, [
          Field(state.businessNameController!, "Please enter your Name"),
          Field(state.emailController!, "Please enter a valid email",
              validateEmail: true),
          Field(state.phoneNoController!, "Please enter phone no."),
          Field(state.descriptionController!, "Please enter description")
        ])) return;
        emit(state.copyWith(selectedTab: state.selectedTab + 1));
        break;

      case 1:
        if (!_validateFields(context, [
          Field(state.dobController!, "Please enter your dob"),
        ])) return;
        emit(state.copyWith(selectedTab: state.selectedTab + 1));
        break;

      case 3:
        if (!_validateFields(context, [
          Field(state.bankNameController!, "Please enter your Bank Name"),
          Field(
              state.bankAccNoController!, "Please enter your Bank Account No"),
          Field(state.bankAccNameController!,
              "Please enter your Bank Account Name")
        ])) return;
        add(CreateIndividualProfile());
        break;

      default:
        emit(state.copyWith(selectedTab: state.selectedTab + 1));
        return;
    }
  }

  bool _validateFields(BuildContext context, List<Field> fields) {
    for (var field in fields) {
      if (field.controller.text.isEmpty) {
        showSnackBar(context: context, msg: field.errorMsg, type: 1);
        return false;
      }
      if (field.validateEmail && !field.controller.text.isValidEmail()) {
        showSnackBar(
            context: context, msg: "Please enter a valid email", type: 1);
        return false;
      }
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    showLoaderDialog();
      final LocationSettings locationSettings =
          LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);

      try {
      final Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      var currentPosition = position;
      var placeMark = await getAddressFromLatLng(position);
      var currentAddress = "${placeMark?.street}, ${placeMark?.subLocality}, ${placeMark?.subAdministrativeArea}, ${placeMark?.postalCode}";
      var country = placeMark?.country ?? "Unknown";
      add(AddAddressFromLocation(
        address: currentAddress,
        lat: currentPosition.latitude.toString(),
        long: currentPosition.longitude.toString(),
        zipCode: placeMark?.postalCode ?? "",
        country: country,
      ));
      closeLoaderDialog();
    } catch (e) {
      debugPrint("Error fetching location: $e");
      closeLoaderDialog();
    }
  }

  void addScheduleTime(int sellerId, String dayOfWeek, String startTime,
      String endTime, String maxBookings, String slotType, int dayIndex) {
    add(AddScheduleTime(sellerId, dayOfWeek, startTime, endTime, maxBookings,
        slotType, dayIndex));
  }

  void deleteScheduleTime(int slotId, int dayIndex, int timeSlotIndex) {
    add(DeleteScheduleTime(slotId, timeSlotIndex, dayIndex));
  }

  void getScheduleTimeList() {
    add(GetScheduleTimeList());
  }

  void addFileImages(File file, String type) {
    add(AddFileImages(file, type));
  }

  void deleteFileImage(File file, String type, int index) {
    add(DeleteFileImages(file, type, index));
  }
}
