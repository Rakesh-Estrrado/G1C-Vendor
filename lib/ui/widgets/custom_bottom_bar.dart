import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';

enum BottomBarEnum { Home, Service, Booking, Profile }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});
  Function(BottomBarEnum)? onChanged;
  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}


class CustomBottomBarState extends State<CustomBottomBar> {

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
        icon: icHome,
        title: "Home",
        activeIcon: icHome,
        type: BottomBarEnum.Home),
    BottomMenuModel(
      icon: icService,
      title: "Service",
      activeIcon: icService,
      type: BottomBarEnum.Service,
    ),
    BottomMenuModel(
      icon: icBooking,
      title: "Bookings",
      activeIcon: icBooking,
      type: BottomBarEnum.Booking,
    ),
    BottomMenuModel(
      icon: icProfile,
      title: "Profile",
      activeIcon: icProfile,
      type: BottomBarEnum.Profile,
    )
  ];

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(0))),
      surfaceTintColor: darkBlue200,
      color: darkBlue200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bottomMenuList.asMap().entries.map((entry) {
          int i = entry.key;
          BottomMenuModel item = entry.value;
          return ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context,child,val) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    selectedIndex.value = i;
                    widget.onChanged?.call(bottomMenuList[i].type);
                  },
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                              imagePath:
                              selectedIndex.value == i ? item.activeIcon : item.icon,
                              height: 24.0,
                              width: 24.0,
                              fit: BoxFit.contain,
                            color: selectedIndex.value == i?white:null,
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        }).toList(),
      ),
    );
  }
}


class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.title, required this.type});

  String icon;

  String title;

  String activeIcon;

  BottomBarEnum type;
}

