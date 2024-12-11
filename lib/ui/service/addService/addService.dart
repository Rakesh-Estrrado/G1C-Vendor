import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/commonVerification/CommonVerificationProgress.dart';
import 'package:g1c_vendor/ui/service/addService/bloc/add_service_bloc.dart';
import 'package:g1c_vendor/ui/service/bloc/service_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextFieldWithRM.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

import '../../../utils/image_constant.dart';
import '../../../utils/widgets/CommonTextField2.dart';
import '../addMoreServices/AddMoreServices.dart';

class AddService extends StatelessWidget {
  AddService({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) =>
        AddServiceBloc(context)
          ..getCategories(),
        child: AddService());
  }

  @override
  Widget build(BuildContext context) {
    AddServiceBloc addServiceBloc = context.read<AddServiceBloc>();
    return Background(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomAppBar2(title: "Add Service"),
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<AddServiceBloc, AddServiceState>(
                              buildWhen: (previous, current) =>
                              previous.categoryList != current.categoryList,
                              builder: (context, state) {
                                var catList = state.categoryList
                                    .map((e) => e.categoryName)
                                    .toList();
                                if (catList.isNotEmpty) {
                                  addServiceBloc
                                    ..updateSelectCatId(
                                        state.categoryList.first.categoryId,
                                        state.categoryList.first.categoryName);
                                }
                                if (state.categoryList.isNotEmpty) {
                                  addServiceBloc
                                    ..getServiceCategories(
                                        state.categoryList.first.categoryId);
                                }
                                return CommonDropDown(
                                  labelText: "Category",
                                  dropDownList: catList,
                                  onSelected: (val) {
                                    var catId = state.categoryList
                                        .firstWhere((e) =>
                                    e.categoryName == val)
                                        .categoryId;
                                    var catName = state.categoryList
                                        .firstWhere((e) =>
                                    e.categoryName == val)
                                        .categoryName;
                                    addServiceBloc..getServiceCategories(catId);
                                    addServiceBloc
                                      ..updateSelectCatId(catId, catName);
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            BlocBuilder<AddServiceBloc, AddServiceState>(
                              buildWhen: (previous, current) =>
                              previous.subcategories != current.subcategories,
                              builder: (context, state) {
                                var subCategories = state.subcategories
                                    .map((e) => e.subcategoryName)
                                    .toList();
                                if (subCategories.isNotEmpty) {
                                  addServiceBloc
                                    ..updateSelectServiceId(
                                        state.subcategories.first.subcategoryId,
                                        state.subcategories.first
                                            .subcategoryName);
                                }
                                return subCategories.isEmpty
                                    ? SizedBox()
                                    : CommonDropDown(
                                  labelText: "Service Category",
                                  dropDownList: subCategories,
                                  onSelected: (val) {
                                    var id = state.subcategories
                                        .firstWhere(
                                            (e) => e.subcategoryName == val)
                                        .subcategoryId;
                                    addServiceBloc
                                      ..updateSelectServiceId(id, val);
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            BlocSelector<AddServiceBloc,
                                AddServiceState,
                                String?>(
                              selector: (state) => state.desc,
                              builder: (context, desc) {
                                return CommonTextField(
                                    labelText: "Description",
                                    hintText: "Description",
                                    maxLines: 3,
                                    onChanged: (val) =>
                                        addServiceBloc.addValues(val, "desc"));
                              },
                            ),
                            SizedBox(height: 20),
                            BlocSelector<AddServiceBloc,
                                AddServiceState,
                                String?>(
                              selector: (state) => state.totalHours,
                              builder: (context, totalHours) {
                                return CommonTextField(
                                    labelText: "Total Hours",
                                    hintText: "Total Hours",
                                    keyboardType: TextInputType.number,
                                    onChanged: (val) =>
                                        addServiceBloc.addValues(
                                            val, "totalHours"));
                              },
                            ),
                            SizedBox(height: 20),
                            BlocSelector<AddServiceBloc,
                                AddServiceState,
                                String?>(
                              selector: (state) => state.price,
                              builder: (context, price) {
                                return CommonTextFieldWithRM(
                                    labelText: "Price",
                                    hintText: "0",
                                    keyboardType: TextInputType.number,
                                    secondLabelText: "(Min RM 120.00)",
                                    onChanged: (val) =>
                                        addServiceBloc.addValues(val, "price"));
                              },
                            ),
                            SizedBox(height: 20),
                            BlocSelector<AddServiceBloc,
                                AddServiceState,
                                String?>(
                                selector: (state) => state.disPrice,
                                builder: (context, disPrice) {
                                  return CommonTextFieldWithRM(
                                      labelText: "Discount Price",
                                      hintText: "0",
                                      keyboardType: TextInputType.number,
                                      onChanged: (val) =>
                                          addServiceBloc.addValues(val, "disPrice"));
                                }),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: BlocBuilder<
                                      AddServiceBloc,
                                      AddServiceState>(
                                    buildWhen: (previous, current) =>
                                    previous.startDate != current.startDate,
                                    builder: (context, state) {
                                      var controller = TextEditingController(
                                          text: state.startDate);
                                      return InkWell(
                                        onTap: () {
                                          showDatePicker(
                                              context: context,
                                              initialDate: state.startDate!
                                                  .isEmpty
                                                  ? DateTime.now()
                                                  : DateTime.tryParse(
                                                  state.startDate!),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2900))
                                              .then((pickedDate) {
                                            if (pickedDate == null) {
                                              return;
                                            }
                                            var startDate = pickedDate
                                                .toIso8601String()
                                                .toDD_MM_YYYY();
                                            addServiceBloc.addValues(
                                                startDate.toString(),
                                                "startDate");
                                          });
                                        },
                                        child: CommonTextField(
                                            labelText: "Discount Start Date",
                                            hintText: "dd/mm/yyyy",
                                            isEditable: false,
                                            controller: controller,
                                            suffixIcon: icCalendarText,
                                            onChanged: (val) {}),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: BlocBuilder<
                                      AddServiceBloc,
                                      AddServiceState>(
                                    buildWhen: (previous, current) =>
                                    previous.endDate != current.endDate,
                                    builder: (context, state) {
                                      var controller = TextEditingController(
                                          text: state.endDate);

                                      return InkWell(
                                        onTap: () {
                                          showDatePicker(
                                              context: context,
                                              initialDate: state.endDate!
                                                  .isEmpty
                                                  ? DateTime.now()
                                                  : DateTime.tryParse(
                                                  state.endDate!),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2900))
                                              .then((pickedDate) {
                                            if (pickedDate == null) {
                                              return;
                                            }
                                            var endDate = pickedDate
                                                .toIso8601String()
                                                .toDD_MM_YYYY();

                                            addServiceBloc.addValues(
                                                endDate.toString(), "endDate");
                                          });
                                        },
                                        child: CommonTextField(
                                            labelText: "Discount End Date",
                                            hintText: "dd/mm/yyyy",
                                            isEditable: false,
                                            controller: controller,
                                            suffixIcon: icCalendarText,
                                            onChanged: (val) {}),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            BlocBuilder<AddServiceBloc, AddServiceState>(
                              builder: (context, state) {
                                var addOnLists =
                                state.addOnListData.map((e) => e.name).toList();
                                var selectedAddOnId;
                                var selectedAddOnName;
                                if (state.addOnListData.isNotEmpty) {
                                  selectedAddOnId =
                                      state.addOnListData.first.id;
                                  selectedAddOnName =
                                      state.addOnListData.first.name;
                                }
                                return state.catId != 3
                                    ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonDropDown(
                                            labelText: "Service Category",
                                            dropDownList: addOnLists,
                                            onSelected: (val) {
                                              selectedAddOnName = val;
                                              selectedAddOnId = state
                                                  .addOnListData
                                                  .firstWhere(
                                                      (e) => e.name == val)
                                                  .id;
                                            },
                                          ),
                                        ),
                                        Container(
                                            height: 45,
                                            width: 45,
                                            margin: EdgeInsets.only(
                                                left: 10, top: 26),
                                            child: CommonButton(
                                                label: "+",
                                                onTap: () {
                                                  addServiceBloc
                                                    ..addServiceAddOns(
                                                        selectedAddOnId,
                                                        selectedAddOnName,
                                                        true,
                                                        0);
                                                }))
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.addOnList.length,
                                        itemBuilder: (context, i) {
                                          var addOns = state.addOnList[i];
                                          return Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("${addOns.name}",
                                                      style: textStyleRegular),
                                                  Spacer(),
                                                  InkWell(
                                                      onTap: () =>
                                                      context
                                                          .read<
                                                          AddServiceBloc>()
                                                        ..addServiceAddOns(
                                                            selectedAddOnId,
                                                            selectedAddOnName,
                                                            false,
                                                            i),
                                                      child: CustomImageView(
                                                          imagePath: icDelete,
                                                          height: 35))
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              CommonTextField(
                                                  labelText: "Duration",
                                                  hintText: "Duration",
                                                  keyboardType:
                                                  TextInputType.number,
                                                  controller: addOns.time,
                                                  onChanged: (val) {}),
                                              SizedBox(height: 20),
                                              CommonTextFieldWithRM(
                                                  labelText: "Price",
                                                  hintText: "0",
                                                  keyboardType:
                                                  TextInputType.number,
                                                  controller: addOns.price,
                                                  onChanged: (val) {}),
                                              SizedBox(height: 30),
                                            ],
                                          );
                                        })
                                  ],
                                )
                                    : SizedBox();
                              },
                            ),
                            SizedBox(height: 40),
                            ActionButtonsRow(
                              onCancel: () => Navigator.pop(context),
                              onSubmit: () => addServiceBloc..addNewServiceToDraft(),
                              submitText: "Save to Drafts",
                            ),
                            SizedBox(height: 20),
                          ]),
                    )),
              )
            ],
          ),
        ));
  }
}
