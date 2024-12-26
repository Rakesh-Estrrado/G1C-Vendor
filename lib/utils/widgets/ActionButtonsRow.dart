import 'package:flutter/material.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final String cancelText;
  final String submitText;
  final Color cancelColor;
  final Color submitColor;
  final Color cancelBorderColor;
  final double fontSize;

  const ActionButtonsRow({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.cancelText = "Cancel",
    this.submitText = "Submit",
    this.cancelColor = Colors.red,
    this.submitColor = Colors.red,
    this.cancelBorderColor = Colors.red,
    this.fontSize = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: CommonButton(onTap: ()=>onCancel(),label: cancelText)
        ),
        const SizedBox(width: 24),
        Expanded(
          child: CommonButton(onTap: ()=>onSubmit(),label: submitText)
        ),
      ],
    );
  }
}
