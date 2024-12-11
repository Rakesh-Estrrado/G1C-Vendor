part of 'account_bloc.dart';

class AccountState extends Equatable {
  final bool isUpdate;
  final BasicDetails? basicDetails;
  final BusinessDetails? businessDetails;
  final BankDetails? bankDetails;
  final List<BusinessDocument> businessDocuments;
  final List<CategoryList> categoryList;
  final TermsAndConditionsData? termsAndConditionsData;
  final String? selectedCategory;
  final int? selectedCatId;

  const AccountState(
      {this.basicDetails,
      this.isUpdate = false,
      this.businessDetails,
      this.bankDetails,
      this.categoryList = const [],
      this.businessDocuments = const [],
      this.termsAndConditionsData,
      this.selectedCatId = 0,
      this.selectedCategory = ""});

  AccountState copyWith({
    bool? isUpdate = false,
    BasicDetails? basicDetails,
    BusinessDetails? businessDetails,
    BankDetails? bankDetails,
    List<CategoryList>? categoryList,
    List<BusinessDocument>? businessDocuments,
    TermsAndConditionsData? termsAndConditionsData,
    int? selectedCatId,
    String? selectedCategory,
  }) {
    return AccountState(
        isUpdate: isUpdate ?? this.isUpdate,
        basicDetails: basicDetails ?? this.basicDetails,
        businessDetails: businessDetails ?? this.businessDetails,
        bankDetails: bankDetails ?? this.bankDetails,
        categoryList: categoryList ?? this.categoryList,
        businessDocuments: businessDocuments ?? this.businessDocuments,
        termsAndConditionsData:
            termsAndConditionsData ?? this.termsAndConditionsData,
        selectedCatId: selectedCatId ?? this.selectedCatId,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }

  @override
  List<Object?> get props => [
        isUpdate,
        basicDetails,
        businessDetails,
        basicDetails,
        termsAndConditionsData,
        businessDocuments,
        categoryList,
    selectedCatId
      ];
}
