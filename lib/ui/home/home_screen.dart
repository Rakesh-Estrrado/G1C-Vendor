import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/ui/home/bloc/home_bloc.dart';
import 'package:g1c_vendor/ui/home/details/revenueGraph/RevenueGraphDetails.dart';
import 'package:g1c_vendor/ui/home/details/summary/Summary.dart';
import 'package:g1c_vendor/ui/widgets/custom_image_view.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/image_constant.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/appBar.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(context), child: HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        isAuth: false,
        child: SingleChildScrollView(
          child: Container(
            height: 100.h,
            width: 100.w,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomAppBar(title: ""),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Summary This Month', style: textStyleRegularMedium),
                    const Spacer(),
                    viewAllText(
                      () =>
                          navigateTo(context: context, destination: Summary()),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                        child: summaryCards(
                            cardPurple, icEarnings, "Earnings", "0")),
                    const SizedBox(width: 4.0),
                    Expanded(
                        child: summaryCards(
                            cardOrange, icCardBookings, "Bookings", "0")),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Expanded(
                        child: summaryCards(
                            cardBlue, icCardService, "Upcoming Bookings", "0")),
                    const SizedBox(width: 4.0),
                    Expanded(
                        child: summaryCards(
                            cardRed, icTodayService, "Today's Booking", "0")),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text('Revenue Graph-Sep 2024',
                        style: textStyleRegularMedium),
                    const Spacer(),
                    viewAllText(
                      () => navigateTo(
                          context: context, destination: RevenueGraphDetails()),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                    elevation: 2,
                    color: darkBlue200,
                    surfaceTintColor: darkBlue200,
                    shape: cardShape,
                    child: Container(
                      height: 260,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: RevenueGraph(),
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  Widget summaryCards(Color color, String icon, String label, String count) {
    return SizedBox(
      height: 52.sp,
      child: Card(
        color: color,
        surfaceTintColor: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(imagePath: icon, width: 30.sp, height: 30.sp),
              const SizedBox(height: 10),
              Text(label,
                  style: textStyleRegularMedium.copyWith(fontSize: 15.sp)),
              Text(count, style: textStyleRegularLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget viewAllText(Function() onTap) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap, child: Text('View All', style: textStyleRegular)));
  }

}

class RevenueGraph extends StatelessWidget {
  const RevenueGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      duration: const Duration(milliseconds: 350),
    );
  }

  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

// LineTouchData for the first line (light blue)
  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => cardBlue,
          tooltipRoundedRadius: 10,
          tooltipPadding: const EdgeInsets.all(12),
          tooltipMargin: 8,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                '\$${touchedSpot.y.toStringAsFixed(2)}',
                textStyleSemiBold,
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((index) {
            return const TouchedSpotIndicatorData(
              FlLine(color: Colors.transparent),
              FlDotData(show: true),
            );
          }).toList();
        },
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1,
        lineChartBarData2,
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = textStyleRegular.copyWith(color: white.withOpacity(0.5));
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('SEPT', style: style);
        break;
      case 4:
        text = Text('OCT', style: style);
        break;
      case 7:
        text = Text('NOV', style: style);
        break;
      case 10:
        text = Text('DEC', style: style);
        break;
      case 13:
        text = Text('JAN', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: darkBlue.withOpacity(0.1), width: 0),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1 => LineChartBarData(
        isCurved: true,
        color: Colors.lightBlue,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.1),
          FlSpot(7, 1.7),
          FlSpot(10, 0.5),
          FlSpot(12, 1.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2 => LineChartBarData(
        isCurved: true,
        color: lightPurple,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2),
          FlSpot(3, 2.9),
          FlSpot(5, 2.1),
          FlSpot(7, 3.7),
          FlSpot(10, 1.5),
          FlSpot(12, 3.2),
          FlSpot(13, 2.8),
        ],
      );
}
