import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class AssignedWorkers extends StatelessWidget {
  AssignedWorkers({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
        isAuth: false,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const CustomAppBar2(title: "Assign Worker"),
              const SizedBox(height: 15),
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
                    contentPadding: EdgeInsets.only(bottom: 1),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: CustomImageView(imagePath: icSearch)),
                  ),
                  style: textStyleRegularMedium,
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, i) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          surfaceTintColor: darkBlue,
                          color: darkBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CustomImageView(
                                    imagePath: dummyImage,
                                    width: 45,
                                    radius: const BorderRadius.all(
                                        Radius.circular(100.0))),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ST01",style: textStyleSmall.copyWith(color:white.withOpacity(0.5)),),
                                    Text("Edward",style: textStyleRegular),
                                    Text("Cleaning",style: textStyleSmall),
                                  ],
                                ),
                                const Spacer(),
                                CustomImageView(imagePath: tick,height: 14,),
                                const SizedBox(width: 5,)
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
