import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bookings_screen.dart';
import 'package:g1c_vendor/ui/dashBoard/bloc/dash_board_bloc.dart';
import 'package:g1c_vendor/ui/home/home_screen.dart';
import 'package:g1c_vendor/ui/profile/profile_screen.dart';
import 'package:g1c_vendor/ui/service/service_screen.dart';
import 'package:g1c_vendor/ui/widgets/custom_bottom_bar.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/CommonButton.dart';

// ignore_for_file: must_be_immutable
class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<DashBoardBloc>(
      create: (context) => DashBoardBloc(context),
      child: DashboardScreen(),
    );
  }

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {},
        children: <Widget>[
          HomeScreen(),
          ServiceScreen.builder(context),
          BookingsScreen(),
          ProfileScreen.builder(context)
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        switch (type) {
          case BottomBarEnum.Home:
            pageController.jumpToPage(0);
            return;
          case BottomBarEnum.Service:
            pageController.jumpToPage(1);
            return;
          case BottomBarEnum.Booking:
            pageController.jumpToPage(2);
            return;
          case BottomBarEnum.Profile:
            pageController.jumpToPage(3);
            return;
        }
      },
    );
  }

  void showBetaMessage(BuildContext mContext) {
    showModalBottomSheet(
      context: mContext,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: darkBlue,
            border: Border.all(width: 2, color: darkBlue400),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to Our G1C Vendor (Beta Version)",
                style: textStyleSemiBoldMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "This app is currently under construction, with some features and UI still being developed. We are launching this version to gather feedback and build awareness for our upcoming full release. Thank you for your patience and support!",
                style: textStyleRegular,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              CommonButton(label: "Ok", onTap: () => Navigator.pop(mContext)),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

}
