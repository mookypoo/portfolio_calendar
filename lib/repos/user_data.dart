import 'package:portfolio_calendar/repos/variables.dart';

import '../class/day_class.dart' show DayData;
import '../class/event_class.dart';
import '../class/time_model.dart';
import '../class/user_color.dart';

class UserData {
  List<UserColor> userColors = [
    UserColor(
      color: EventColors.yellow,
      title: "Make Calendar App",
    ),
    UserColor(
      color: EventColors.red,
      title: "Walk the dogs",
    ),
    UserColor(
      color: EventColors.blue,
      title: "Workout",
    ),
    UserColor(
      color: EventColors.orange,
      title: "Study Node.js",
    ),
  ];

  List<Event> userEvents = [
    Event(
      setTime: true,
      color: EventColors.yellow,
      day: DayData(
          month: 6,
          year: 2022,
          date: 12
      ),
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.AM,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Make Calendar App",
    ),
    Event(
      setTime: true,
      color: EventColors.yellow,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 2,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Make Calendar App",
    ),
    Event(
      setTime: false,
      color: EventColors.yellow,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 10,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Make Calendar App",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 19,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 2,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 27,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 4,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 10,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 7,
        year: 2022,
        date: 1,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 14,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 16,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: true,
      color: EventColors.blue,
      startTime: Time(
        hour: 8,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 17,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.PM,
      ),
      title: "Workout",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
          month: 5,
          year: 2022,
          date: 22,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 4,
        year: 2022,
        date: 22,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 4,
        year: 2022,
        date: 2,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 5,
        year: 2022,
        date: 2,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 22,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 5,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 7,
        year: 2022,
        date: 7,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.red,
      startTime: Time(
        hour: 7,
        minute: 0,
        period: Period.AM,
      ),
      day: DayData(
        month: 7,
        year: 2022,
        date: 18,
      ),
      endTime: Time(
        hour: 9,
        minute: 0,
        period: Period.AM,
      ),
      title: "Walk the dogs",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 18,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 21,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 7,
        year: 2022,
        date: 1,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 4,
        year: 2022,
        date: 15,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 6,
        year: 2022,
        date: 30,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 7,
        year: 2022,
        date: 4,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
    Event(
      setTime: false,
      color: EventColors.orange,
      startTime: Time(
        hour: 4,
        minute: 0,
        period: Period.PM,
      ),
      day: DayData(
        month: 7,
        year: 2022,
        date: 12,
      ),
      endTime: Time(
        hour: 7,
        minute: 0,
        period: Period.PM,
      ),
      title: "Study Node.js",
    ),
  ];
}