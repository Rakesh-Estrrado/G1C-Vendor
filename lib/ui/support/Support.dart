import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/support/createSupportToken.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class Support extends StatelessWidget {
  const Support({super.key});
  @override
  Widget build(BuildContext context) {
    return Background(child: Padding(padding: EdgeInsets.all(16.0),child: Column(
      children: [
          CustomAppBar2(title: "Support",showMenuIcons: true),
        SizedBox(height: 12),
        Expanded(
          child: Stack(
            children: [
              ListView.builder(shrinkWrap: true,itemCount: 4  ,itemBuilder: (context,i){
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: semiCircleBox(color: darkBlue200, radius: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(


                        children: [
                          Text("#Sup123",style: textStyleSmall.copyWith(color:white.withOpacity(0.5)),),
                          Spacer(),
                          Text("12/09/2024",style: textStyleSmall.copyWith(color:white.withOpacity(0.5)),),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Issue with Booking Confirmation",style: textStyleRegularMedium),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,color: white,size: 16),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text("I encountered an issue while trying to confirm",style: textStyleRegular.copyWith(color:white.withOpacity(0.5)),maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                );
              }),
              Positioned(
                bottom: 40,
                right: 15,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color(0xFFE91775), Color(0xFFFD663B)],),
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent, // Remove any button shadow
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed:()=> navigateTo(context: context, destination: CreateSupportToken()),
                      child: Icon(Icons.add, size: 35, color: white)
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),));
  }
}