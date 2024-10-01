import 'package:day_night_time_picker/lib/state/time.dart';

class TimeSlot {
  String? name;
  Time? startTime;
  Time? endTime;

  TimeSlot({
    this.name,
    this.startTime,
    this.endTime,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimeSlot &&
        other.name == name &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode => name.hashCode ^ startTime.hashCode ^ endTime.hashCode;

  TimeSlot copyWith({
    Time? startTime,
    Time? endTime,
    String? name,
  }) {
    return TimeSlot(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      name: name ?? this.name,
    );
  }
}
