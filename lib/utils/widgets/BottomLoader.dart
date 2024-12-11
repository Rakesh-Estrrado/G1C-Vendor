import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';


class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        SpinKitSpinningLines(color: red,size: 40,itemCount: 3),
      ],
    );
  }

}
