part of 'service_details_bloc.dart';


abstract class ServiceDetailsEvent extends Equatable {
  const ServiceDetailsEvent();

  @override
  List<Object?> get props => [];
}

class GetServiceDetails extends ServiceDetailsEvent {
  final int id;

  const GetServiceDetails(this.id);

  @override
  List<Object?> get props => [id];
}