
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:g1c_vendor/ui/dashBoard/dashboard_screen.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/CommonButton.dart';
import 'package:sizer/sizer.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Icon(Icons.wifi_off_sharp,color: Colors.white,size: 50.sp,),
          SizedBox(height: 24.sp),
          Text("No Internet, or Slow Internet\nplease check your internet connection!",style: textStyleSemiBoldMedium,textAlign: TextAlign.center,),
          SizedBox(height: 24.sp),
          CommonButton(label: "Retry", onTap: ()=>checkInternetAndRedirect(context))

        ],
      ),
    ));
  }

  void checkInternetAndRedirect(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)   ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.vpn)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
              (route) => false);
    }
  }
}