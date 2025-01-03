import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/navigator_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;

import '../ui/profile/createProfileSteps/bloc/profile_bloc.dart';
import '../ui/widgets/custom_image_view.dart';
import 'image_constant.dart';

/*void navigateTo({required BuildContext context, required Widget destination}) {
  HapticFeedback.selectionClick();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}*/

void navigateTo(
    {required BuildContext context,
      required Widget destination,
      Function(String)? updated}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => destination))
      .then((result) {
    if (result != null) {
      if (updated != null) {
        updated(result);
      }
    }
  });
}

void showSnackBar(
    {required BuildContext context,
    required String msg,
    int duration = 2,
    int? type}) {

  var snackBar = SnackBar(
    content: Text(msg, style: textStyleRegularMedium),
    duration: Duration(seconds: duration),
    backgroundColor: type == 1 ? red : black,
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


get textStyleSmall => const TextStyle().copyWith(
  color: white,
  fontSize: 14.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

get textStyleSmallSemiBold => const TextStyle().copyWith(
  color: white,
  fontSize: 14.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

TextStyle get textStyleSmallBold => const TextStyle().copyWith(
  color: white,
  fontSize: 14.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);

get textStyleRegular => const TextStyle().copyWith(
  color: white,
  fontSize: 15.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

get textStyleSemiBold => const TextStyle().copyWith(
  color: white,
  fontSize: 15.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

TextStyle get textStyleBold => const TextStyle().copyWith(
  color: white,
  fontSize: 15.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);

get textStyleRegularMedium => const TextStyle().copyWith(
  color: white,
  fontSize: 17.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

get textStyleSemiBoldMedium => const TextStyle().copyWith(
  color: white,
  fontSize: 17.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

get textStyleBoldMedium => const TextStyle().copyWith(
  color: white,
  fontSize: 17.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);

get textStyleRegularLarge => const TextStyle().copyWith(
  color: white,
  fontSize: 20.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

get textStyleSemiBoldLarge => const TextStyle().copyWith(
  color: white,
  fontSize: 20.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

TextStyle get textStyleBoldLarge => const TextStyle().copyWith(
  color: white,
  fontSize: 20.sp,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);


BoxDecoration semiCircleBox({required Color color, required double radius}) {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)), color: color);
}

BoxDecoration semiCircleBoxWithBorder(
    {required Color color, double radius = 10, double boarderWidth = 1}) {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: color,
      border: Border.all(width: boarderWidth, color: borderBlue));
}

BoxDecoration gradientDecor({double radius = 10, double boarderWidth = 1}) {
  return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFE91775), Color(0xFFFD663B)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

get cardShape =>
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)));

Widget gradientContainer(
    {required Widget child, double borderRadius = 6.0, double height = 25}) {
  return Container(
      height: height,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE91775), Color(0xFFFD663B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: child);
}

Future<File?> pickFile(
    String source, String imageSource, BuildContext context) async {
  try {
    if (source == "file") {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ["pdf"]);
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      } else {
        showSnackBar(context: context, msg: "User cancelled the picker");
      }
    } else {
      ImageSource imgSource;
      if (imageSource == "gallery") {
        imgSource = ImageSource.gallery;
      } else {
        imgSource = ImageSource.camera;
      }

      final pickedImage = await ImagePicker().pickImage(source: imgSource);
      if (pickedImage != null) {
        return File(pickedImage.path);
      } else {
        showSnackBar(context: context, msg: "No image selected");
      }
    }
  } catch (e) {
    print('Error picking file or image: $e');
    showSnackBar(context: context, msg: 'Error picking file or image');
  }
  return null;
}

Future<List<File>?> pickMultipleImages(String imageSource, BuildContext context) async {
  try {
    if (imageSource == "gallery") {
      final pickedImages = await ImagePicker().pickMultiImage(imageQuality: 80); // Optional: Set quality
      if (pickedImages.isNotEmpty) {
        return pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
      } else {
        showSnackBar(context: context, msg: "No images selected");
        return null;
      }
    } else if (imageSource == "camera") {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80); // Optional: Set quality
      if (pickedImage != null) {
        return [File(pickedImage.path)];
      } else {
        showSnackBar(context: context, msg: "No image captured");
        return null;
      }
    } else {
      showSnackBar(context: context, msg: "Invalid image source");
      return null;
    }
  } catch (e) {
    print('Error picking file or image: $e');
    showSnackBar(context: context, msg: 'Error picking file or image');
    return null;
  }
}


Future<String> getFileNameWithExtension(File file) async {
  if (await file.exists()) {
    return path.basename(file.path);
  } else {
    return "File";
  }
}

getFileNameWithExtensions(File file) {
  return path.basename(file.path);
}

bool isImage(File file) {
  final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp', 'heic'];
  final fileExtension = file.path.split('.').last.toLowerCase();
  return imageExtensions.contains(fileExtension);
}

extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}

extension TimeFormatExtension on String {
  /// Converts a 12-hour time string (e.g., "12:00 AM") to a 24-hour format string.
  String to24HourFormat() {
    try {
      final parsedTime = DateFormat("hh:mm a").parse(this);
      final formattedTime = DateFormat("HH:mm").format(parsedTime);
      return formattedTime;
    } catch (e) {
      // Print error for debugging and return original string
      print("Error in to24HourFormat: $e");
      return this;
    }
  } /// Converts a 12-hour time string (e.g., "12:00 AM") to a 24-hour format string.
  String to12HourFormat() {
    try {
      final parsedTime = DateFormat("HH:mm").parse(this);
      final formattedTime = DateFormat("hh:mm a").format(parsedTime);
      return formattedTime;
    } catch (e) {
      // Print error for debugging and return original string
      print("Error in to12HourFormat: $e");
      return this;
    }
  }
}

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showSnackBar(
        context: NavigatorService.navigatorKey.currentContext!,
        msg: "Location services are disabled. Please enable the services");
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showSnackBar(
          context: NavigatorService.navigatorKey.currentContext!,
          msg: "Location permissions are denied");
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    showSnackBar(
        context: NavigatorService.navigatorKey.currentContext!,
        msg:
            "Location permissions are permanently denied, we cannot request permissions.");
    return false;
  }
  return true;
}

Future<Placemark?> getAddressFromLatLng(Position position) async {
  try {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placeMarks.isNotEmpty) {
      Placemark place = placeMarks[0];
      return place;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint("Error fetching address: $e");
    return null;
  }
}

void showImagePicker(String selectedFile, {ProfileBloc? profileBloc}) {
  showDialog(
    context: NavigatorService.navigatorKey.currentContext!,
    builder: (con) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          height: 180,
          width: MediaQuery.of(con).size.width,
          margin: EdgeInsets.all(25),
          decoration: semiCircleBox(color: darkBlue200, radius: 10),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => handleFilePick(
                    "camera",
                    "",
                    selectedFile,
                    profileBloc: profileBloc
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(imagePath: icCamera, width: 80, height: 80),
                      SizedBox(height: 10),
                      Text("Camera", style: textStyleSemiBold)
                    ],
                  ),
                ),
                InkWell(
                  onTap: () =>
                      handleFilePick("camera", "gallery", selectedFile,profileBloc: profileBloc),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomImageView(
                          imagePath: icGallery,
                          width: 80,
                          height: 80,
                          color: Color(0xFF8688A1)),
                      SizedBox(height: 10),
                      Text("Gallery", style: textStyleSemiBold)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    useSafeArea: false,
    barrierDismissible: true,
  ).whenComplete(() {});
}

Future<void> handleFilePick(
    String source, String imageSource, String selectedFile,
    {ProfileBloc? profileBloc}) async {
  var file = await pickFile(source, imageSource, NavigatorService.navigatorKey.currentContext!);
  if (file != null) {
    profileBloc?.addFileImages(file, selectedFile);
    if (selectedFile != "doc") {
      Navigator.pop(NavigatorService.navigatorKey.currentContext!);
    }
  }
}



extension DateFormatExtension on String {
  String toDMY() {
    try {
      if (this.isNotEmpty || this != "null" || this != null) {
        DateTime dateTime = DateTime.parse(this);
        final formatter = DateFormat('dd-MM-yyyy');
        return formatter.format(dateTime);
      } else {
        return "";
      }
    } catch (e) {
      return '';
    }
  }
  String toDMMMY() {
    try {
      if (this.isNotEmpty || this != "null" || this != null) {
        DateTime dateTime = DateTime.parse(this);
        final formatter = DateFormat('dd MMM yyyy');
        return formatter.format(dateTime);
      } else {
        return "";
      }
    } catch (e) {
      return '';
    }
  }
  String toYMD() {
    try {
      if (this.isNotEmpty || this != "null" || this != null) {
        DateTime dateTime = DateFormat("dd-MM-yyyy").parse(this);
        final formatter = DateFormat('yyyy-MM-dd');
        return formatter.format(dateTime);
      } else {
        return "";
      }
    } catch (e) {
      return '';
    }
  }

  DateTime toDateTime() {
    try {
      if (this.isNotEmpty || this != "null" || this != null) {
        DateTime dateTime = DateFormat("dd-MM-yyyy").parse(this);
        return dateTime;
      } else {
        return DateTime.now();
      }
    } catch (e) {
      return DateTime.now();
    }
  }
}

Future<Map<String, String>> getDeviceDetails() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceId = "Unknown";
  String deviceName = "Unknown";

  var context = NavigatorService.navigatorKey.currentContext!;
  if (Theme.of(context).platform == TargetPlatform.android) {
    // For Android
    final androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id;
    deviceName = androidInfo.device;
  } else if (Theme.of(context).platform == TargetPlatform.iOS) {
    // For iOS
    final iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.identifierForVendor ?? "Unknown";
    deviceName = iosInfo.name;
  } else {
    print("Unsupported platform");
  }
  return {
    "deviceId": deviceId,
    "deviceName": deviceName,
  };
}

extension FileNameExtractor on String {
  String get fileName {
    return this.split('/').last;
  }
}



void showDatePickerDialog(
    BuildContext context,
    Function(String) dateChosen, {
      bool showPreviousDates = true,
      bool isEndDate = false,
      String initialDate = "",  String endDate = "",
    }) {
  DateTime parsedInitialDate = initialDate.toDateTime();
  DateTime parsedEndDate = endDate.toDateTime();
  print("hello $parsedEndDate");
  showDatePicker(
    context: context,
    initialDate: parsedInitialDate,
    firstDate: showPreviousDates ? DateTime(1900) : isEndDate?parsedEndDate:DateTime.now(),
    lastDate: DateTime(2900),
  ).then((pickedDate) {
    if (pickedDate == null) return;

    dateChosen(pickedDate.toIso8601String().toDMY());
  });
}



TimeOfDay parseTimeOfDay(String time) {
  final parsedTime = DateFormat("HH:mm").parse(time); // Parses "20:40"
  return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
}


String calculateTimeDifference(String startTime, String endTime,{Function(int)? totalMinutes}) {
  try {
    TimeOfDay start = parseTimeOfDay(startTime.to24HourFormat());
    TimeOfDay end = parseTimeOfDay(endTime.to24HourFormat());

    // Convert TimeOfDay to total minutes since midnight
    int startMinutes = start.hour * 60 + start.minute;
    int endMinutes = end.hour * 60 + end.minute;

    // Calculate the difference in minutes
    int differenceInMinutes = endMinutes - startMinutes;
    if(totalMinutes!=null){
      totalMinutes(differenceInMinutes);
    }
    if (differenceInMinutes < 0) {
      return "";
    }

    // Convert minutes to hours and minutes
    int hours = differenceInMinutes ~/ 60;
    int minutes = differenceInMinutes % 60;

    return "${hours} hrs ${minutes.toString().padLeft(2, '0')} min's";
  } catch (e) {
    return "";
  }
}

String formatTime(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  int seconds = 0; // Assuming no seconds since input is in minutes
  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

/*
String formatTime(int totalSeconds) {
  int minutes = totalSeconds ~/ 60; // Get the number of whole minutes
  int seconds = totalSeconds % 60;  // Get the remaining seconds
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}*/
