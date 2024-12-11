import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:g1c_vendor/data/model/success_model.dart';

import '../../../data/repository/Repository.dart';
import '../../../utils/loader.dart';
import '../../../utils/utils.dart';
import '../model/service_list_and_filter_model.dart';
import '../model/sub_category_model.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc(BuildContext context) : super(ServiceState()) {
    bool servicesListEnded = false;

    on<GetServiceListAndFilter>((event, emit) async {
      try {
        if (servicesListEnded) return;
        emit(state.copyWith(isLoading: true));
        if (event.pageNo == 1) {
          showLoaderDialog();
        } else {
          emit(state.copyWith(isBottomLoading: true));
        }

        List<String> selectedCatId = [];
        List<String> selectedSubCatId = [];
        List<String> selectedStatus = [];

        state.categoryList.forEach((e) {
          if (e.isChecked) {
            selectedCatId.add(e.categoryId.toString());
          } else {
            selectedCatId.remove(e.categoryId.toString());
          }
        });

        state.subcategories.forEach((e) {
          if (e.isChecked) {
            selectedSubCatId.add(e.subcategoryId.toString());
          } else {
            selectedSubCatId.remove(e.subcategoryId.toString());
          }
        });

        state.approvalStatus.forEach((e) {
          if (e.isChecked) {
            selectedStatus.add(e.status.toLowerCase().toString());
          } else {
            selectedStatus.remove(e.status.toLowerCase().toString());
          }
        });

        ServiceListAndFilterModel response = await Repository()
            .serviceListAndFilter(event.pageNo, selectedCatId, selectedSubCatId,
                selectedStatus, event.search);
        closeLoaderDialog();

        if (response.httpcode == 200) {
          List<ServicesList> updatedList;

          if (event.pageNo == 1) {
            servicesListEnded = false;
            updatedList = List.from(response.data.servicesList);
          } else {
            updatedList = List.from(state.servicesList)
              ..addAll(response.data.servicesList);
            servicesListEnded = response.data.servicesList.isEmpty == true;
          }

          if (updatedList.isEmpty) {
            emit(state.copyWith(
                servicesList: [], isBottomLoading: false, isLoading: false));
          } else {
            if (state.categoryList.isEmpty && state.approvalStatus.isEmpty) {
              emit(state.copyWith(
                  isChanged: !state.isChanged,
                  servicesList: updatedList,
                  isBottomLoading: false,
                  isLoading: false,
                  categoryList: response.data.filterData.categoryList,
                  approvalStatus: response.data.filterData.approvalStatus));
            } else {
              emit(state.copyWith(
                  servicesList: updatedList,
                  isBottomLoading: false,
                  isLoading: false,isChanged: !state.isChanged));
            }
          }
        } else if (response.httpcode == 404) {
          emit(state.copyWith(servicesList: [], isBottomLoading: false));
        } else {
          showSnackBar(context: context, msg: response.message);
          emit(state.copyWith(isBottomLoading: false));
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<GetSubCategories>((event, emit) async {
      try {
        showLoaderDialog();
        if (state.subcategories.isNotEmpty) {
          closeLoaderDialog();
          return;
        }
        SubCategoryModel response =
            await Repository().getServiceSubCategories(0);
        closeLoaderDialog();

        if (response.httpcode == 200) {
          List<Subcategory> updatedSubCategories =
              List.from(state.subcategories);
          updatedSubCategories.clear();
          response.data.subcategories.forEach((e) {
            updatedSubCategories.addAll(e.subcategory);
          });

          emit(state.copyWith(subcategories: updatedSubCategories));
        } else {
          showSnackBar(context: context, msg: response.message);
        }
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<SelectedCategory>((event, emit) async {
      try {
        List<CategoryList> updatedList = List.from(state.categoryList);
        updatedList[event.index].isChecked = event.isChecked;
        emit(state.copyWith(
            categoryList: updatedList, isChanged: !state.isChanged));
      } catch (error) {
        closeLoaderDialog();
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<SelectedSubCategory>((event, emit) async {
      try {
        List<Subcategory> updatedList = List.from(state.subcategories);
        updatedList[event.index].isChecked = event.isChecked;

        emit(state.copyWith(
            subcategories: updatedList, isChanged: !state.isChanged));
      } catch (error) {
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<SelectedStatus>((event, emit) async {
      try {
        List<ApprovalStatus> updatedApprovalStatusList =
            List.from(state.approvalStatus);
        updatedApprovalStatusList[event.index].isChecked = event.isChecked;
        emit(state.copyWith(
            approvalStatus: updatedApprovalStatusList,
            isChanged: !state.isChanged));
      } catch (error) {
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<SelectedAll>((event, emit) async {
      try {
        List<CategoryList> updatedCategoryList = List.from(state.categoryList);
        List<Subcategory> updatedSubCategoryList =
            List.from(state.subcategories);
        List<ApprovalStatus> updatedApprovalStatusList =
            List.from(state.approvalStatus);

        updatedCategoryList.forEach((e) => e.isChecked = event.isChecked);
        updatedSubCategoryList.forEach((e) => e.isChecked = event.isChecked);
        updatedApprovalStatusList.forEach((e) => e.isChecked = event.isChecked);

        emit(state.copyWith(
            categoryList: updatedCategoryList,
            subcategories: updatedSubCategoryList,
            approvalStatus: updatedApprovalStatusList,
            isAllChecked: event.isChecked));
      } catch (error) {
        showSnackBar(context: context, msg: error.toString());
        print(error.toString());
      }
    });

    on<UpdateServiceStatus>((event, emit) async {
      showLoaderDialog();
      SuccessModel response = await Repository().updateServiceStatus(event.id);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        List<ServicesList> updatedServiceList = List.from(state.servicesList);
        updatedServiceList[event.index].status = updatedServiceList[event.index].status == 1?0:1;
        emit(state.copyWith(servicesList: updatedServiceList,isChanged: !state.isChanged));
        showSnackBar(context: context, msg: response.message);
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });

    on<DeleteService>((event, emit) async {
      List<ServicesList> updatedServiceList = List.from(state.servicesList);
      showLoaderDialog();
      SuccessModel response = await Repository().deleteService(updatedServiceList[event.index].id);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        updatedServiceList.removeAt(event.index);
        emit(state.copyWith(servicesList: updatedServiceList,isChanged: !state.isChanged));
        showSnackBar(context: context, msg: response.message);
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });
  }

  void getServiceListAndFilter(int pageNo, String search) {
    add(GetServiceListAndFilter(pageNo, search));
  }

  void selectCategory(int index, bool isChecked) {
    add(SelectedCategory(index, isChecked));
  }

  void selectSubCategory(int index, bool isChecked) {
    add(SelectedSubCategory(index, isChecked));
  }

  void selectAll(bool isChecked) {
    add(SelectedAll(isChecked));
  }

  void selectApprovalStatus(int index, bool isChecked) {
    add(SelectedStatus(index, isChecked));
  }

  void updateServiceStatus(int id,int index) {
    add(UpdateServiceStatus(id,index));
  }

  void deleteService(int index) {
    add(DeleteService(index));
  }
}
