import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/ui/workers/WorkersPersonalDetails.dart';
import 'package:g1c_vendor/ui/workers/bloc/workers_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/NoDataView.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class ManageWorkers extends StatelessWidget {
  ManageWorkers({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => WorkersBloc(), child: ManageWorkers());
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
        isAuth: false,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const CustomAppBar2(title: "Workers"),
              const SizedBox(height: 15),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1, color: borderBlue),
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
              Expanded(
                  child: true?NoDataView(msg: "No workers to show.."):ListView.builder(
                      shrinkWrap: true,
                      itemCount: 0,
                      itemBuilder: (context, i) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          surfaceTintColor: darkBlue,
                          color: darkBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Center(
                                  child: CustomImageView(
                                      imagePath: dummyImage,
                                      width: 50,
                                      radius: const BorderRadius.all(
                                          Radius.circular(100.0))),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ST01",
                                      style: textStyleSmall.copyWith(
                                          color: white.withOpacity(0.5)),
                                    ),
                                    Text("Edward", style: textStyleRegular),
                                    Text("Cleaning", style: textStyleSmall),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      navigateTo(
                                          context: context,
                                          destination:
                                              WorkersPersonalDetails.builder(
                                                  context));
                                    },
                                    child: CustomImageView(
                                        imagePath: icEdit, height: 24)),
                                SizedBox(width: 6),
                                InkWell(
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                    },
                                    child: CustomImageView(
                                        imagePath: icDelete, height: 24)),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}