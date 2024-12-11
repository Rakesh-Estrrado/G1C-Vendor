part of 'add_service_bloc.dart';

class AddServiceAddOns {
  final int id;
  final String name;
  final TextEditingController time;
  final TextEditingController price;

  AddServiceAddOns(this.id, TextEditingController time,
      TextEditingController price, this.name)
      : time = TextEditingController(),
        price = TextEditingController();

  @override
  String toString() =>
      "AddServiceAddOns(id:$id, time:$time, price:$price, name:$name)";
}

class AddServiceState extends Equatable {
  final bool isBottomLoading;
  final String message;
  final int catId;
  final int subCatId;
  final String serviceName;

  final String? desc;
  final String? totalHours;
  final String? price;
  final String? disPrice;
  final String? startDate;
  final String? endDate;

  final List<AddServiceAddOns> addOnList;
  final List<AddonList> addOnListData;
  final List<ServicesList> servicesList;
  final List<CategoryList> categoryList;
  final List<Subcategory> subcategories;
  final bool isChanged;
  final bool isAllChecked;
  final String statusSelected;
  final List<ApprovalStatus> approvalStatus;

  AddServiceState({
    this.isBottomLoading = false,
    this.message = "",
    this.isChanged = false,
    this.isAllChecked = false,
    this.servicesList = const [],
    this.categoryList = const [],
    this.subcategories = const [],
    this.approvalStatus = const [],
    this.addOnListData = const [],
    this.addOnList = const [],
    this.statusSelected = "",
    this.serviceName = "",
    this.catId = 0,
    this.subCatId = 0,
    this.desc = "",
    this.totalHours = "",
    this.price = "",
    this.disPrice = "",
    this.startDate = "",
    this.endDate = "",
  });

  AddServiceState copyWith(
      {bool? isBottomLoading,
      String message = "",
      String statusSelected = "",
      String? serviceName,
      String? desc,
      String? totalHours,
      String? price,
      String? disPrice,
      String? startDate,
      String? endDate,
      int? catId,
      int? subCatId,
      bool isChanged = false,
      bool? isAllChecked,
      List<AddonList>? addOnListData,
      List<CategoryList>? categoryList,
      List<AddServiceAddOns>? addOnList,
      List<ServicesList>? servicesList,
      List<Subcategory>? subcategories,
      List<ApprovalStatus>? approvalStatus}) {
    return AddServiceState(
      isBottomLoading: isBottomLoading ?? this.isBottomLoading,
      message: message,
      desc: desc ?? this.desc,
      totalHours: totalHours ?? this.totalHours,
      price: price ?? this.price,
      disPrice: disPrice ?? this.disPrice,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      statusSelected: statusSelected,
      isChanged: isChanged,
      catId: catId ?? this.catId,
      subCatId: subCatId ?? this.subCatId,
      serviceName: serviceName ?? this.serviceName,
      isAllChecked: isAllChecked ?? this.isAllChecked,
      addOnListData: addOnListData ?? this.addOnListData,
      addOnList: addOnList ?? this.addOnList,
      categoryList: categoryList ?? this.categoryList,
      subcategories: subcategories ?? this.subcategories,
      servicesList: servicesList ?? this.servicesList,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  @override
  List<Object?> get props => [
        isBottomLoading,
        message,
        statusSelected,
        categoryList,
        servicesList,
        isChanged,
        subcategories,
        catId,
        subCatId,
        serviceName,
        addOnList,
        addOnListData,
        isAllChecked,
        approvalStatus,
        desc,
        totalHours,
        price,
        disPrice,
        startDate,
        endDate
      ];
}
