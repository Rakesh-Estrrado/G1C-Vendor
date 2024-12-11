part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object?> get props => [];
}

class GetServiceListAndFilter extends ServiceEvent {
  final int pageNo;
  final String search;

  const GetServiceListAndFilter(this.pageNo, this.search);

  @override
  List<Object?> get props => [pageNo,search];
}

class SelectedCategory extends ServiceEvent {
  final int index;
  final bool isChecked;

  const SelectedCategory(this.index, this.isChecked);

  @override
  List<Object?> get props => [index, isChecked];
}

class GetSubCategories extends ServiceEvent {
  final int id;

  const GetSubCategories(this.id);

  @override
  List<Object?> get props => [id];
}

class SelectedSubCategory extends ServiceEvent {
  final int index;
  final bool isChecked;

  const SelectedSubCategory(this.index, this.isChecked);

  @override
  List<Object?> get props => [index, isChecked];
}

class SelectedStatus extends ServiceEvent {
  final int index;
  final bool isChecked;

  const SelectedStatus(this.index, this.isChecked);

  @override
  List<Object?> get props => [index, isChecked];
}

class SelectedAll extends ServiceEvent {
  final bool isChecked;

  const SelectedAll(this.isChecked);

  @override
  List<Object?> get props => [isChecked];
}

class UpdateServiceStatus extends ServiceEvent {
  final int id;
  final int index;

  const UpdateServiceStatus(this.id, this.index);

  @override
  List<Object?> get props => [id,index];
}

class DeleteService extends ServiceEvent {
  final int index;

  const DeleteService(this.index);

  @override
  List<Object?> get props => [index];
}
