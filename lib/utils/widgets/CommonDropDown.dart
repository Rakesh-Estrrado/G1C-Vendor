import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/colors.dart';
import '../utils.dart';


class CommonDropDown extends StatefulWidget {
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
  State<CommonDropDown> createState() => _CommonDropDownState();
}

class _CommonDropDownState extends State<CommonDropDown> {
  @override
  Widget build(BuildContext context) {
    if(widget.dropDownList.isNotEmpty) {
      widget.selectedValue.value = widget.dropDownList[0];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Text with asterisk for required fields
        if(widget.showLabel)RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.labelText,
                style: widget.textStyle ?? textStyleRegular, // Default to regular style
              ),
              if (widget.isRequired)
                TextSpan(
                  text: ' *',
                  style: widget.textStyle?.copyWith(color: Colors.red) ??
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
            valueListenable: widget.selectedValue,
            builder: (context, val, child) {
              return Padding(
                padding: const EdgeInsets.only(top: 6.0,bottom: 6.0,left: 12.0,right: 6.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: darkBlue400,
                    value: widget.selectedValue.value,
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select "),
                    ),
                    style: textStyleRegular,
                    items:widget.dropDownList.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      widget.onSelected(val.toString());
                      widget.selectedValue.value = val.toString();
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
