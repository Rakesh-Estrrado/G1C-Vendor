import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:sizer/sizer.dart';

import '../utils.dart';

import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
  final String labelText;
  final List<String> dropDownList;
  final ValueNotifier<String?> selectedValue;
  Function(String) onSelected;
  final bool isRequired;
  final bool showLabel;
  final TextStyle? textStyle;

  CommonDropDown({
    Key? key,
    required this.labelText,
    ValueNotifier<String?>? selectedValue,
    required this.dropDownList,
    required this.onSelected,
    this.isRequired = false,
    this.showLabel = true,
    this.textStyle,
  })  : selectedValue = selectedValue ?? ValueNotifier<String?>(null), super(key: key);

  @override
  Widget build(BuildContext context) {
    if(dropDownList.isNotEmpty) {
      selectedValue.value = dropDownList[0];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text with asterisk for required fields
        if(showLabel)RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                style: textStyle ?? textStyleRegular, // Default to regular style
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: textStyle?.copyWith(color: Colors.red) ??
                      textStyleRegular.copyWith(color: Colors.red), // Style for the asterisk
                ),
            ],
          ),
        ),

        SizedBox(height: 10.0),
        // Input field
        Container(
          width: double.infinity, // Use double.infinity for full width
          height: 45,
          decoration: semiCircleBoxWithBorder(color: darkBlue,radius: 8),
          child: ValueListenableBuilder<String?>(
            valueListenable: selectedValue,
            builder: (context, val, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 6.0,bottom: 6.0,left: 12.0,right: 6.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: darkBlue400,
                    value: selectedValue.value,
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select "),
                    ),
                    style: textStyleRegular,
                    items:dropDownList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      onSelected(val.toString());
                      selectedValue.value = val.toString();
                    },
                    icon: Icon(Icons.keyboard_arrow_down_outlined,color: white,),
                  ),

                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
