import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g1c_vendor/ui/dashBoard/dashboard_screen.dart';
import 'package:g1c_vendor/ui/service/addMoreServices/AddMoreServices.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import '../widgets/custom_image_view.dart';

class CommonVerificationProgress extends StatelessWidget {
  final title;
  final message;
  final cancelButtonText;
  final submitButtonText;
  final Function() onSubmit;

  const CommonVerificationProgress(
      {super.key,
      this.title,
      this.message,
      this.cancelButtonText = "",
      this.submitButtonText,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CustomImageView(imagePath: verificationImage),
              ),
              const SizedBox(height: 24),
              Text(title,
                  style: textStyleSemiBoldMedium, textAlign: TextAlign.center),
              const SizedBox(height: 36),
              Text(message,
                  style: textStyleSmall.copyWith(color: white.withOpacity(0.5)),
                  textAlign: TextAlign.center),
              const SizedBox(height: 36),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: cancelButtonText.isEmpty
              ? CommonButton(
            label: "Ok",
            onTap: () => onSubmit())
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ActionButtonsRow(
                            onCancel: () {
                HapticFeedback.selectionClick();
                Navigator.pop(context);
                Navigator.pop(context);
                            },
                            onSubmit: () => onSubmit(),
                            submitText: submitButtonText,
                            cancelText: cancelButtonText,
                          ),
              ),
        )
      ],
    ));
  }
}
