import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g1c_vendor/data/model/success_model.dart';
import 'package:g1c_vendor/data/repository/Repository.dart';
import 'package:g1c_vendor/ui/service/bloc/service_bloc.dart';
import 'package:g1c_vendor/ui/service/serviceDetails/model/service_details_model.dart';
import 'package:g1c_vendor/utils/loader.dart';
import 'package:g1c_vendor/utils/utils.dart';
import '../../../commonVerification/CommonVerificationProgress.dart';
import '../../addService/model/add_on_list_model.dart';

part 'add_more_services_event.dart';

part 'add_more_services_state.dart';

class AddMoreServicesBloc
    extends Bloc<AddMoreServicesEvent, AddMoreServicesState> {
  AddMoreServicesBloc(BuildContext context, ServiceBloc serviceBloc) : super(AddMoreServicesState()) {
    on<GetServiceDetails>((event, emit) async {
      showLoaderDialog();
      final List<Future<dynamic>> apiCalls = [
        Repository().getServiceDetails(event.id),
        Repository().getAddOnList()
      ];
      closeLoaderDialog();
      final List<dynamic> responses = await Future.wait(apiCalls);
      if (responses.every((response) => response.httpcode == 200)) {
        final serviceDetailResponse = responses[0] as ServiceDetailsModel;
        final addOnListResponse = responses[1] as AddOnListModel;
        emit(state.copyWith(
            preferenceData: serviceDetailResponse.preferenceData,
            preferenceList: serviceDetailResponse.preferenceList,
            serviceData: serviceDetailResponse.serviceData,
            desc: serviceDetailResponse.serviceData.first.serviceDescription,
            totalHours: serviceDetailResponse
                .serviceData.first.serviceTotalHours
                .toString(),
            price:
                serviceDetailResponse.serviceData.first.servicePrice.toString(),
            disPrice: serviceDetailResponse
                .serviceData.first.serviceDiscountPrice
                .toString(),
            startDate: serviceDetailResponse.serviceData.first.disStartDate.toDMY(),
            endDate: serviceDetailResponse.serviceData.first.disEndDate.toDMY(),
            addOnList: addOnListResponse.data.addonList,
            serviceAddon:
                serviceDetailResponse.serviceData.first.serviceAddons));
      } else {
        final errorMessages = responses
            .where((response) =>
                response is SuccessModel && response.httpcode != 200)
            .map((response) => response.message.toString())
            .toList();
        showSnackBar(context: context, msg: errorMessages.toString());
      }
    });

    on<AddValues>((event, emit) async {
      if (event.type == "desc") {
        emit(state.copyWith(desc: event.value));
      }
      if (event.type == "totalHours") {
        emit(state.copyWith(totalHours: event.value));
      }
      if (event.type == "price") {
        emit(state.copyWith(price: event.value));
      }
      if (event.type == "disPrice") {
        emit(state.copyWith(disPrice: event.value));
      }
      if (event.type == "startDate") {
        emit(state.copyWith(startDate: event.value));
      }
      if (event.type == "endDate") {
        emit(state.copyWith(endDate: event.value));
      }
    });

    on<AddOnListValues>((event, emit) async {
      List<ServiceAddon> updatedAddOnList = List.from(state.serviceAddon);

      if (event.type == "duration") {
        updatedAddOnList[event.index].time = int.parse(event.value);
        emit(state.copyWith(serviceAddon: updatedAddOnList));
      }

      if (event.type == "price") {
        updatedAddOnList[event.index].price = int.parse(event.value);
        emit(state.copyWith(serviceAddon: updatedAddOnList));
      }
    });

    /*on<GetPreferencesList>((event, emit) async {
      showLoaderDialog();
      PreferenceListModel response = await Repository().getPreferenceList(event.catId, event.subCatId);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        emit(state.copyWith(preferenceList: response.data.preferenceList));
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });*/

    on<CheckPreference>((event, emit) async {
      List<PreferenceList> updatedPreferences = List.from(state.preferenceList);
      if (event.type == "radio") {
        updatedPreferences[event.parentIndex]
            .values
            .forEach((e) => e.checked = false);
        updatedPreferences[event.parentIndex].values[event.valueIndex].checked =
            event.isChecked;
      } else {
        updatedPreferences[event.parentIndex].values[event.valueIndex].checked =
            event.isChecked;
      }
      emit(state.copyWith(
            preferenceList: updatedPreferences, isUpdated: !state.isUpdated));
    });

    on<UpdatePreferences>((event, emit) async {
      List<PreferenceList> updatedPreferences = List.from(state.preferenceList);
      showLoaderDialog();
      SuccessModel response = await Repository()
          .updatePreferences(event.serviceId, updatedPreferences);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });
    on<UpdateServiceBasic>((event, emit) async {
      try {
        showLoaderDialog();
        SuccessModel res = await Repository().updateServiceBasic(
            event.serviceId,
            state.serviceData.first.categoryId,
            state.serviceData.first.subCategoryId,
            state.serviceData.first.serviceName,
            state.desc.toString(),
            state.totalHours.toString(),
            state.price.toString(),
            state.disPrice.toString(),
            state.startDate.toString(),
            state.endDate.toString(),
            state.serviceAddon);
        closeLoaderDialog();
        if (res.httpcode == 200) {
          showSnackBar(context: context, msg: res.message);
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<AddServiceAddOnList>((event, emit) async {
      try {
        List<ServiceAddon> updatedAddOnList = List.from(state.serviceAddon);
        if (event.isAdd) {
          if (updatedAddOnList.any((e) => e.id == event.id)) {
            showSnackBar(context: context, msg: "${event.name} is already added");
            return;
          }
          updatedAddOnList.add(ServiceAddon(addonName: event.name, addonId: event.addOnId, id: event.id, price: 0, time: 0));
        } else {
          if (event.addOnId != 0) {
            showLoaderDialog();
            SuccessModel response =
                await Repository().removeAddOn(event.serviceId, event.id);
            closeLoaderDialog();
            if (response.httpcode == 200) {
              updatedAddOnList.removeAt(event.index);
            } else {
              showSnackBar(context: context, msg: response.message);
            }
          } else {
            updatedAddOnList.removeAt(event.index);
          }
        }
        emit(state.copyWith(serviceAddon: updatedAddOnList));
      } catch (e) {
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<AddServiceMedia>((event, emit) async {
      var serviceMedia = ServiceMedia(
          filePath: event.image.path.toString(), fileType: "image/jpeg", id: 0);
      List<ServiceData> updatedServiceData = List.from(state.serviceData);
      updatedServiceData.first.serviceMedia.add(serviceMedia);
      emit(state.copyWith(
          serviceData: updatedServiceData, isUpdated: !state.isUpdated));
      Navigator.pop(context);
    });

    on<UpdateServiceMedia>((event, emit) async {
      try {


        showLoaderDialog();
        var serviceData = state.serviceData.first;
        List<String> filePaths = [];
        serviceData.serviceMedia.forEach((e) {
          if (e.id == 0) {
            filePaths.add(e.filePath);
          }
        });
        if(filePaths.isEmpty){
          submitServiceApproval(event.serviceId);
          return;
        }
        SuccessModel response =
            await Repository().updateServiceMedia(event.serviceId, filePaths);
        closeLoaderDialog();
        if (response.httpcode == 200) {
          if(event.submit){
            submitServiceApproval(event.serviceId);
          }else{
            showSnackBar(context: context, msg: response.message);
          }
        } else {
          showSnackBar(context: context, msg: response.message);
        }
      } on Exception catch (e) {
        showSnackBar(context: context, msg: e.toString());
      }
    });
    on<DeleteServiceMedia>((event, emit) async {
      SuccessModel response =
          await Repository().deleteServiceMedia(event.serviceId, event.fileId);
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
        List<ServiceData> updatedServiceData = List.from(state.serviceData);
        updatedServiceData.first.serviceMedia.removeAt(event.index);
        emit(state.copyWith(
            serviceData: updatedServiceData, isUpdated: !state.isUpdated));
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });

    on<SubmitServiceApproval>((event, emit) async {
      SuccessModel response = await Repository().submitServiceApproval(event.serviceId);
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
        navigateTo(
            context: context,
            destination: CommonVerificationProgress(
              title: "Form Submission Successful",
              message:
              "Your form has been completed and submitted\nfor admin verification.",
              onCancel: (){
                Navigator.pop(context);
                Navigator.pop(context);
                serviceBloc.getServiceListAndFilter(1, "");
              },
              onSubmit: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 500),(){serviceBloc.getServiceListAndFilter(1, "");});
              },
            ));

      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });
  }

  void getPreferences(int id, int catId, int subCatId) {
    add(GetPreferencesList(catId, subCatId));
  }

  void getServiceDetails(int id) {
    add(GetServiceDetails(id));
  }

  void checkPreference(
      int parentIndex, int valueIndex, bool isChecked, String type) {
    add(CheckPreference(parentIndex, valueIndex, isChecked, type));
  }

  void addValues(String val, String type) {
    add(AddValues(val, type));
  }

  void addOnListValues(String val, String type, int index) {
    add(AddOnListValues(val, type,index));
  }

  void addServiceMedia(File file) {
    add(AddServiceMedia(file));
  }

  void deleteServiceMedia(int serviceId, int fileId, int index) {
    add(DeleteServiceMedia(index, serviceId, fileId));
  }

  void addServiceAddOns(
      int id, String name, bool isAdd, int index, int serviceId, int addOnId) {
    add(AddServiceAddOnList(id, name, isAdd, index, serviceId, addOnId));
  }

  void updateServiceBasic(int serviceId) {
    add(UpdateServiceBasic(serviceId));
  }

  void updatePreferences(int serviceId) {
    add(UpdatePreferences(serviceId));
  }

  void updateServiceMedia(int serviceId, bool submit) {
    add(UpdateServiceMedia(serviceId,submit));
  }
  void submitServiceApproval(int serviceId) {
    add(SubmitServiceApproval(serviceId));
  }

}
