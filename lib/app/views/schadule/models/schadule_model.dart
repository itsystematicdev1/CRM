import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../helper/log.dart';
import '../../../widget/snak_bar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      logError('meeting is Meeting');
      meetingData = meeting;
    } else {
      showCustomSnackBar('Meeting is not Meeting');
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

   Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'fromDateTime': from.toIso8601String(),
      'toDateTime': to.toIso8601String(),
      'backgroundColor': background.value,
      'isAllDay': isAllDay ? 1 : 0,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      map['eventName'],
      DateTime.parse(map['fromDateTime']),
      DateTime.parse(map['toDateTime']),
      Color(map['backgroundColor']),
      map['isAllDay'] == 1,
    );
  }
}
