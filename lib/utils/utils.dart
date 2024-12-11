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
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import '../ui/profile/createProfileSteps/bloc/profile_bloc.dart';
import '../ui/widgets/custom_image_view.dart';
import 'image_constant.dart';

void navigateTo({required BuildContext context, required Widget destination}) {
  HapticFeedback.selectionClick();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
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
  String toDD_MM_YYYY() {
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
  String toYYYYMMDD() {
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
    deviceName = androidInfo.device??"Unknown";
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
