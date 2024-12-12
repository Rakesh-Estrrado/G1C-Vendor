part of 'add_more_services_bloc.dart';

abstract class AddMoreServicesEvent extends Equatable {
  const AddMoreServicesEvent();

  @override
  List<Object?> get props => [];
}

class GetPreferencesList extends AddMoreServicesEvent {
  final int catId;
  final int subCatId;

  const GetPreferencesList(this.catId, this.subCatId);

  @override
  List<Object?> get props => [catId, subCatId];
}

class GetServiceDetails extends AddMoreServicesEvent {
  final int id;

  const GetServiceDetails(this.id);

  @override
  List<Object?> get props => [id];
}

class CheckPreference extends AddMoreServicesEvent {
  final int parentIndex;
  final int valueIndex;
  final bool isChecked;
  final String type;

  const CheckPreference(
      this.parentIndex, this.valueIndex, this.isChecked, this.type);

  @override
  List<Object?> get props => [parentIndex, valueIndex, type];
}

class AddValues extends AddMoreServicesEvent {
  final String value;
  final String type;

  const AddValues(this.value, this.type);

  @override
  List<Object?> get props => [value, type];
}

class AddOnListValues extends AddMoreServicesEvent {
  final String value;
  final String type;
  final int index;

  const AddOnListValues(this.value, this.type, this.index);

  @override
  List<Object?> get props => [value, type, index];
}

class AddServiceMedia extends AddMoreServicesEvent {
  final File image;

  const AddServiceMedia(this.image);

  @override
  List<Object?> get props => [image];
}

class DeleteServiceMedia extends AddMoreServicesEvent {
  final int index;
  final int serviceId;
  final int fileId;

  const DeleteServiceMedia(this.index, this.serviceId, this.fileId);

  @override
  List<Object?> get props => [index, serviceId, fileId];
}

class AddServiceAddOnList extends AddMoreServicesEvent {
  final int addOnId;
  final int id;
  final int serviceId;
  final String name;
  final bool isAdd;
  final int index;

  const AddServiceAddOnList(
      this.id, this.name, this.isAdd, this.index, this.serviceId, this.addOnId);

  @override
  List<Object?> get props => [id, name, isAdd, index, serviceId, addOnId];
}

class UpdateServiceBasic extends AddMoreServicesEvent {
  final int serviceId;

  const UpdateServiceBasic(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}

class UpdatePreferences extends AddMoreServicesEvent {
  final int serviceId;

  const UpdatePreferences(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}

class UpdateServiceMedia extends AddMoreServicesEvent {
  final int serviceId;
  final bool submit;

  const UpdateServiceMedia(this.serviceId, this.submit);

  @override
  List<Object?> get props => [serviceId];
}

class SubmitServiceApproval extends AddMoreServicesEvent {
  final int serviceId;

  const SubmitServiceApproval(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}
