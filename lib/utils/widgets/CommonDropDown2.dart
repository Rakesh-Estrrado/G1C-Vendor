import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/colors.dart';
import '../utils.dart';

  class CommonDropDown2 extends StatelessWidget {
    final String labelText;
    final List<String> dropDownList;
    final Function(String selected) selectedValue; // Change to ValueNotifier
    final String showSelected; // Change to ValueNotifier
    final bool isRequired;
    final bool showLabel;
    final TextStyle? textStyle;

    CommonDropDown2({
      Key? key,
      required this.labelText,
      required this.selectedValue,
      required this.showSelected,
      required this.dropDownList,
      this.isRequired = false,
      this.showLabel = true,
      this.textStyle,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: darkBlue400,
                  value: showSelected,
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Select State"),
                  ),
                  style: textStyleRegular,
                  items:dropDownList.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    selectedValue(val.toString());
                  },
                  icon: Icon(Icons.keyboard_arrow_down_outlined,color: white,),
                ),

              ),
            ),
          ),
        ],
      );
    }
  }
