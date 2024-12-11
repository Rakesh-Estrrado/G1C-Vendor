import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/support/tokenCreated.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/CommonDropDown.dart';
import 'package:g1c_vendor/utils/widgets/CommonTextField.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class CreateSupportToken extends StatelessWidget {
  CreateSupportToken({super.key});

  final List<String> ticketTypes = ["General", "Booking"];
  final ValueNotifier<String> selectedTicketType = ValueNotifier("General");
  final ValueNotifier<String> selectedBookingId = ValueNotifier("BK#123");
  final title = TextEditingController();
  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomAppBar2(title: "Create Token"),
          SizedBox(height: 20),
          ValueListenableBuilder(
              valueListenable: selectedTicketType,
              builder: (context, child, val) {
                return CommonDropDown(
                  labelText: "Ticket Type",
                  dropDownList: ticketTypes,
                  selectedValue: selectedTicketType,
                  onSelected: (val){},
                );
              }),
          ValueListenableBuilder(
              valueListenable: selectedTicketType,
              builder: (context, child, val) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    selectedTicketType.value == ticketTypes[1]
                        ? CommonDropDown(
                            labelText: "Booking Id",
                            dropDownList: [
                              "BK#123",
                              "BK#1232",
                              "BK#798",
                              "BK#777"
                            ],
                            selectedValue: selectedBookingId,
                      onSelected: (val){},
                          )
                        : CommonTextField(
                            labelText: "Title",
                            hintText: "Title",
                            controller: message,
                            onChanged: (val) {}),
                  ],
                );
              }),
          SizedBox(height: 20),
          CommonTextField(
              labelText: "Write a Message",
              hintText: "Enter here...",
              controller: message,
              maxLines: 4,
              onChanged: (val) {}),
          SizedBox(height: 20),
          uploadImage("Upload Image"),
          Spacer(),
          ActionButtonsRow(
              onCancel: () => Navigator.pop(context),
              onSubmit: () =>
                  navigateTo(context: context, destination: TokenCreated()),
              submitText: "Create"),
          SizedBox(height: 20),
        ],
      ),
    ));
  }

  Widget uploadImage(String label, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text with asterisk for required fields
        Text(
          '$label${isRequired ? ' *' : ''}',
          style: textStyleRegular,
        ),
        SizedBox(height: 8.0),
        // Input field
        Container(
          height: 100,
          decoration: semiCircleBoxWithBorder(color: darkBlue200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(imagePath: icUploadImage, height: 22, width: 22),
              SizedBox(width: 8),
              Text("Upload Image",
                  style:
                      textStyleRegular.copyWith(color: white.withOpacity(0.6)))
            ],
          ),
        )
      ],
    );
  }
}
