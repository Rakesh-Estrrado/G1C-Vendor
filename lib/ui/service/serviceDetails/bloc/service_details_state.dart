part of 'service_details_bloc.dart';

class ServiceDetailsState extends Equatable {
  final bool isLoading;
  final List<PreferenceData> preferenceData;
  final List<PreferenceList> preferenceList;
  final List<ServiceData> serviceData;

  const ServiceDetailsState(
      {this.isLoading = true,
      this.preferenceData = const [],
      this.preferenceList = const [],
      this.serviceData =const []});

  ServiceDetailsState copyWith(
      {bool? isLoading,
      List<PreferenceData>? preferenceData,
      List<PreferenceList>? preferenceList,
      List<ServiceData>? serviceData}) {
    return ServiceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      preferenceData: preferenceData ?? this.preferenceData,
      preferenceList: preferenceList ?? this.preferenceList,
      serviceData: serviceData ?? this.serviceData,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, preferenceData, preferenceList, serviceData];
}
