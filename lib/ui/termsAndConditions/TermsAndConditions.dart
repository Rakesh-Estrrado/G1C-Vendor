import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:g1c_vendor/ui/auth/register/bloc/register_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';

class TermsAndConditions extends StatelessWidget {
  final title;

  const TermsAndConditions({super.key, required this.title});

  static Widget builder(BuildContext context,String title) {
    return BlocProvider(
        create: (context) =>
        RegisterBloc(context)
          ..getTermsAndConditions(),
        child: TermsAndConditions(title: title));
  }

  @override
  Widget build(BuildContext context) {
    var html = "";

    return Background(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomAppBar2(title: "$title"),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<RegisterBloc, RegisterState>(
                    buildWhen: (previous, current) =>
                    previous.termsAndConditionsData !=
                        current.termsAndConditionsData,
                    builder: (context, state) {
                      if (title == "Terms of Use") {
                        html = state.termsAndConditionsData?.termsAndConditions ?? "";
                      } else if (title == "Privacy Policy") {
                        html = state.termsAndConditionsData?.privacyPolicy ?? "";
                      } else if (title == "PDPA & NDA"||title == "PDPA"||title == "NDA") {
                        html = state.termsAndConditionsData?.pdpa ?? "";
                      }
                      return HtmlWidget(html);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
