import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final String label;
  final ValueChanged<bool> onChanged;

  CustomCheckbox({
    required this.isChecked,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              gradient: isChecked
                  ? LinearGradient(
                      colors: [Color(0xFFE91775), Color(0xFFFD663B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : LinearGradient(
                      colors: [Colors.transparent, Colors.transparent],
                    ),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
                width: isChecked ? 0 : 2,
              ),
            ),
            child: isChecked
                ? Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
          SizedBox(width: 8),
          Text(label, style: textStyleRegular),
        ],
      ),
    );
  }
}
