import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/NoDataView.dart';
import 'package:sizer/sizer.dart';
import 'bloc/service_details_bloc.dart';
import 'model/service_details_model.dart';

class ServiceDetails extends StatelessWidget {
  ServiceDetails({super.key});

  final ValueNotifier<int> selectedTab = ValueNotifier(0);
  final List<String> tabs = ["Details", "Preferences"];

  static Widget builder(BuildContext context, int id) {
    return BlocProvider(
        create: (context) => ServiceDetailsBloc(context)..getServiceDetails(id),
        child: ServiceDetails());
  }

  @override
  Widget build(BuildContext context) {
    var serviceMediaIndex = ValueNotifier(0);
    return Background(
      child: BlocBuilder<ServiceDetailsBloc, ServiceDetailsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          ServiceData? serviceData;
          List<PreferenceList>? preferenceList;
          if (state.serviceData.isNotEmpty) {
            serviceData = state.serviceData.first;
            preferenceList = state.preferenceList;
          }
          return Container(
            height: 100.h,
            width: 100.w,
            child: Stack(
              children: [
                state.isLoading
                    ? SizedBox()
                    : state.serviceData.isEmpty
                        ? NoDataView(msg: "")
                        : ValueListenableBuilder(
                            valueListenable: serviceMediaIndex,
                            builder: (context, val, child) {
                              return CustomImageView(
                                  imagePath: serviceData!.serviceMedia.isEmpty
                                      ? ""
                                      : serviceData
                                          .serviceMedia[serviceMediaIndex.value]
                                          .filePath,
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover);
                            }),
                Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black45),
                            child: Center(
                                child: Icon(Icons.arrow_back,
                                    color: Colors.white))))),
                state.isLoading
                    ? SizedBox()
                    : state.serviceData.isEmpty
                        ? NoDataView(msg: "")
                        : Positioned(
                            top: 160,
                            left: 1,
                            right: 1,
                            child: Center(
                              child: SizedBox(
                                height: 45,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: serviceData?.serviceMedia.length,
                                  itemBuilder: (context, i) {
                                    var imageUrl =
                                        serviceData?.serviceMedia[i].filePath;
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: InkWell(
                                        onTap: () =>
                                            serviceMediaIndex.value = i,
                                        child: CustomImageView(
                                          imagePath: imageUrl,
                                          height: 45,
                                          width: 45,
                                          fit: BoxFit.cover,
                                          radius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                state.isLoading
                    ? SizedBox()
                    : state.serviceData.isEmpty
                        ? NoDataView(msg: "No Service Details Found.")
                        : Positioned(
                            top: 200,
                            left: 1,
                            right: 1,
                            child: Container(
                              height: 80.h,
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(12),
                              decoration:
                                  semiCircleBox(color: darkBlue, radius: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${serviceData?.serviceName}",
                                      style: textStyleSemiBoldMedium),
                                  SizedBox(height: 6),
                                  gradientContainer(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 4.0),
                                      child: Wrap(
                                        children: [
                                          Text(
                                              "RM ${serviceData?.servicePrice.toStringAsFixed(2)}",
                                              style: textStyleSemiBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      Colors.white)),
                                          Text(
                                              "  RM ${serviceData?.serviceDiscountPrice.toStringAsFixed(2)}",
                                              style: textStyleSemiBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 14.sp)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: darkBlue200,
                                    ),
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 4.0),
                                      child: ValueListenableBuilder(
                                        valueListenable: selectedTab,
                                        builder: (context, _, __) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: tabs
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              int index = entry.key;
                                              var tab = entry.value;
                                              return Expanded(
                                                child: Center(
                                                  child:
                                                      buildTabHead(tab, index),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  ValueListenableBuilder(
                                    valueListenable: selectedTab,
                                    builder: (context, _, __) {
                                      switch (selectedTab.value) {
                                        case 0:
                                          return Expanded(
                                              child: ServiceDetailsWidget(
                                                  serviceData));
                                        case 1:
                                          return Expanded(
                                              child:
                                                  ServiceDetailsPreferenceWidget(
                                                      preferenceList));
                                        default:
                                          return const Text("Default case");
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ServiceDetailsWidget(ServiceData? serviceData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Category", style: textStyleRegular.copyWith(fontSize: 14.sp)),
        Text("${serviceData?.serviceCategory}", style: textStyleSemiBold),
        const SizedBox(height: 20),
        Text("Total Hours", style: textStyleRegular.copyWith(fontSize: 14.sp)),
        Text("${serviceData?.serviceTotalHours}", style: textStyleSemiBold),
        const SizedBox(height: 20),
        Text("${serviceData?.serviceDescription}", style: textStyleRegular),
      ],
    );
  }

  Widget ServiceDetailsPreferenceWidget(List<PreferenceList>? preferenceList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: preferenceList?.length,
      itemBuilder: (context, i) {
        var parentPreference = preferenceList![i];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${parentPreference.name}",
              style: textStyleRegular.copyWith(fontSize: 15.sp),
            ),
            SizedBox(height: 5),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: parentPreference.values.asMap().entries.map((entry) {
                int index = entry.key;
                var preferenceValue = entry.value;
                return preferenceValue.checked
                    ? Text(
                        "${index == 0 ? "" : "| "} ${preferenceValue.value}",
                        style: textStyleSemiBold,
                        textAlign: TextAlign.center,
                      )
                    : SizedBox();
              }).toList(),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget buildTabHead(String title, int index) {
    return InkWell(
      onTap: () => selectedTab.value = index,
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: selectedTab.value == index ? darkBlue600 : Colors.transparent,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(title, style: textStyleSemiBold),
          ),
        ),
      ),
    );
  }
}
