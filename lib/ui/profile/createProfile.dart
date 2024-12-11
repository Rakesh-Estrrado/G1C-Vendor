import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/profile/createProfileSteps/individual/IndividualStep1.dart';
import 'package:g1c_vendor/ui/profile/createProfileSteps/scheduleTime/ScheduleTime.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'createProfileSteps/bloc/profile_bloc.dart';
import 'createProfileSteps/business/businessStep1.dart';
import 'createProfileSteps/business/businessStep2.dart';
import 'createProfileSteps/business/businessStep3.dart';
import 'createProfileSteps/individual/IndividualStep2.dart';

class CreateProfile extends StatefulWidget {
  final phone;
  final countryCode;
  CreateProfile({super.key, required this.phone, this.countryCode});
  static Widget builder(BuildContext context, phone, countryCode) {
    return BlocProvider(
      create: (context) => ProfileBloc(context)..getServiceCategories(phone,countryCode),
      child: CreateProfile(phone: phone,countryCode:countryCode),
    );
  }

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  final scrollController = ScrollController();


  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>();
  }

  @override
  Widget build(BuildContext context) {

    return Background(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar2(title: "Create Profile", showBackArrow: false),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: darkBlue200,
              ),
              height: 40,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (p, c) =>
                      p.selectedTab != c.selectedTab || p.tabs != c.tabs,
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.tabs.length,
                      itemBuilder: (context, i) {
                        return buildTabHead(i, state);
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (p, c) =>
                  p.selectedTab != c.selectedTab ||
                  p.serviceCategoriesData != c.serviceCategoriesData ||
                  p.tabs != c.tabs,
              builder: (context, state) {
                if (state.selectedTab > 2) {
                  scrollToBottom();
                } else {
                  scrollToTop();
                }
                var serviceCategoriesList = state.serviceCategoriesData;
                var religionList = state.regionalListData;
                var languageList = state.languageListData;
                if (state.selectedOption.contains("Individual")) {
                  switch (state.selectedTab) {
                    case 0:
                      return Expanded(
                          child: IndividualStep1(
                              serviceCategoriesList: serviceCategoriesList,profileBloc: context.read<ProfileBloc>()));
                    case 1:
                      return Expanded(
                          child: IndividualStep2(regionalListData: religionList,languageListData: languageList,
                              profileBloc: context.read<ProfileBloc>()));
                    case 2:
                      context.read<ProfileBloc>()..getCurrentPosition();
                      return Expanded(child: BusinessStep2());
                    case 3:
                      return Expanded(
                          child: BusinessStep3(
                              profileBloc: context.read<ProfileBloc>()));
                    case 4:
                      context.read<ProfileBloc>()..getScheduleTimeList();
                      return Expanded(
                          child: ScheduleTime(
                              sellerId: int.parse(state.sellerId ?? "0"),
                              profileBloc: context.read<ProfileBloc>()));
                    default:
                      return const Text("Default case");
                  }
                } else {
                  switch (state.selectedTab) {
                    case 0:
                      return Expanded(
                          child: BusinessStep1(
                              serviceCategoriesList: serviceCategoriesList,
                              profileBloc: context.read<ProfileBloc>()));
                    case 1:
                      context.read<ProfileBloc>()..getCurrentPosition();
                      return Expanded(child: BusinessStep2());
                    case 2:
                      return Expanded(
                          child: BusinessStep3(
                              profileBloc: context.read<ProfileBloc>()));
                    case 3:
                      context.read<ProfileBloc>()..getScheduleTimeList();
                      return Expanded(
                          child: ScheduleTime(
                              sellerId: int.parse(state.sellerId ?? "0"),
                              profileBloc: context.read<ProfileBloc>()));
                    default:
                      return const Text("Default case");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabHead(int index, ProfileState state) {
    return Center(
      child: Container(
          height: 30,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              color: state.selectedTab == index
                  ? darkBlue600
                  : Colors.transparent),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(state.tabs[index], style: textStyleSemiBold),
          ))),
    );
  }
}

class Field {
  final TextEditingController controller;
  final String errorMsg;
  final bool validateEmail;

  Field(this.controller, this.errorMsg, {this.validateEmail = false});
}
