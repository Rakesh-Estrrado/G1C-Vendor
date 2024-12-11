import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/colors.dart';
import '../utils.dart';

class CommonTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? hintText;
  final bool isRequired;
  final bool isPassword;
  final bool isEditable;
  final bool showLightBlue;
  final String suffixIcon;
  final TextInputType keyboardType;
  final TextStyle? textStyle = textStyleRegular;
  final int? maxLines;
  final bool? showBoarder;
  final Function(String)? onChanged;

  CommonTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.hintText,
    this.isEditable = true,
    this.isRequired = false,
    this.isPassword = false,
    this.showLightBlue = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon = "",
    this.onChanged,
    this.maxLines = 1,
    this.showBoarder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text with asterisk for required fields
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                  style: textStyleRegular, // Style for the label text
              ),
              if (isRequired) // Check if the field is required
                TextSpan(
                  text: ' *',
                  style: textStyleRegular.copyWith(
                      color: Colors.red), // Style for the asterisk
                ),
            ],
          ),
        ),

        SizedBox(height: 8.0),
        // Input field
        TextField(
          enabled: isEditable,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: textStyle ??
              TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(14.0),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white54),
              filled: true,
              fillColor: showLightBlue?darkBlue400:darkBlue,
              disabledBorder:OutlineInputBorder(
                borderSide: BorderSide(color: showBoarder==true ? borderBlue:Colors.transparent, width: showBoarder==true ? 1:0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderBlue, width: showBoarder==true ? 1:0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkBlue400, width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),

              suffixIcon: suffixIcon.isEmpty
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CustomImageView(imagePath: suffixIcon),
                    ),
              suffixIconConstraints:
                  BoxConstraints.tightFor(height: 40.0, width: 40.0)),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
