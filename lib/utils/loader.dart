import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/navigator_service.dart';

bool isLoaderDialogOpen = false;

void showLoaderDialog() {
  if (isLoaderDialogOpen || NavigatorService.navigatorKey.currentContext == null) {
    return;
  }
  isLoaderDialogOpen = true;
  showDialog(
    context: NavigatorService.navigatorKey.currentContext!,
    builder: (con) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          height: MediaQuery.of(con).size.height,
          width: MediaQuery.of(con).size.width,
          color: Colors.black.withOpacity(0.0),
          child: SpinKitSpinningLines(itemCount: 3, color: red, size: 75.0),
        ),
      );
    },
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.1),
  ).whenComplete(() {
    isLoaderDialogOpen = false;
  });
}
void showBottomLoaderDialog() {
  if (isLoaderDialogOpen || NavigatorService.navigatorKey.currentContext == null) {
    return;
  }
  isLoaderDialogOpen = true;
  showDialog(
    context: NavigatorService.navigatorKey.currentContext!,
    builder: (con) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          height: MediaQuery.of(con).size.height,
          width: MediaQuery.of(con).size.width,
          color: Colors.black.withOpacity(0.0),
          child: SpinKitSpinningLines(itemCount: 3, color: red, size: 75.0),
        ),
      );
    },
    useSafeArea: false,
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.1),
  ).whenComplete(() {
    isLoaderDialogOpen = false;
  });
}

void closeLoaderDialog() {
  if (NavigatorService.navigatorKey.currentContext == null) {
    return;
  }
  if (isLoaderDialogOpen) {
    NavigatorService.navigatorKey.currentState?.pop();
  }
}