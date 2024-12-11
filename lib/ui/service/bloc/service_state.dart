part of 'service_bloc.dart';

class ServiceState extends Equatable {
  final bool isBottomLoading;
  final bool isLoading;
  final String message;
  final List<ServicesList> servicesList;
  final List<CategoryList> categoryList;
  final List<Subcategory> subcategories;
  final bool isSwithOn;
  final bool isChanged;
  final bool isAllChecked;
  final String statusSelected;
  final List<ApprovalStatus> approvalStatus;

  const ServiceState({
    this.isBottomLoading = false,
    this.isLoading = true,
    this.isSwithOn = false,
    this.message = "",
    this.isChanged = false,
    this.isAllChecked = false,
    this.servicesList = const [],
    this.categoryList = const [],
    this.subcategories = const [],
    this.approvalStatus = const [],
    this.statusSelected = "",
  });

  ServiceState copyWith(
      {bool? isBottomLoading,
      bool? isLoading,
      bool? isSwithOn,
      String message = "",
      String statusSelected = "",
      bool isChanged = false,
      bool? isAllChecked,
      List<CategoryList>? categoryList,
      List<ServicesList>? servicesList,
      List<Subcategory>? subcategories,
      List<ApprovalStatus>? approvalStatus}) {
    return ServiceState(
      isLoading: isLoading ?? this.isLoading,
      isSwithOn: isSwithOn ?? this.isSwithOn,
      isBottomLoading: isBottomLoading ?? this.isBottomLoading,
      message: message,
      statusSelected: statusSelected,
      isChanged: isChanged,
      isAllChecked: isAllChecked ?? this.isAllChecked,
      categoryList: categoryList ?? this.categoryList,
      subcategories: subcategories ?? this.subcategories,
      servicesList: servicesList ?? this.servicesList,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isBottomLoading,
        isSwithOn,
        message,
        statusSelected,
        categoryList,
        servicesList,
        isChanged,
        subcategories,
        isAllChecked,
        approvalStatus
      ];
}
