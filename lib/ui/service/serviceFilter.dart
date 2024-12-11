import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/service/bloc/service_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/CustomCheckBox.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

class ServiceFilter extends StatelessWidget {
  ServiceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceBloc>().add(GetSubCategories(0));
    return Background(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar2(title: "Service Filters"),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        BlocBuilder<ServiceBloc, ServiceState>(
                          buildWhen: (previous, current) =>
                              previous.isAllChecked != current.isAllChecked,
                          builder: (context, state) {
                            return CustomCheckbox(
                              isChecked: state.isAllChecked,
                              label: "All",
                              onChanged: (newValue) => context.read<ServiceBloc>()..selectAll(newValue),
                            );
                          },
                        ),

                        SizedBox(height: 20),

                        Text("Category", style: textStyleRegular.copyWith(fontSize: 15.sp)),

                        SizedBox(height: 10),

                        BlocBuilder<ServiceBloc, ServiceState>(
                          builder: (context, state) {
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.categoryList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 0,
                                      childAspectRatio: 5.0),
                              itemBuilder: (context, index) {
                                var category =
                                    state.categoryList[index];
                                return CustomCheckbox(
                                  isChecked: category.isChecked,
                                  label: category.categoryName,
                                  onChanged: (newValue) =>
                                      context.read<ServiceBloc>()
                                        ..selectCategory(index, newValue),
                                );
                              },
                            );
                          },
                        ),

                        SizedBox(height: 20),

                        Text("Subcategory", style: textStyleRegular.copyWith(fontSize: 15.sp)),

                        SizedBox(height: 10),

                        BlocBuilder<ServiceBloc, ServiceState>(
                          builder: (context, state) {
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: state.subcategories.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 0,
                                      childAspectRatio: 5.0),
                              itemBuilder: (context, index) {
                                var subCategory = state.subcategories[index];
                                return CustomCheckbox(
                                  isChecked: subCategory.isChecked,
                                  label: subCategory.subcategoryName,
                                  onChanged: (newValue) => context
                                      .read<ServiceBloc>()
                                    ..selectSubCategory(index, newValue),
                                );
                              },
                            );
                          },
                        ),

                        SizedBox(height: 20),

                        Text("Status", style: textStyleRegular.copyWith(fontSize: 15.sp)),

                        BlocBuilder<ServiceBloc, ServiceState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.approvalStatus.length,
                                itemBuilder: (context, index) {
                                  var status = state.approvalStatus[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomCheckbox(
                                      isChecked: status.isChecked,
                                      label: "${status.status}",
                                      onChanged: (newValue) {
                                        context.read<ServiceBloc>().selectApprovalStatus(index, newValue);
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  ActionButtonsRow(
                    onCancel: () {
                      context.read<ServiceBloc>()..selectAll(false);
                      context.read<ServiceBloc>()..getServiceListAndFilter(1,"");
                      Navigator.pop(context);

                    },
                    onSubmit: () {
                      Navigator.pop(context);
                      context.read<ServiceBloc>()..getServiceListAndFilter(1,"");
                    },
                    cancelText: "Clear",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
