part of 'add_service_bloc.dart';

abstract class AddServiceEvent extends Equatable {
  const AddServiceEvent();

  @override
  List<Object?> get props => [];
}

class GetServiceCategories extends AddServiceEvent {
  final int id;

  const GetServiceCategories(this.id);

  @override
  List<Object?> get props => [id];
}

class GetCategories extends AddServiceEvent {
  const GetCategories();

  @override
  List<Object?> get props => [];
}

class AddNewServiceToDraft extends AddServiceEvent {
  const AddNewServiceToDraft();

  @override
  List<Object?> get props => [];
}

class UpdateSelectCatId extends AddServiceEvent {
  final int catId;
  final String categoryName;

  const UpdateSelectCatId(this.catId, this.categoryName);

  @override
  List<Object?> get props => [catId,categoryName];
}

class UpdateSelectServiceId extends AddServiceEvent {
  final int serviceId;
  final String serviceName;

  const UpdateSelectServiceId(this.serviceId, this.serviceName);

  @override
  List<Object?> get props => [serviceId,serviceName];
}

class AddServiceAddOnList extends AddServiceEvent {
  final id;
  final name;
  final isAdd;
  final index;

  const AddServiceAddOnList(this.id, this.name, this.isAdd, this.index);

  @override
  List<Object?> get props => [id, name, isAdd, index];
}

class AddValues extends AddServiceEvent {
  final String value;
  final String type;

  const AddValues(this.value, this.type);

  @override
  List<Object?> get props => [value,type];
}
