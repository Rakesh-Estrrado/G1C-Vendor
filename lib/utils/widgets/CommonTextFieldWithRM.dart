import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/colors.dart';

import '../utils.dart';

class CommonTextFieldWithRM extends StatelessWidget {
  final String labelText;
  final String secondLabelText;
  final TextEditingController? controller;
  final String? hintText;
  final bool isRequired;
  final bool isPassword;
  final bool isEditable;
  final TextInputType keyboardType;
  final TextStyle? textStyle = textStyleRegular;
  final int? maxLines ;
  final Function(String)? onChanged;

  CommonTextFieldWithRM({
    Key? key,
    required this.labelText,
    this.controller,
    this.hintText,
    this.isEditable = true,
    this.isRequired = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.secondLabelText = "",
    this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text with asterisk for required fields
        Row(
          children: [
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
                      style: textStyleRegular.copyWith(color: Colors.red), // Style for the asterisk
                    ),
                ],
              ),
            ),
            Spacer(),
            if(secondLabelText.isNotEmpty)Text(  secondLabelText,
              style: textStyleRegular)
          ],
        ),

        SizedBox(height: 8.0),
        // Input field
        Stack(
          children: [

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
                fillColor: darkBlue,
            
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderBlue, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderBlue, width: 1.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: onChanged,
            ),
            Positioned(
              right: 1,
              child: Container(
                width: 50,
                height: 50,
                decoration: semiCircleBox(color: borderBlue, radius: 10),
                child: Center(child: Text("RM",style: textStyleSemiBold)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
