import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:g1c_vendor/data/repository/Repository.dart';
import 'package:g1c_vendor/ui/service/serviceDetails/model/service_details_model.dart';
import 'package:g1c_vendor/utils/loader.dart';
import 'package:g1c_vendor/utils/utils.dart';

part 'service_details_event.dart';

part 'service_details_state.dart';

class ServiceDetailsBloc
    extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  ServiceDetailsBloc(BuildContext context) : super(ServiceDetailsState()) {
    on<GetServiceDetails>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      showLoaderDialog();
      ServiceDetailsModel response = await Repository().getServiceDetails(event.id);
      closeLoaderDialog();
      if (response.httpcode == 200) {
        emit(state.copyWith(
            preferenceList: response.preferenceList,
            preferenceData: response.preferenceData,
            serviceData: response.serviceData,isLoading: false));
      } else {
        showSnackBar(context: context, msg: response.message);
      }
    });
  }

  void getServiceDetails(id) {
    add(GetServiceDetails(id));
  }
}
