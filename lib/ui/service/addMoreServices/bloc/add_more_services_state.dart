part of 'add_more_services_bloc.dart';

class AddMoreServicesState extends Equatable {
  final bool isUpdated;
  final bool isLoading;
  final List<PreferenceData> preferenceData;
  final List<PreferenceList> preferenceList;
  final List<AddonList> addOnList;
  final List<ServiceData> serviceData;
  final List<ServiceAddon> serviceAddon;

  final String? desc;
  final String? totalHours;
  final String? price;
  final String? disPrice;
  final String? startDate;
  final String? endDate;

  const AddMoreServicesState(
      {this.isLoading = true,
      this.isUpdated = true,
      this.desc = "",
      this.totalHours = "",
      this.price = "",
      this.disPrice = "",
      this.startDate = "",
      this.endDate = "",
      this.serviceAddon = const [],
      this.addOnList = const [],
      this.preferenceData = const [],
      this.preferenceList = const [],
      this.serviceData = const []});

  AddMoreServicesState copyWith(
      {bool? isLoading,
      bool? isUpdated,
      String? desc,
      String? totalHours,
      String? price,
      String? disPrice,
      String? startDate,
      String? endDate,
      List<AddonList>? addOnList,
      List<ServiceAddon>? serviceAddon,
      List<PreferenceData>? preferenceData,
      List<PreferenceList>? preferenceList,
      List<ServiceData>? serviceData}) {
    return AddMoreServicesState(
      isLoading: isLoading ?? this.isLoading,
      isUpdated: isUpdated ?? this.isUpdated,
      addOnList: addOnList ?? this.addOnList,
      serviceAddon: serviceAddon ?? this.serviceAddon,
      desc: desc ?? this.desc,
      totalHours: totalHours ?? this.totalHours,
      price: price ?? this.price,
      disPrice: disPrice ?? this.disPrice,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      preferenceData: preferenceData ?? this.preferenceData,
      preferenceList: preferenceList ?? this.preferenceList,
      serviceData: serviceData ?? this.serviceData,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isUpdated,
        addOnList,
        serviceAddon,
        preferenceData,
        preferenceList,
        serviceData,
        desc,
        totalHours,
        price,
        disPrice,
        startDate,
        endDate
      ];
}
