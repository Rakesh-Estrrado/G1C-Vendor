import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import '../widgets/custom_image_view.dart';

class SearchForLocation extends StatelessWidget {
  SearchForLocation({super.key});

  final searchController = TextEditingController();
  final List<String> searchList = [
    "Sarawak Malaysia",
    "Sarawak Stadium Petra Jaya, Kuching, Sarawa...",
    "Sarawak Club Jalan Taman Budaya, Taman Bu...",
    "Sarawak Cultural Village (SCV) Pantai Damai S..."
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: semiCircleBox(color: darkBlue, radius: 10),
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                      contentPadding: EdgeInsets.only(bottom: 8,top: 4),
                      hintText: "Search...",
                      border: InputBorder.none,
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: CustomImageView(imagePath: icSearch)),
                    ),
                    style: textStyleRegular,
                    onChanged: (value) {},
                  ),
                ),

                Card(
                  margin: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 4,
                  color: darkBlue,
                  surfaceTintColor: darkBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CustomImageView(imagePath: icLocationSpotter,height: 16),
                        SizedBox(width: 5),
                        Text("Use Current Location",style: textStyleRegular)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text("${searchList[i]}",style: textStyleRegular,),
                        );
                      }),
                ),
                Spacer(),
                CommonButton(label:"Back" ,onTap: ()=>Navigator.pop(context))
              ],
            ),
          ),
        ));
  }
}
