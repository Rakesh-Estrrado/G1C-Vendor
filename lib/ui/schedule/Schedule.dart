import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g1c_vendor/di/AppLocator.dart';
import 'package:g1c_vendor/ui/profile/createProfileSteps/bloc/profile_bloc.dart';
import 'package:g1c_vendor/utils/background.dart';
import 'package:g1c_vendor/utils/colors.dart';
import 'package:g1c_vendor/utils/sessionManager.dart';
import 'package:g1c_vendor/utils/utils.dart';
import 'package:g1c_vendor/utils/widgets/customAppBar2.dart';
import 'package:sizer/sizer.dart';

import '../../utils/image_constant.dart';
import '../../utils/widgets/ActionButtonsRow.dart';
import '../../utils/widgets/CommonTextField.dart';
import '../profile/createProfileSteps/scheduleTime/model/schdule_model.dart';
import '../widgets/custom_image_view.dart';

class Schedule extends StatefulWidget {
  Schedule({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(context)..getScheduleTimeList(), child: Schedule());
  }

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final ValueNotifier<Set<int>> _expandedDays = ValueNotifier<Set<int>>({});
  late ProfileBloc profileBloc;
  SessionManager sessionManager = AppLocator.instance<SessionManager>();

  @override
  void initState() {
    profileBloc = context.read<ProfileBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar2(title: "Schedule"),
            SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _expandedDays,
                builder: (context, expandedDays, child) {
                  return BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      Future.delayed(Duration(seconds: 1), () {
                        print("asdasa");
                        setState(() {});
                      });
                    },
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.schedulesList.length,
                              itemBuilder: (context, index) {
                                final SchedulesList schedule =
                                state.schedulesList[index];
                                return Container(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (expandedDays.contains(index)) {
                                            expandedDays.remove(index);
                                          } else {
                                            expandedDays.add(index);
                                          }
                                          _expandedDays.notifyListeners();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              expandedDays.contains(index)
                                                  ? Icons.keyboard_arrow_down
                                                  : Icons.keyboard_arrow_up,
                                              color: white,
                                            ),
                                            Text(schedule.day,
                                                style: textStyleRegular),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                showAddSchedule(
                                                    context, schedule.day, index);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,
                                                      color: white, size: 16),
                                                  SizedBox(width: 5),
                                                  Text("Add",
                                                      style: textStyleRegular),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Visibility(
                                        visible: expandedDays.contains(index),
                                        child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: schedule.timeSlots.length,
                                          itemBuilder: (context, i) {
                                            var maxBookingsController =
                                            TextEditingController();
                                            maxBookingsController.text = schedule
                                                .timeSlots[i].maxBookings
                                                .toString();

                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: i == 0 ? 0 : 10),
                                                Container(
                                                  height: 1,
                                                  color: borderBlue,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 6),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Start Time",
                                                              style:
                                                              textStyleSmall),
                                                          SizedBox(height: 10),
                                                          Text(
                                                              schedule.timeSlots[i]
                                                                  .startTime
                                                                  .to12HourFormat(),
                                                              style:
                                                              textStyleRegular),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text("End Time",
                                                              style:
                                                              textStyleSmall),
                                                          SizedBox(height: 10),
                                                          Text(
                                                              schedule.timeSlots[i]
                                                                  .endTime
                                                                  .to12HourFormat(),
                                                              style:
                                                              textStyleRegular),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 18),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: CommonTextField(
                                                        labelText:
                                                        "Maximum Booking Per Slot",
                                                        isEditable: false,
                                                        showBoarder: true,
                                                        controller:
                                                        maxBookingsController,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () => profileBloc
                                                        ..deleteScheduleTime(
                                                            schedule.timeSlots[index]
                                                                .slotId,
                                                            i,
                                                            index),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 24.0),
                                                        child: CustomImageView(
                                                            imagePath: icDelete,
                                                            height: 36),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            ActionButtonsRow(
              onCancel: () => Navigator.pop(context),
              onSubmit: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void showAddSchedule(BuildContext buildContext, String day, int index) {
    ValueNotifier<String> time = ValueNotifier("Multiple");
    final startTime = TextEditingController();
    final endTime = TextEditingController();
    var maxBookingsController = TextEditingController();
    showModalBottomSheet(
      context: buildContext,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        "Add Time",
                        style: textStyleRegularMedium,
                      )),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                  onTap: () =>
                                      presentTimePicker(context, startTime),
                                  child: CommonTextField(
                                      isEditable: false,
                                      labelText: "Start Time",
                                      hintText: "hh:mm",
                                      suffixIcon: imgClock,
                                      controller: startTime))),
                          SizedBox(width: 12),
                          Expanded(
                              child: InkWell(
                                  onTap: () =>
                                      presentTimePicker(context, endTime),
                                  child: CommonTextField(
                                      isEditable: false,
                                      labelText: "End Time",
                                      hintText: "hh:mm",
                                      suffixIcon: imgClock,
                                      controller: endTime))),
                        ],
                      ),
                      SizedBox(height: 20),
                      CommonTextField(
                        labelText: "Maximum Booking Per Slot",
                        controller: maxBookingsController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 24),
                      ActionButtonsRow(
                          onCancel: () => Navigator.pop(context),
                          onSubmit: () {
                            if (startTime.text.isEmpty) {
                              showSnackBar(
                                  context: buildContext,
                                  msg: "Please enter start time");
                              return;
                            }

                            if (startTime.text.isEmpty) {
                              showSnackBar(
                                  context: buildContext,
                                  msg: "Please enter end time");
                              return;
                            }
                            if (maxBookingsController.text.isEmpty) {
                              showSnackBar(
                                  context: buildContext,
                                  msg: "Please enter maximum booking for slot");
                              return;
                            }
                            profileBloc
                              ..addScheduleTime(
                                  sessionManager.sellerId,
                                  day,
                                  startTime.text,
                                  endTime.text,
                                  maxBookingsController.text,
                                  "single",
                                  index);
                            _expandedDays.notifyListeners();
                            Navigator.pop(context);
                          })
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

  void presentTimePicker(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final formattedMinutes = selectedTime.minute.toString().padLeft(2, '0');
      controller.text =
          "${selectedTime.hourOfPeriod}:$formattedMinutes ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
    }
  }
}
