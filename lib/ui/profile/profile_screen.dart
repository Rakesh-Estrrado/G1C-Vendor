import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/auth/login/loginScreen.dart';
import 'package:g1c_vendor/ui/bankDetails/BankDetails.dart';
import 'package:g1c_vendor/ui/companyDetails/CompanyDetails.dart';
import 'package:g1c_vendor/ui/earnings/Earnings.dart';
import 'package:g1c_vendor/ui/profile/bloc/account_bloc.dart';
import 'package:g1c_vendor/ui/profile/updateProfile/updateProfile.dart';
import 'package:g1c_vendor/ui/schedule/Schedule.dart';
import 'package:g1c_vendor/ui/support/Support.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/ui/workers/ManageWorkers.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/ActionButtonsRow.dart';
import 'package:g1c_vendor/utils/widgets/appBar.dart';

import '../../di/AppLocator.dart';
import '../../utils/sessionManager.dart';
import '../termsAndConditions/TermsAndConditions.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) => AccountBloc(context)..getAccountDetails(),
      child: ProfileScreen(),
    );
  }

  final sessionManager = AppLocator.instance<SessionManager>();

  @override
  Widget build(BuildContext context) {
    return Background(
      isAuth: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: "Account"),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                color: darkBlue,
              ),
              child: BlocBuilder<AccountBloc, AccountState>(
                buildWhen: (previous, current) => previous.basicDetails != current.basicDetails,
                builder: (context, state) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => navigateTo(
                          context: context,
                          destination:  BlocProvider.value(
                            value: BlocProvider.of<AccountBloc>(context),
                            child: UpdateProfile(),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: state.basicDetails?.avatar??"",
                              radius: BorderRadius.circular(100.0),
                              fit: BoxFit.cover,
                              height: 70,
                              width: 70,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 24,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.basicDetails?.fname??""} ${state.basicDetails?.lname??""}", style: textStyleBoldLarge,maxLines: 2),
                                  Text("${state.businessDetails?.businessName??""}",
                                      style: textStyleRegular.copyWith(
                                          color: white.withOpacity(0.5))),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: darkBlue200),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tile(icCompany, "Company", () {
                              navigateTo(
                                  context: context,
                                  destination:  BlocProvider.value(
                                    value: BlocProvider.of<AccountBloc>(context),
                                    child: CompanyDetails(),
                                  ));
                            }),
                            tile(icManageWorker, "Manage Workers", () {
                              navigateTo(
                                  context: context,
                                  destination: ManageWorkers.builder(context));
                            }),
                            tile(icBankDetails, "Bank Details", () {
                              navigateTo(
                                  context: context,
                                  destination:  BlocProvider.value(
                                    value: BlocProvider.of<AccountBloc>(context),
                                    child: BankDetails(),
                                  ));
                            }),
                            tile(
                                profileEarning,
                                "Earnings",
                                () => navigateTo(
                                    context: context, destination: Earnings())),
                            tile(
                                icSchedule,
                                "Schedules",
                                () => navigateTo(
                                    context: context, destination: Schedule.builder(context))),
                            tile(
                                icSupport,
                                "Support",
                                () => navigateTo(
                                    context: context, destination: Support())),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: darkBlue200),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tile(
                                    icTermsIfUse,
                                    "Term of Use",
                                    () => navigateTo(
                                        context: context,
                                        destination: TermsAndConditions.builder(
                                            context, "Terms of Use"))),
                                tile(
                                    icPrivacyPolicy,
                                    "Privacy Policy",
                                    () => navigateTo(
                                        context: context,
                                        destination: TermsAndConditions.builder(
                                            context, "Privacy Policy"))),
                                tile(
                                    icPdpa,
                                    "PDPA",
                                    () => navigateTo(
                                        context: context,
                                        destination: TermsAndConditions.builder(
                                            context, "PDPA"))),
                                tile(
                                    icNDA,
                                    "NDA",
                                    () => navigateTo(
                                        context: context,
                                        destination: TermsAndConditions.builder(
                                            context, "NDA"))),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: darkBlue200),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tile(icDeleteAccount, "Delete Account", () {
                              showDeleteAccountAlert(context);
                            }),
                            tile(icSignOut, "SignOut", () {
                              sessionManager.isLogin = false;
                              showSnackBar(
                                  context: context,
                                  msg: "Log out successfully!");
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen.builder(
                                          context,
                                          from: "inner")),
                                  (route) => false);
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tile(String icon, String title, Function() onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CustomImageView(imagePath: icon, height: 18),
              const SizedBox(width: 10),
              Text(title, style: textStyleRegularMedium),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_rounded, color: white, size: 16)
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteAccountAlert(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // To adjust for the keyboard
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: darkBlue,
                  border: Border.all(width: 2, color: darkBlue400),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        "Beware",
                        style: textStyleSemiBoldMedium,
                      )),
                      SizedBox(height: 10),
                      Text(
                          "Are you sure you want to delete your\naccount? This action is irreversible. All\nyour data will be permanently deleted.",
                          style: textStyleRegular,
                          textAlign: TextAlign.center),
                      SizedBox(height: 24),
                      ActionButtonsRow(
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onSubmit: () {
                            Navigator.pop(context);
                          },
                          cancelText: "Yes",
                          submitText: "No"),
                      SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
