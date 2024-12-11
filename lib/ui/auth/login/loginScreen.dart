import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/auth/login/bloc/login_bloc.dart';
import 'package:g1c_vendor/ui/auth/register/registerScreen.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:sizer/sizer.dart';

import '../../../di/AppLocator.dart';
import '../../../utils/sessionManager.dart';
import '../../../utils/widgets/ActionButtonsRow.dart';

class LoginScreen extends StatefulWidget {
  final from;

  const LoginScreen({super.key, this.from});

  static Widget builder(BuildContext context, {String from = ""}) {
    return BlocProvider(
        create: (context) => LoginBloc(context)..getCountryCodes(),
        child: LoginScreen(from: from));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final sessionManager = AppLocator.instance<SessionManager>();

  final ValueNotifier<bool> showLoginContent = ValueNotifier(false);
  final ValueNotifier<String> selectedCountryCode = ValueNotifier("+60");
  FocusNode myFocusNode = FocusNode();
  late LoginBloc loginBloc;

  List<String> countryCodes = [];
  Duration animationDuration = const Duration(milliseconds: 1000);

  final phoneNumber = TextEditingController();

  @override
  void initState() {
    loginBloc = context.read<LoginBloc>();

    super.initState();
    _delayedFunction();
  }

  void _delayedFunction() async {
    if (widget.from == "inner") {
      animationDuration = const Duration(milliseconds: 0);
      showLoginContent.value = true;
    } else {
      if (!showLoginContent.value) {
        await Future.delayed(const Duration(seconds: 2));
        showLoginContent.value = true;
        if (!sessionManager.isAppAccessMessageShown) {
          showAppUsesPopUp(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
      return  


      Background(
      isAuth: true,
      child: SizedBox(
        height: 100.h,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 100.w,
              height: 94.h,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: ValueListenableBuilder(
                  valueListenable: showLoginContent,
                  builder: (context, child, _) {
                    return Stack(
                      children: [
                        // Logo Animation
                        AnimatedPositioned(
                          duration: animationDuration,
                          curve: Curves.easeInOut,
                          top: showLoginContent.value ? 60 : 100.h / 2 - 80,
                          // Move up when login content is shown
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Hero(
                              tag: 'logo',
                              child: CustomImageView(
                                imagePath: logo,
                              ),
                            ),
                          ),
                        ),
                        // Login Content Animation
                        AnimatedOpacity(
                          duration: animationDuration,
                          opacity: showLoginContent.value ? 1.0 : 0.0,
                          // Fade in/out the login content
                          child: Visibility(
                            visible: showLoginContent.value,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: loginContent(context),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 100),
        Text(
          "Provider Sign in",
          style: textStyleBoldLarge.copyWith(fontSize: 22.sp),
        ),
        const SizedBox(height: 30),
        Text(
          "Phone Number",
          style: textStyleSemiBoldMedium,
        ),
        const SizedBox(height: 10),
        // Phone Number Input Field
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: darkBlue200,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.countryCodes != current.countryCodes,
                builder: (context, state) {
                  countryCodes =
                      state.countryCodes.map((e) => "+${e.phonecode}").toList();

                  return countryCodes.isEmpty
                      ? SizedBox()
                      : Row(
                          children: [
                            Image.asset(logo, height: 24, width: 24),
                            const SizedBox(width: 8),
                            SizedBox(
                                width: 80,
                                child: ValueListenableBuilder<String?>(
                                  valueListenable: selectedCountryCode,
                                  builder: (context, val, child) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          dropdownColor: darkBlue400,
                                          value: selectedCountryCode.value,
                                          isExpanded: true,
                                          hint: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Select State"),
                                          ),
                                          style: textStyleRegular,
                                          items:
                                              countryCodes.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (val) =>
                                              selectedCountryCode.value =
                                                  val.toString(),
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: white),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ],
                        );
                },
              ),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  style: textStyleSemiBoldMedium,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.message == "otpSent") {
              phoneNumber.clear();
            }
          },
          builder: (context, state) {
            return CommonButton(label: "Sign In", onTap: () => login());
          },
        ),

        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create a New Account?",
                style: textStyleSemiBoldMedium.copyWith(color: Colors.white),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => navigateTo(
                      context: context,
                      destination:
                          RegisterScreen.builder(context, countryCodes)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      "Sign Up",
                      style:
                          textStyleSemiBoldMedium.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void login() {
    if (phoneNumber.text.length < 6 || phoneNumber.text.length > 12) {
      showSnackBar(
          context: context,
          msg: "Please mobile number should be more then 6 and less than 12");
      return;
    }
    myFocusNode.unfocus();
    context
        .read<LoginBloc>()
        .setLogin(phoneNumber.text, selectedCountryCode.value);
  }

  void showAppUsesPopUp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: darkBlue,
            border: Border.all(width: 2, color: darkBlue400),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "We Respect Your Privacy",
                style: textStyleSemiBoldMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                "To improve your experience and provide personalized services, we request your permission to collect and use the following information:\n\n"
                "• Phone Number, Email Address, Name: For account creation, communication, and service updates.\n"
                "• Location Data (Precise & Coarse): To offer location-based services and relevant content.\n"
                "• Photos & Videos: To allow you to upload content for services (e.g., service requests or documentation).\n\n"
                "This information may also be used to enhance app functionality and, with your consent, to deliver personalized ads and insights across apps and websites.\n\n"
                "By continuing, you grant us permission to track this activity.",
                style: textStyleRegular,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ActionButtonsRow(
                  onCancel: () => SystemNavigator.pop(),
                  onSubmit: () {
                    Navigator.pop(context);
                    sessionManager.isAppAccessMessageShown = true;
                  },
                  submitText: "Continue"),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
