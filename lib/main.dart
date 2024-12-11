import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/di/AppLocator.dart';
import 'package:g1c_vendor/ui/auth/login/loginScreen.dart';
import 'package:g1c_vendor/ui/auth/register/bloc/register_bloc.dart';
import 'package:g1c_vendor/ui/dashBoard/dashboard_screen.dart';
import 'package:g1c_vendor/utils/navigator_service.dart';
import 'package:g1c_vendor/utils/pref_utils.dart';
import 'package:g1c_vendor/utils/sessionManager.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocator.setup();
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) {
    PrefUtils().init();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionManager = AppLocator.instance<SessionManager>();
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(context)),

        ],
          child: MaterialApp(
            title: 'G1C Vendor',
            color: Colors.transparent,
            navigatorKey: NavigatorService.navigatorKey,
            debugShowCheckedModeBanner: false,
            home: sessionManager.isLogin?DashboardScreen():LoginScreen.builder(context),
          ),
      );
    });
  }
}
