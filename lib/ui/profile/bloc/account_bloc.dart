import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:g1c_vendor/ui/service/addService/model/categories_model.dart';

import '../../../data/model/success_model.dart';
import '../../../data/repository/Repository.dart';
import '../../../utils/loader.dart';
import '../../../utils/utils.dart';
import '../../auth/model/terms_and_conditions_model.dart';
import '../../service/model/service_list_and_filter_model.dart';
import '../model/account_model.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(BuildContext context) : super(AccountState()) {
    on<GetAccountDetails>((event, emit) async {
      showLoaderDialog();
      try {
        final List<Future<dynamic>> apiCalls = [
          Repository().getAccountDetails(),
          Repository().getTermsAndConditions(),
          Repository().getCategories()
        ];
        final List<dynamic> responses = await Future.wait(apiCalls);
        closeLoaderDialog();
        if (responses.every((response) => response.httpcode == 200)) {
          final accountResponse = responses[0] as AccountModel;
          final termsAndConditionsResponse =
              responses[1] as TermsAndConditionsModel;
          final categoriesResponse = responses[2] as CategoriesModel;
          emit(state.copyWith(
            basicDetails: accountResponse.data.basicDetails,
            businessDetails: accountResponse.data.businessDetails,
            bankDetails: accountResponse.data.bankDetails,
            businessDocuments:
                accountResponse.data.businessDetails.businessDocuments,
            categoryList: categoriesResponse.data.categoryList,
            termsAndConditionsData: termsAndConditionsResponse.data,
          ));
        } else {
          final errorMessages = responses
              .where((response) =>
                  response is SuccessModel && response.httpcode != 200)
              .map((response) => response.message.toString())
              .toList();
          showSnackBar(context: context, msg: errorMessages.toString());
        }
      } on Exception catch (e) {
        showSnackBar(context: context, msg: e.toString());
        closeLoaderDialog();
      }
    });

    on<UpdateAccountDetails>((event, emit) async {
      showLoaderDialog();
      SuccessModel response = await Repository()
          .updateAccountDetails(event.name, event.email, event.imageFile);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
        getAccountDetails();
        Navigator.pop(context);
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });

    on<DeleteBusinessDoc>((event, emit) async {
      BusinessDetails? updatedBusinessDetails = state.businessDetails;
      showLoaderDialog();
      SuccessModel response =
          await Repository().deleteBusinessDoc(event.documentId);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
        updatedBusinessDetails?.businessDocuments.removeAt(event.documentIndex);
        emit(state.copyWith(
            businessDetails: updatedBusinessDetails,
            isUpdate: !state.isUpdate));
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });

    on<UpdateServiceCategory>((event, emit) async {
      emit(state.copyWith(
          selectedCatId: event.categoryId,
          selectedCategory: event.categoryName));
    });

    on<UpdateCompanyDetails>((event, emit) async {
      SuccessModel response = await Repository().updateCompanyDetails(
        event.businessName,
        event.regNo,
        state.selectedCatId ?? 0,
        state.businessDetails?.address ?? "",
        state.businessDetails?.landmark ?? "",
        event.imgLogo
      );
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
        getAccountDetails();
        Navigator.pop(context);
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });

    on<UpdateBankDetails>((event, emit) async {
      SuccessModel response = await Repository().updateBankDetails(
        event.bankName,
        event.accName,
        event.accNumber,
      );
      if (response.httpcode == 200) {
        showSnackBar(context: context, msg: response.message);
        getAccountDetails();
        Navigator.pop(context);
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });
  }

  void getAccountDetails() {
    add(GetAccountDetails());
  }

  void updateProfile(String name, String email, String imageFile) {
    add(UpdateAccountDetails(name, email, imageFile));
  }

  void updateCompany(String businessName, String regNo, String imgLogo) {
    add(UpdateCompanyDetails(businessName, regNo,imgLogo));
  }

  void updateBankDetails(String bankName, String accName, String accNumber) {
    add(UpdateBankDetails(bankName, accName, accNumber));
  }

  void updateServiceCategory(int categoryId, String categoryName) {
    add(UpdateServiceCategory(categoryId, categoryName));
  }

  void deleteBusinessDoc(int docId, int docIndex) {
    add(DeleteBusinessDoc(docId, docIndex));
  }
}
