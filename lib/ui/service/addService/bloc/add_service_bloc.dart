import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:g1c_vendor/data/model/success_model.dart';
import 'package:g1c_vendor/data/repository/Repository.dart';
import 'package:g1c_vendor/ui/service/addService/model/add_on_list_model.dart';
import 'package:g1c_vendor/ui/service/addService/model/categories_model.dart';
import 'package:g1c_vendor/ui/service/bloc/service_bloc.dart';
import 'package:g1c_vendor/ui/service/service_screen.dart';
import 'package:g1c_vendor/utils/loader.dart';
import 'package:g1c_vendor/utils/utils.dart';
import '../../../commonVerification/CommonVerificationProgress.dart';
import '../../addMoreServices/AddMoreServices.dart';
import '../../model/service_list_and_filter_model.dart';
import '../../model/sub_category_model.dart';

part 'add_service_event.dart';

part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc(BuildContext context, ServiceBloc serviceBloc) : super(AddServiceState()) {
    on<GetCategories>((event, emit) async {
      try {
        showLoaderDialog();
        final List<Future<dynamic>> apiCalls = [
          Repository().getCategories(),
          Repository().getAddOnList()
        ];
        closeLoaderDialog();
        final List<dynamic> responses = await Future.wait(apiCalls);
        if (responses.every((response) => response.httpcode == 200)) {
          final categoriesResponse = responses[0] as CategoriesModel;
          final addOnListResponse = responses[1] as AddOnListModel;
          emit(state.copyWith(
              categoryList: categoriesResponse.data.categoryList,
              addOnListData: addOnListResponse.data.addonList));
        } else {
          final errorMessages = responses
              .where((response) =>
                  response is SuccessModel && response.httpcode != 200)
              .map((response) => response.message.toString())
              .toList();
          showSnackBar(context: context, msg: errorMessages.toString());
        }
      } catch (error) {
        showSnackBar(context: context, msg: error.toString());
      }
    });

    on<GetServiceCategories>((event, emit) async {
      try {
        showLoaderDialog();
        SubCategoryModel res =
            await Repository().getServiceSubCategories(event.id);
        closeLoaderDialog();
        if (res.httpcode == 200) {
          if (res.data.subcategories.isEmpty) {
            emit(state.copyWith(subcategories: []));
          } else {
            emit(state.copyWith(
                subcategories: res.data.subcategories.first.subcategory,
                catId: event.id));
          }
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<AddServiceAddOnList>((event, emit) async {
      try {
        List<AddServiceAddOns> updatedAddOnList = List.from(state.addOnList);

        if (event.isAdd) {
          if (updatedAddOnList.any((e) => e.id == event.id)) {
            showSnackBar(
                context: context, msg: "${event.name} is already added");
            return;
          }
          updatedAddOnList.add(AddServiceAddOns(event.id,
              TextEditingController(), TextEditingController(), event.name));
        } else {
          updatedAddOnList.removeAt(event.index);
        }

        emit(state.copyWith(addOnList: updatedAddOnList));
      } catch (e) {
        showSnackBar(context: context, msg: e.toString());
      }
    });

    on<UpdateSelectCatId>((event, emit) async {
      emit(state.copyWith(catId: event.catId, serviceName: event.categoryName));
    });

    on<UpdateSelectServiceId>((event, emit) async {
      emit(state.copyWith(
          subCatId: event.serviceId, serviceName: event.serviceName));
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

    on<AddNewServiceToDraft>((event, emit) async {
      try {
        showLoaderDialog();
        SuccessModel res = await Repository().addServiceBasic(
            state.catId,
            state.subCatId,
            state.serviceName,
            state.desc.toString(),
            state.totalHours.toString(),
            state.price.toString(),
            state.disPrice.toString(),
            state.startDate.toString().toYMD(),
            state.endDate.toString().toYMD(),
            state.addOnList);
        closeLoaderDialog();
        if (res.httpcode == 200) {
          navigateTo(
              context: context,
              destination: CommonVerificationProgress(
                title: "Complete Your Service for Admin Verification",
                message:
                    "Basic details have been saved.\nWould you like to add the remaining details now?\nYou can also revisit and update these details later.\nPlease choose an option:\nAfter completing the form, your submission will go through a verification process by the admin.",
                cancelButtonText: "No, I’ll Do It Later",
                submitButtonText: "Yes, Add Now",
                onCancel: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                    serviceBloc.getServiceListAndFilter(1, "");
                },
                onSubmit: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  navigateTo(
                      context: context,
                      destination:
                          AddMoreServices.builder(context, res.data.serviceId,serviceBloc));
                },
              ));
          showSnackBar(context: context, msg: res.message);
        } else {
          showSnackBar(context: context, msg: res.message);
        }
      } catch (e) {
        showSnackBar(context: context, msg: e.toString());
      }
    });
  }

  void getServiceCategories(int id) {
    add(GetServiceCategories(id));
  }

  void getCategories() {
    add(GetCategories());
  }

  void addServiceAddOns(int id, String name, bool isAdd, int index) {
    add(AddServiceAddOnList(id, name, isAdd, index));
  }

  void addNewServiceToDraft() {
    add(AddNewServiceToDraft());
  }

  void updateSelectCatId(int id, String categoryName) {
    add(UpdateSelectCatId(id, categoryName));
  }

  void updateSelectServiceId(int id, String serviceName) {
    add(UpdateSelectServiceId(id, serviceName));
  }

  void addValues(String val, String type) {
    add(AddValues(val, type));
  }
}
