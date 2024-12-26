import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/service/addMoreServices/bloc/add_more_services_bloc.dart';
import 'package:g1c_vendor/ui/service/bloc/service_bloc.dart';
import 'package:g1c_vendor/ui/service/serviceDetails/model/service_details_model.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextFieldWithRM.dart';
import 'package:g1c_vendor/utils/widgets/CustomCheckBox.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/widgets/CommonDropDown.dart';
import '../../widgets/custom_image_view.dart';

class AddMoreServices extends StatefulWidget {
  final serviceId;

  AddMoreServices({super.key, this.serviceId});

  static Widget builder(BuildContext context, int id, ServiceBloc serviceBloc) {
    return BlocProvider(
      create: (context) =>
          AddMoreServicesBloc(context, serviceBloc)..getServiceDetails(id),
      child: AddMoreServices(serviceId: id),
    );
  }

  @override
  State<AddMoreServices> createState() => _AddMoreServicesState();
}

class _AddMoreServicesState extends State<AddMoreServices> {
  late AddMoreServicesBloc addMoreServicesBloc;
  final List<String> tabs = ["Details", "Preference", "Media"];
  ValueNotifier<int> selectedTab = ValueNotifier(0);

  @override
  void initState() {
    addMoreServicesBloc = context.read<AddMoreServicesBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar2(title: "Add Service"),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: darkBlue200),
            height: 40,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: ValueListenableBuilder(
                  valueListenable: selectedTab,
                  builder: (context, child, val) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: tabs.asMap().entries.map((entry) {
                        int index = entry.key;
                        var tab = entry.value;
                        return Expanded(
                          child: Center(
                            child: buildTabHead(tab, index), // Use index here
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ),
          SizedBox(height: 6),
          ValueListenableBuilder(
            valueListenable: selectedTab,
            builder: (context, val, child) {
              switch (selectedTab.value) {
                case 0:
                  return Expanded(
                      child: Container(
                          decoration:
                              semiCircleBox(color: darkBlue, radius: 20),
                          padding: EdgeInsets.all(5.0),
                          child: BlocBuilder<AddMoreServicesBloc,
                              AddMoreServicesState>(
                            buildWhen: (previous, current) =>
                                previous.serviceData != current.serviceData,
                            builder: (context, state) {
                              return state.serviceData.isNotEmpty
                                  ? AddService(state.serviceData)
                                  : SizedBox();
                            },
                          )));
                case 1:
                  return Expanded(
                      child: Container(
                          decoration:
                              semiCircleBox(color: darkBlue, radius: 20),
                          padding: EdgeInsets.all(5.0),
                          child: AddPreferences(context)));
                case 2:
                  return Expanded(
                      child: Container(
                          decoration:
                              semiCircleBox(color: darkBlue, radius: 20),
                          padding: EdgeInsets.all(5.0),
                          child: AddServiceMedia(context)));
                default:
                  return const Text("Default case");
              }
            },
          )
        ],
      ),
    ));
  }

  Widget buildTabHead(String title, int index) {
    return Center(
      child: InkWell(
        onTap: () => selectedTab.value = index,
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
      ),
    );
  }

  Widget AddService(List<ServiceData> serviceData) {
    ServiceData service = serviceData.first;
    var descController =
        TextEditingController(text: service.serviceDescription);
    var totalHoursController =
        TextEditingController(text: service.serviceTotalHours.toString());
    var priceController =
        TextEditingController(text: service.servicePrice.toString());

    // var startDateController = TextEditingController(text: service.disStartDate.toDD_MM_YYYY());
    // var endDateController = TextEditingController(text: state.disEndDate.toDD_MM_YYYY());

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Category", style: textStyleRegular.copyWith(fontSize: 14.5.sp)),
        SizedBox(height: 6),
        Text(service.serviceName, style: textStyleSemiBold),
        SizedBox(height: 20),
        Text("Service Category",
            style: textStyleRegular.copyWith(fontSize: 14.5.sp)),
        SizedBox(height: 6),
        Text(service.serviceCategory, style: textStyleSemiBold),
        SizedBox(height: 20),
        BlocSelector<AddMoreServicesBloc, AddMoreServicesState, String?>(
          selector: (state) => state.desc,
          builder: (context, desc) {
            return CommonTextField(
                labelText: "Description",
                hintText: "Description",
                controller: descController,
                maxLines: 3,
                onChanged: (val) => addMoreServicesBloc.addValues(val, "desc"));
          },
        ),
        SizedBox(height: 20),
        BlocSelector<AddMoreServicesBloc, AddMoreServicesState, String?>(
          selector: (state) => state.totalHours,
          builder: (context, totalHours) {
            return CommonTextField(
                labelText: "Total Hours",
                hintText: "0",
                controller: totalHoursController,
                keyboardType: TextInputType.number,
                onChanged: (val) =>
                    addMoreServicesBloc.addValues(val, "totalHours"));
          },
        ),
        SizedBox(height: 20),
        BlocSelector<AddMoreServicesBloc, AddMoreServicesState, String?>(
          selector: (state) => state.price,
          builder: (context, price) {
            return CommonTextFieldWithRM(
                labelText: "Price",
                hintText: "0",
                controller: priceController,
                onChanged: (val) =>
                    addMoreServicesBloc.addValues(val, "price"));
          },
        ),
       /* SizedBox(height: 20),
        BlocSelector<AddMoreServicesBloc, AddMoreServicesState, String?>(
          selector: (state) => state.disPrice,
          builder: (context, disPrice) {
            return CommonTextFieldWithRM(
                labelText: "Discount Price",
                hintText: "0",
                secondLabelText: "(Min RM 120.00)",
                controller: disPriceController,
                onChanged: (val) =>
                    addMoreServicesBloc.addValues(val, "disPrice"));
          },
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
                child: BlocBuilder<AddMoreServicesBloc, AddMoreServicesState>(
              buildWhen: (previous, current) =>
                  previous.startDate != current.startDate,
              builder: (context, state) {
                var startDateController =
                    TextEditingController(text: state.startDate);
                return InkWell(
                  onTap: () =>
                      showDatePickerDialog("startDate", state.startDate),
                  child: CommonTextField(
                      labelText: "Discount Start Date",
                      hintText: "DD/MM/YYYY",
                      isEditable: false,
                      controller: startDateController,
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {}),
                );
              },
            )),
            SizedBox(width: 20),
            Expanded(
              child: BlocBuilder<AddMoreServicesBloc, AddMoreServicesState>(
                buildWhen: (previous, current) =>
                    previous.endDate != current.endDate ||
                    previous.startDate != current.startDate,
                builder: (context, state) {
                  var endDateController =
                      TextEditingController(text: state.endDate);
                  return InkWell(
                    onTap: () =>
                        showDatePickerDialog("endDate", state.startDate),
                    child: CommonTextField(
                        labelText: "Discount End Date",
                        hintText: "DD/MM/YYYY",
                        isEditable: false,
                        controller: endDateController,
                        onChanged: (val) {}),
                  );
                },
              ),
            ),
          ],
        ),*/
        SizedBox(height: 20),
        serviceData.first.categoryId != 3 ? addOnsWidget() : SizedBox(),
        SizedBox(height: 40),
        Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
                width: 110,
                child: CommonButton(
                    height: 40.0,
                    onTap: () {
                      addMoreServicesBloc.updateServiceBasic(widget.serviceId);
                      selectedTab.value = 1;
                    },
                    label: "Next"))),
        SizedBox(height: 20),
      ]),
    ));
  }

  Widget AddPreferences(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<AddMoreServicesBloc, AddMoreServicesState>(
            buildWhen: (previous, current) =>
                previous.preferenceList != current.preferenceList,
            builder: (context, state) {
              print(state.preferenceList);
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.preferenceList.length,
                  itemBuilder: (context, i) {
                    var preference = state.preferenceList[i];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (preference.type != 3) SizedBox(height: 20),
                        if (preference.type != 3)
                          Text("${preference.name}", style: textStyleRegular),
                        if (preference.type != 3) SizedBox(height: 5),
                        if (preference.type == 1) ...[
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: preference.values.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 7.0),
                            itemBuilder: (context, index) {
                              var preferenceValue = preference.values[index];
                              return _buildRadioOption(
                                  (option) => context
                                      .read<AddMoreServicesBloc>()
                                      .checkPreference(i, index, true, "radio"),
                                  preferenceValue);
                            },
                          ),
                        ],
                        if (preference.type == 2) ...[
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: preference.values.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 5.0),
                            itemBuilder: (context, index) {
                              var preferenceValue = preference.values[index];
                              return CustomCheckbox(
                                isChecked: preferenceValue.checked,
                                label: "${preferenceValue.value}",
                                onChanged: (newValue) => context
                                    .read<AddMoreServicesBloc>()
                                    .checkPreference(
                                        i, index, newValue, "checkBox"),
                              );
                            },
                          ),
                        ],
                      ],
                    );
                  });
            },
          ),
          SizedBox(height: 60),
          ActionButtonsRow(
              onCancel: () =>
                  addMoreServicesBloc.updatePreferences(widget.serviceId),
              onSubmit: () {
                addMoreServicesBloc.updatePreferences(widget.serviceId);
                selectedTab.value = 2;
              },
              cancelText: "Save To Drafts",
              submitText: "Next"),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRadioOption(Function(String) onRadioClick, Value option) {
    bool isSelected = option.checked;
    return InkWell(
      onTap: () => onRadioClick(option.value),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Circle with Border
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? red : Colors.white,
                    width: 1.4,
                  ),
                ),
                child: Container(
                  // Inner Circle with Gradient Background
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [Color(0xFFE91775), Color(0xFFFD663B)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : Colors.transparent,
                  ),
                  width: 9,
                  height: 9,
                ),
              ),
            ],
          ),

          SizedBox(width: 8),
          // Label Text
          Text(option.value, style: textStyleRegular),
        ],
      ),
    );
  }

  Widget AddServiceMedia(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        uploadImage("Upload Image"),
        SizedBox(height: 10),
        Container(
          height: 250,
          child: BlocBuilder<AddMoreServicesBloc, AddMoreServicesState>(
            builder: (context, state) {
              return state.serviceData.isEmpty
                  ? SizedBox()
                  : GridView.builder(
                      itemCount: state.serviceData.first.serviceMedia.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5),
                      itemBuilder: (context, index) {
                        var serviceMedia =
                            state.serviceData.first.serviceMedia[index];

                        return Stack(
                          children: [
                            Positioned.fill(
                              child: CustomImageView(
                                  imagePath: serviceMedia.filePath,
                                  radius: BorderRadius.circular(12.0),
                                  fit: BoxFit.fill,
                                  width: 120),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: InkWell(
                                onTap: () =>
                                    addMoreServicesBloc.deleteServiceMedia(
                                        widget.serviceId,
                                        serviceMedia.id,
                                        index),
                                child: CustomImageView(
                                  imagePath: icDelete,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
            },
          ),
        ),
        Spacer(),
        ActionButtonsRow(
            onCancel: () =>
                addMoreServicesBloc.updateServiceMedia(widget.serviceId, false),
            onSubmit: () =>
                  addMoreServicesBloc.updateServiceMedia(widget.serviceId, true),
            cancelText: "Save To Drafts")
      ],
    );
  }

  Widget uploadImage(String label, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label${isRequired ? ' *' : ''}',
          style: textStyleRegular,
        ),
        SizedBox(height: 8.0),
        // Input field
        InkWell(
          onTap: () => showImagePicker(),
          child: Container(
            height: 100,
            decoration: semiCircleBoxWithBorder(color: darkBlue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                    imagePath: icUploadImage, height: 22, width: 22),
                SizedBox(width: 8),
                Text("Upload Image",
                    style: textStyleRegular.copyWith(
                        color: white.withOpacity(0.6)))
              ],
            ),
          ),
        )
      ],
    );
  }

  showDatePickerDialog(String type, String? startDate) {
    DateTime firstDate = type == "startDate"
        ? DateTime(1900)
        : () {
            try {
              return DateFormat("dd-MM-yyyy").parse(startDate.toString());
            } catch (e) {
              return DateTime.now(); // Default to today if parsing fails
            }
          }();

    showDatePicker(
            context: context,
            initialDate: type == "startDate"
                ? DateTime.now()
                : DateFormat("dd-MM-yyyy").tryParse(startDate.toString()),
            firstDate: firstDate,
            lastDate: DateTime(2900))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      var date = pickedDate.toIso8601String().toDMY();
      addMoreServicesBloc.addValues(date, type);
    });
  }

  void showImagePicker() {
    showDialog(
      context: context,
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
                    onTap: () => handleFilePick("camera", ""),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImageView(
                            imagePath: icCamera, width: 80, height: 80),
                        SizedBox(height: 10),
                        Text("Camera", style: textStyleSemiBold)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => handleFilePick("camera", "gallery"),
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

  Future<void> handleFilePick(String source, String imageSource) async {
    var file = await pickFile(source, imageSource, context);
    if (file != null) {
      addMoreServicesBloc.addServiceMedia(file);
    }
  }

  Widget addOnsWidget() {
    return BlocBuilder<AddMoreServicesBloc, AddMoreServicesState>(
      builder: (context, state) {
        print(state.addOnList);
        var addOnLists = state.addOnList.map((e) => e.name).toList();
        var selectedAddOnId;
        var selectedAddOnName;
        if (state.addOnList.isNotEmpty) {
          selectedAddOnId = state.addOnList[0].id;
          selectedAddOnName = state.addOnList[0].name;
        }
        return state.serviceData.isEmpty
            ? SizedBox()
            : !state.serviceData.first.serviceCategory.contains("LifeStyle")
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CommonDropDown(
                              labelText: "AddOns",
                              dropDownList: addOnLists,
                              onSelected: (val) {
                                selectedAddOnName = val;
                                selectedAddOnId = state.addOnList.firstWhere((e) => e.name == val).id;
                              },
                            ),
                          ),
                          Container(
                              height: 45,
                              width: 45,
                              margin: EdgeInsets.only(left: 10, top: 26),
                              child: CommonButton(
                                  label: "+",
                                  onTap: () {
                                    addMoreServicesBloc
                                      ..addServiceAddOns(
                                          selectedAddOnId,
                                          selectedAddOnName,
                                          true,
                                          0,
                                          widget.serviceId,
                                          0);
                                  }))
                        ],
                      ),
                      SizedBox(height: 30),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.serviceAddon.length,
                          itemBuilder: (context, i) {
                            var addOns = state.serviceAddon[i];
                            var addOnsTime = TextEditingController(
                                text: addOns.time.toString());
                            var addOnsPrice = TextEditingController(
                                text: addOns.price.toString());
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text("${addOns.addonName}",
                                        style: textStyleRegular),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          addMoreServicesBloc
                                            ..addServiceAddOns(
                                                selectedAddOnId,
                                                selectedAddOnName,
                                                false,
                                                i,
                                                widget.serviceId,
                                                addOns.id);
                                        },
                                        child: CustomImageView(
                                            imagePath: icDelete, height: 35))
                                  ],
                                ),
                                SizedBox(height: 5),
                                BlocBuilder<AddMoreServicesBloc,
                                    AddMoreServicesState>(
                                  builder: (context, state) {
                                    return CommonTextField(
                                        labelText: "Duration",
                                        hintText: "Duration",
                                        keyboardType: TextInputType.number,
                                        controller: addOnsTime,
                                        onChanged: (val) =>
                                            addMoreServicesBloc.addOnListValues(
                                                val, "duration", i));
                                  },
                                ),
                                SizedBox(height: 20),
                                CommonTextFieldWithRM(
                                    labelText: "Price",
                                    hintText: "0",
                                    keyboardType: TextInputType.number,
                                    controller: addOnsPrice,
                                    onChanged: (val) => addMoreServicesBloc
                                        .addOnListValues(val, "price", i)),
                                SizedBox(height: 30),
                              ],
                            );
                          })
                    ],
                  )
                : SizedBox();
      },
    );
  }
}
