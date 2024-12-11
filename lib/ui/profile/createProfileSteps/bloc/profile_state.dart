part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final List<String> tabs;
  final bool isChanged;
  final int selectedTab;
  final String selectedOption;
  final File? avatar;
  final File? logo;
  final List<File> docs;
  final String? selectedServiceType;
  final String selectedGender;

  final TextEditingController? businessNameController;
  final TextEditingController? registrationNumberController;
  final TextEditingController? directorNameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneNoController;
  final TextEditingController? descriptionController;
  final TextEditingController? bankNameController;
  final TextEditingController? bankAccNoController;
  final TextEditingController? bankAccNameController;
  final TextEditingController? buildingNoController;
  final TextEditingController? landMarkController;
  final TextEditingController? dobController;
  final TextEditingController? titleController;
  final TextEditingController? companyController;
  final TextEditingController? programNameController;
  final TextEditingController? universityController;
  final TextEditingController? heightController;
  final TextEditingController? weightController;
  final TextEditingController? hobbiesController;
  final TextEditingController? countryCode;

  final String address;
  final String? lat;
  final String? long;
  final String? zipCode;
  final String? country;

  final String? selectedDrinking;
  final String? selectedSmoking;
  final String? selectedReligion;
  final String? selectedLanguages;
  final String? selectedServiceCategory;
  final String? selectedServiceId;
  final String message;
  final ServiceCategoriesData? serviceCategoriesData;
  final RegionalListData? regionalListData;
  final LanguageListData? languageListData;
  final List<SchedulesList> schedulesList;
  final String? sellerId;

  const ProfileState({
    this.address = "",
    this.lat,
    this.isChanged =false,
    this.long,
    this.zipCode,
    this.country,
    this.countryCode,
    this.selectedDrinking,
    this.selectedSmoking,
    this.selectedReligion,
    this.selectedLanguages,
    this.selectedServiceCategory,
    this.selectedTab = 0,
    this.selectedOption = "Business",
    this.avatar,
    this.logo,
    this.docs = const [],
    this.selectedServiceType,
    this.selectedGender = "Male",
    this.tabs = const ["Step 1", "Step 2", "Step 3", "Step 4"],
    this.businessNameController,
    this.registrationNumberController,
    this.directorNameController,
    this.emailController,
    this.phoneNoController,
    this.descriptionController,
    this.bankNameController,
    this.bankAccNoController,
    this.bankAccNameController,
    this.buildingNoController,
    this.landMarkController,
    this.dobController,
    this.titleController,
    this.companyController,
    this.programNameController,
    this.universityController,
    this.heightController,
    this.weightController,
    this.hobbiesController,
    this.message = "",
    this.serviceCategoriesData,
    this.sellerId,
    this.regionalListData,
    this.languageListData,
    this.selectedServiceId,
    this.schedulesList = const [],
  });

  ProfileState copyWith(
      {TextEditingController? businessNameController,
      TextEditingController? registrationNumberController,
      TextEditingController? directorNameController,
      TextEditingController? emailController,
      TextEditingController? phoneNoController,
      TextEditingController? descriptionController,
      TextEditingController? bankNameController,
      TextEditingController? bankAccNoController,
      TextEditingController? bankAccNameController,
      TextEditingController? buildingNoController,
      TextEditingController? landMarkController,
      TextEditingController? dobController,
      TextEditingController? titleController,
      TextEditingController? companyController,
      TextEditingController? programNameController,
      TextEditingController? universityController,
      TextEditingController? heightController,
      TextEditingController? weightController,
      TextEditingController? hobbiesController,
      TextEditingController? countryCode,
      List<String>? tabs,
      bool? isChanged,
      int? selectedTab,
      String? selectedOption,
      File? avatar,
      File? logo,
      List<File>? docs,
      String? selectedServiceType,
      String? selectedServiceId,
      String? selectedGender,
      String? address,
      String? lat,
      String? long,
      String? zipCode,
      String? country,
      String? selectedDrinking,
      String? selectedSmoking,
      String? selectedReligion,
      String? selectedReligionId,
      String? selectedLanguages,
      String? selectedLanguageId,
      String? selectedServiceCategory,
      String? sellerId,
      String? message,
      bool avatarDelete = false,
      bool logoDelete = false,
      ServiceCategoriesData? serviceCategoriesData,
      List<SchedulesList>? schedulesList,
      RegionalListData? regionalListData,
      LanguageListData? languageListData}) {
    return ProfileState(
      businessNameController:
      businessNameController ?? this.businessNameController,
      registrationNumberController:
          registrationNumberController ?? this.registrationNumberController,
      directorNameController:
          directorNameController ?? this.directorNameController,
      emailController: emailController ?? this.emailController,
      phoneNoController: phoneNoController ?? this.phoneNoController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      bankNameController: bankNameController ?? this.bankNameController,
      bankAccNoController: bankAccNoController ?? this.bankAccNoController,
      bankAccNameController:
          bankAccNameController ?? this.bankAccNameController,
      buildingNoController: buildingNoController ?? this.buildingNoController,
      landMarkController: landMarkController ?? this.landMarkController,
      dobController: dobController ?? this.dobController,
      titleController: titleController ?? this.titleController,
      companyController: companyController ?? this.companyController,
      isChanged: isChanged ?? this.isChanged,
      programNameController:
          programNameController ?? this.programNameController,
      universityController: universityController ?? this.universityController,
      heightController: heightController ?? this.heightController,
      weightController: weightController ?? this.weightController,
      hobbiesController: hobbiesController ?? this.hobbiesController,
      tabs: tabs ?? this.tabs,
      selectedTab: selectedTab ?? this.selectedTab,
      selectedOption: selectedOption ?? this.selectedOption,
      avatar: avatarDelete ? null : avatar ?? this.avatar,
      logo: logoDelete ? null : logo ?? this.logo,
      docs: docs ?? this.docs,
      selectedServiceType: selectedServiceType ?? this.selectedServiceType,
      selectedGender: selectedGender ?? this.selectedGender,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      countryCode: countryCode ?? this.countryCode,
      selectedDrinking: selectedDrinking ?? this.selectedDrinking,
      selectedSmoking: selectedSmoking ?? this.selectedSmoking,
      selectedReligion: selectedReligion ?? this.selectedReligion,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      selectedServiceCategory:
          selectedServiceCategory ?? this.selectedServiceCategory,
      message: message ?? this.message,
      serviceCategoriesData:
          serviceCategoriesData ?? this.serviceCategoriesData,
      sellerId: sellerId ?? this.sellerId,
      schedulesList: schedulesList ?? this.schedulesList,
      regionalListData: regionalListData ?? this.regionalListData,
      languageListData: languageListData ?? this.languageListData,
      selectedServiceId: selectedServiceId ?? this.selectedServiceId,
    );
  }

  @override
  List<Object?> get props => [
        businessNameController,
        message,
    isChanged,
        serviceCategoriesData,
        businessNameController,
        registrationNumberController,
        directorNameController,
        emailController,
        phoneNoController,
        descriptionController,
        bankNameController,
        bankAccNoController,
        bankAccNameController,
        buildingNoController,
        landMarkController,
        dobController,
        titleController,
        companyController,
        programNameController,
        universityController,
        heightController,
        weightController,
        hobbiesController,
        tabs,
        selectedTab,
        selectedOption,
        avatar,
        logo,
        docs,
        selectedServiceType,
        selectedGender,
        address,
        selectedDrinking,
        selectedSmoking,
        selectedReligion,
        selectedLanguages,
        selectedServiceCategory,
        lat,
        long,
        zipCode,
        country,
        countryCode,
        sellerId,
        schedulesList,selectedServiceId
      ];
}
