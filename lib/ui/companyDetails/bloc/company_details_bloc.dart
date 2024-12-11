import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'company_details_event.dart';
part 'company_details_state.dart';

class CompanyDetailsBloc extends Bloc<CompanyDetailsEvent, CompanyDetailsState> {
  CompanyDetailsBloc() : super(CompanyDetailsInitial()) {
    on<CompanyDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
