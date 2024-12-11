class Schedule {
  final Map<String, List<TimeSlot>> schedule;

  Schedule({required this.schedule});

  // Factory constructor to create Schedule from a JSON-like Map
  factory Schedule.fromMap(Map<String, List<Map<String, dynamic>>> map) {
    return Schedule(
      schedule: map.map((day, slots) => MapEntry(
        day,
        slots.map((slot) => TimeSlot.fromMap(slot)).toList(),
      )),
    );
  }

  // Convert Schedule object back to Map
  Map<String, List<Map<String, dynamic>>> toMap() {
    return schedule.map((day, slots) => MapEntry(
      day,
      slots.map((slot) => slot.toMap()).toList(),
    ));
  }

  // Add a new TimeSlot to a specific day
  void addTimeSlot(String day, {TimeSlot? timeSlot}) {
    if(timeSlot!=null) {
      if (schedule.containsKey(day)) {
        schedule[day]!.add(timeSlot);
      } else {
        schedule[day] = [timeSlot];
      }
    }
  }

  // Remove a TimeSlot from a specific day based on start time and end time
  void removeTimeSlot(String day, String startTime, String endTime) {
    schedule[day]?.removeWhere(
          (slot) => slot.startTime == startTime && slot.endTime == endTime,
    );
  }

  // Update a specific TimeSlot by finding it and setting new values
  void updateTimeSlot(
      String day, String startTime, String endTime, TimeSlot newSlot) {
    List<TimeSlot>? slots = schedule[day];
    if (slots != null) {
      int index = slots.indexWhere(
              (slot) => slot.startTime == startTime && slot.endTime == endTime);
      if (index != -1) {
        slots[index] = newSlot;
      }
    }
  }
}

class TimeSlot {
  final String?  startTime;
  final String?  endTime;
  final int?   maxBookings;

  TimeSlot({
    this.startTime,
    this.endTime,
    this.maxBookings,
  });

  // Factory constructor to create TimeSlot from a Map
  factory TimeSlot.fromMap(Map<String, dynamic> map) {
    return TimeSlot(
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      maxBookings: map['maxBookings'] as int,
    );
  }

  // Convert TimeSlot object back to Map
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'maxBookings': maxBookings,
    };
  }
}
