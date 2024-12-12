import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/service/addMoreServices/AddMoreServices.dart';
import 'package:g1c_vendor/ui/service/addService/addService.dart';
import 'package:g1c_vendor/ui/service/serviceFilter.dart';
import 'package:g1c_vendor/ui/service/serviceDetails/service_details.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/BottomLoader.dart';
import 'package:g1c_vendor/utils/widgets/RoundAddButton.dart';
import 'package:g1c_vendor/utils/widgets/appBar.dart';
import 'package:g1c_vendor/utils/widgets/customSwitch.dart';
import '../../utils/widgets/NoDataView.dart';
import 'bloc/service_bloc.dart';

class ServiceScreen extends StatefulWidget {
  ServiceScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ServiceBloc(context)..getServiceListAndFilter(1, ""),
        child: ServiceScreen());
  }

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final ScrollController scrollController = ScrollController();
  var searchController = TextEditingController();
  late ServiceBloc serviceBloc;

  @override
  void initState() {
    serviceBloc = context.read<ServiceBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      isAuth: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CustomAppBar(title: "Services"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: semiCircleBoxWithBorder(color: darkBlue200),
                    child: TextField(
                      controller: searchController,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.search,
                      // Adds search IME action
                      onSubmitted: (val) => context
                          .read<ServiceBloc>()
                          .getServiceListAndFilter(1, val),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          context
                              .read<ServiceBloc>()
                              .getServiceListAndFilter(1, "");
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomImageView(imagePath: icSearch),
                        ),
                      ),
                      style: textStyleRegularMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick;
                    navigateTo(
                      context: context,
                      destination: BlocProvider.value(
                        value: BlocProvider.of<ServiceBloc>(context),
                        child: ServiceFilter(), // Pass the ServiceFilter widget
                      ),
                    );
                  },
                  child: CustomImageView(
                      imagePath: icFilter,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover),
                )
              ],
            ),
            Expanded(
                child: Stack(
              children: [
                serviceList(context),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: RoundAddButton(
                    onTap: () => navigateTo(
                        context: context,
                        destination: AddService.builder(context,serviceBloc)),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget serviceList(BuildContext context) {
    var pageNo = 1;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        pageNo++;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            pageNo++;
            context.read<ServiceBloc>()
              ..getServiceListAndFilter(pageNo, searchController.text);
          }
        });
      }
    });

    return BlocBuilder<ServiceBloc, ServiceState>(
      buildWhen: (previous, current) =>
          previous.servicesList != current.servicesList ||
          previous.isLoading != current.isLoading ||
          previous.isChanged != current.isChanged,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: state.servicesList.isEmpty
                  ? state.isLoading
                      ? SizedBox()
                      : NoDataView(
                          msg: "No services to show..",
                        )
                  : ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: state.servicesList.length,
                      itemBuilder: (context, i) {
                        var serviceList = state.servicesList[i];
                        return InkWell(
                          onTap: () => navigateTo(context: context, destination: ServiceDetails.builder(context, serviceList.id)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Card(
                              color: darkBlue200,
                              surfaceTintColor: darkBlue200,
                              shape: cardShape,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${serviceList.title}",
                                            style: textStyleSemiBoldMedium),
                                        const SizedBox(height: 5),
                                        Text("${serviceList.category}",
                                            style: textStyleSmall),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("RM ${serviceList.price}",
                                                style:
                                                    textStyleRegular.copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor:
                                                            white)),
                                            const SizedBox(width: 8.0),
                                            Text("RM ${serviceList.salePrice}",
                                                style: textStyleRegular),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        serviceList.approvalStatus == 1
                                            ? CustomSwitch(
                                                value: serviceList.status == 1,
                                                onChanged: (val) => serviceBloc
                                                    .updateServiceStatus(
                                                        serviceList.id, i))
                                            :serviceList.approvalStatus==2? Container(
                                                decoration: BoxDecoration(
                                                    color: cardOrange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0))),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
                                                  child: Text(
                                                      "Rejected",
                                                      style: textStyleRegular.copyWith(color: red)),
                                                ),
                                              ) :Container(
                                                decoration: BoxDecoration(
                                                    color: cardOrange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4.0))),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                                  child: Text("Pending For Approval", style: textStyleRegular.copyWith(color: orange)),
                                                ),
                                              )
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        serviceList.approvalStatus==2?InkWell(
                                            onTap: () => context
                                                .read<ServiceBloc>()
                                                .deleteService(i),
                                            child: Material(
                                                color: Colors.transparent,
                                                child: CustomImageView(
                                                    imagePath: icDelete))):SizedBox(),
                                        const SizedBox(width: 8),
                                        InkWell(
                                            onTap: () => navigateTo(
                                                context: context,
                                                destination:
                                                    AddMoreServices.builder(
                                                        context,serviceList.id,serviceBloc)),
                                            child: Material(
                                                color: Colors.transparent,
                                                child: CustomImageView(
                                                    imagePath: icEdit))),
                                        const SizedBox(width: 8),
                                        CustomImageView(
                                          imagePath: serviceList.image,
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.cover,
                                          radius: BorderRadius.circular(10.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ),
            state.isBottomLoading ? BottomLoader() : SizedBox()
          ],
        );
      },
    );
  }
}
