part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class CreateBusinessProfile extends ProfileEvent {
  const CreateBusinessProfile();
  @override
  List<Object?> get props => [];
}

class CreateIndividualProfile extends ProfileEvent {
  const CreateIndividualProfile();
  @override
  List<Object?> get props => [];
}

class GetServiceCategories extends ProfileEvent {
  final phone;
  final countryCode;
  const GetServiceCategories(this.phone, this.countryCode);

  @override
  List<Object?> get props => [phone,countryCode];
}

class SelectServiceType extends ProfileEvent {
  final String selectedServiceTypeId;
  final String selectedVal;

  const SelectServiceType(this.selectedServiceTypeId, this.selectedVal);

  @override
  List<Object?> get props => [selectedServiceTypeId,selectedVal];
}

class SelectSmoking extends ProfileEvent {
  final String selectedId;
  final String selectedVal;

  const SelectSmoking(this.selectedVal, this.selectedId);

  @override
  List<Object?> get props => [selectedVal,selectedId];
}

class SelectReligion extends ProfileEvent {
  final String selectedVal;
  final String selectedId;

  const SelectReligion(this.selectedVal, this.selectedId);

  @override
  List<Object?> get props => [selectedVal,selectedId];
}

class SelectLanguage extends ProfileEvent {
  final String selectedVal;
  final String selectedId;

  const SelectLanguage(this.selectedVal, this.selectedId);

  @override
  List<Object?> get props => [selectedVal,selectedId];
}

class SelectDrinking extends ProfileEvent {
  final String selectedVal;
  final String selectedId;

  const SelectDrinking(this.selectedVal, this.selectedId);

  @override
  List<Object?> get props => [selectedVal,selectedId];
}

class ValidateAndMoveToNextStep extends ProfileEvent {
  const ValidateAndMoveToNextStep();

  @override
  List<Object?> get props => [];
}

class MoveToPreviousStep extends ProfileEvent {
  const MoveToPreviousStep();

  @override
  List<Object?> get props => [];
}

class AddAddressFromLocation extends ProfileEvent {
  final String address;
  final String lat;
  final String long;
  final String zipCode;
  final String country;

  const AddAddressFromLocation(
      {required this.address,required  this.lat,required  this.long,required  this.zipCode,required  this.country});

  @override
  List<Object?> get props => [address, lat, long, zipCode, country];
}

class SelectProfileOption extends ProfileEvent {
  final String selectedProfileType;

  const SelectProfileOption(this.selectedProfileType);

  @override
  List<Object?> get props => [];
}

class SelectGenderOption extends ProfileEvent {
  final String selectedGender;

  const SelectGenderOption(this.selectedGender);

  @override
  List<Object?> get props => [];
}

class SelectDOBOption extends ProfileEvent {
  final String selectedDob;

  const SelectDOBOption(this.selectedDob);

  @override
  List<Object?> get props => [];
}

class AddScheduleTime extends ProfileEvent {
  final int seller_id;
  final int dayIndex;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String maxBookings;
  final String slotType;

  const AddScheduleTime(this.seller_id, this.dayOfWeek, this.startTime, this.endTime, this.maxBookings, this.slotType, this.dayIndex);

  @override
  List<Object?> get props => [
    seller_id,
    dayOfWeek,
    startTime,
    endTime,
    maxBookings,
    slotType,
    dayIndex,
  ];
}

class DeleteScheduleTime extends ProfileEvent {
  final int slotId;
  final int dayIndex;
  final int index;

  const DeleteScheduleTime(this.slotId, this.index, this.dayIndex);

  @override
  List<Object?> get props => [slotId,index,dayIndex];
}

class GetScheduleTimeList extends ProfileEvent {

  const GetScheduleTimeList();

  @override
  List<Object?> get props => [];
}

class AddFileImages extends ProfileEvent {
  final File file;
  final String type;
  const AddFileImages(this.file, this.type);
  @override
  List<Object?> get props => [file,type];
}

class DeleteFileImages extends ProfileEvent {
  final File file;
  final String type;
  final int index;
  const DeleteFileImages(this.file, this.type,this.index);
  @override
  List<Object?> get props => [file,type,index];
}
