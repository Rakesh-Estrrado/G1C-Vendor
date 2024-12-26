import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bloc/bookings_bloc.dart';
import 'package:g1c_vendor/ui/bookings/bookingPages/cancelledBookings.dart';
import 'package:g1c_vendor/ui/bookings/bookingPages/activeBookings.dart';
import 'package:g1c_vendor/ui/bookings/bookingPages/completedBookings.dart';
import 'package:g1c_vendor/ui/bookings/bookingPages/openBookings.dart';
import 'package:g1c_vendor/ui/bookings/bookingPages/newBookings.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/appBar.dart';

class BookingsScreen extends StatefulWidget {
  BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {

  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  final searchController = TextEditingController();

  final List<String> tabs = ["New", "Open", "Active", "Completed", "Cancelled"];

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Background(
      isAuth: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomAppBar(title: "Bookings"),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: darkBlue200),
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ValueListenableBuilder(
                    valueListenable: selectedTab,
                    builder: (context, child, val) {
                      return Center(
                        child: ListView.builder(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: tabs.length,
                            itemBuilder: (context, i) {
                              return buildTabHead(tabs[i], i);
                            }),
                      );
                    }),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1, color: darkBlue400),
                  color: darkBlue200),
              child: TextField(
                controller: searchController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: CustomImageView(imagePath: icSearch)),
                ),
                style: textStyleRegularMedium,
                onChanged: (value) {},
              ),
            ),
            BlocProvider(
              create: (context) => BookingsBloc(context),
              child: ValueListenableBuilder(
                valueListenable: selectedTab,
                builder: (context, val, child) {
                  return Expanded(
                    child: _buildTabContent(selectedTab.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return NewBookings();
      case 1:
        return OpenBookings();
      case 2:
        return ActiveBookings();
      case 3:
        return CompletedBookings();
      case 4:
        return CancelledBookings();
      default:
        return const Text("Default case");
    }
  }

  // Function to scroll to the top
  void scrollToTop() {
    scrollController.animateTo(
      0, // Scroll position (0 is the start)
      duration: const Duration(milliseconds: 400), // Duration of the animation
      curve: Curves.easeInOut, // The curve of the animation
    );
  }

  // Function to scroll to the bottom
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      // Scroll position to the bottom
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Widget buildTabHead(String title, int index) {
    return InkWell(
      onTap: () {
        selectedTab.value = index;
        if (index >= 3) {
          scrollToBottom();
        } else {
          scrollToTop();
        }
      },
      child: Container(
          height: 30,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              color: selectedTab.value == index
                  ? darkBlue600
                  : Colors.transparent),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(title, style: textStyleSemiBold),
          ))),
    );
  }
}
