import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:sizer/sizer.dart';


class NoDataView extends StatelessWidget {
  final String msg;
  const NoDataView({super.key,this.msg="No data to show..."});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg,style: textStyleRegular.copyWith(color:white.withOpacity(0.5))),
    );
  }

}
