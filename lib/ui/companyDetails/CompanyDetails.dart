import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/companyDetails/bloc/company_details_bloc.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/CommonDropDown2.dart';
import '../profile/bloc/account_bloc.dart';

class CompanyDetails extends StatefulWidget {
  CompanyDetails({super.key});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  final businessName = TextEditingController();
  final registrationNo = TextEditingController();
  final address = TextEditingController();
  ValueNotifier<String> imageLogo = ValueNotifier("");
  var catId = 0;

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            businessName.text = state.businessDetails?.businessName ?? "";
            registrationNo.text =
                state.businessDetails?.registrationNumber ?? "";
            address.text = state.businessDetails?.address ?? "";
            List<String> serviceCatList =
                state.categoryList.map((e) => e.categoryName).toList();

            return Column(
              children: [
                CustomAppBar2(title: "Company Details"),
                SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: imageLogo,
                                  builder: (context, val, child) {
                                    return CustomImageView(
                                        imagePath: imageLogo.value.isEmpty?state.businessDetails?.logo:imageLogo.value,
                                        radius: BorderRadius.circular(100),
                                        fit: BoxFit.cover,
                                        height: 130,
                                        width: 130);
                                  }),
                              Positioned(
                                right: 2,
                                bottom: 2,
                                child: InkWell(
                                  onTap: ()=>showImagePicker(),
                                  child: CustomImageView(
                                    imagePath: uploadCamera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: CommonTextField(
                            labelText: "Business Name",
                            hintText: "",
                            controller: businessName,
                            onChanged: (val) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: CommonTextField(
                            labelText: "Registration No.",
                            hintText: "",
                            controller: registrationNo,
                            onChanged: (val) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child:  BlocSelector<AccountBloc, AccountState, String?>(
                            selector: (state) => state.selectedCategory,
                            builder: (context, selectedCategory) {
                              return CommonDropDown2(
                                labelText: "Service Category",
                                dropDownList: serviceCatList,
                                selectedValue: (val) {
                                  var categoryId = state.categoryList.firstWhere((e) => e.categoryName == val).categoryId;
                                  context.read<AccountBloc>().updateServiceCategory(categoryId, val);
                                },
                                showSelected: selectedCategory == null || selectedCategory.isEmpty
                                    ? serviceCatList[0]
                                    : selectedCategory
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CommonTextField(
                            labelText: "Address",
                            hintText: "",
                            isEditable: false,
                            controller: address,
                            showBoarder: false,
                            maxLines: 2,
                            onChanged: (val) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: Text("Supporting Docs", style: textStyleRegular)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                state.businessDetails?.businessDocuments.length,
                            itemBuilder: (context, i) {
                              var docs =
                                  state.businessDetails?.businessDocuments[i];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                        imagePath: icPDF, height: 32),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${docs?.file.fileName}",
                                              style: textStyleSmall),
                                          // Text("3 mb", style: textStyleSmall),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: ()=> context.read<AccountBloc>().deleteBusinessDoc(docs!.id,i),
                                      child: CustomImageView(
                                          imagePath: icDelete, height: 18),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: CommonButton(
                            label: "Update",
                            onTap: () {
                              var name = businessName.text;
                              var regNo = registrationNo.text;
                              if(name.isEmpty){
                                showSnackBar(context: context, msg: "pleas enter an valid Business Name");
                                return;
                              }
                              if(regNo.isEmpty){
                                showSnackBar(context: context, msg: "pleas enter an valid Registration No.");
                                return;
                              }
                              context.read<AccountBloc>().updateCompany(name, regNo,imageLogo.value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
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
                    onTap: () => handleFilePick("camera"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomImageView(imagePath: icCamera, width: 80, height: 80),
                        SizedBox(height: 10),
                        Text("Camera", style: textStyleSemiBold)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => handleFilePick("gallery"),
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

  Future<void> handleFilePick(String imageSource) async {
    var file = await pickFile("", imageSource, context);
    Navigator.pop(context);
    if (file != null) {
      imageLogo.value = file.path;
    }
  }
}
