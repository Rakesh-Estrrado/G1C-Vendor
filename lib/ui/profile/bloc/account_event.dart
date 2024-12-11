part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class GetAccountDetails extends AccountEvent {
  const GetAccountDetails();

  @override
  List<Object?> get props => [];
}

class UpdateAccountDetails extends AccountEvent {
  final name;
  final email;
  final imageFile;

  const UpdateAccountDetails(
      this.name, this.email, this.imageFile);

  @override
  List<Object?> get props => [name, email,  imageFile];
}

class UpdateCompanyDetails extends AccountEvent {
  final businessName;
  final regNo;
  final imgLogo;

  const UpdateCompanyDetails(this.businessName, this.regNo, this.imgLogo);

  @override
  List<Object?> get props => [businessName, regNo,imgLogo];
}

class UpdateBankDetails extends AccountEvent {
  final bankName;
  final accName;
  final accNumber;

  const UpdateBankDetails(this.bankName, this.accName, this.accNumber);

  @override
  List<Object?> get props => [bankName,accName,accNumber];
}

class UpdateServiceCategory extends AccountEvent {
  final int categoryId;
  final String categoryName;


  const UpdateServiceCategory(this.categoryId, this.categoryName);

  @override
  List<Object?> get props => [categoryId,categoryName];
}

class DeleteBusinessDoc extends AccountEvent {
  final documentId;
  final documentIndex;
  const DeleteBusinessDoc(this.documentId, this.documentIndex);

  @override
  List<Object?> get props => [documentId,documentIndex];
}
