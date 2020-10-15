import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ToPM_AM on TimeOfDay {
  String get formatTimeOfDay {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, this.hour, this.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  TimeOfDay addHour(int hour) {
    return this.replacing(hour: this.hour + hour, minute: this.minute);
  }

  TimeOfDay add({int hour = 0, int minute = 0}) {
    return this.replacing(hour: this.hour + (hour ?? 0), minute: this.minute + (minute ?? 0));
  }

  DateTime timeOfDayToDateTime() {
    final now = DateTime.now();
    return new DateTime(now.year, now.month, now.day, this.hour, this.minute);
  }
}

extension Length on num {
  String get getDistance {
    if (this < 1000) {
      return (this.round().toString()) + " m";
    }
    return (this / 1000).toStringAsFixed(1) + " km";
  }
}

extension NewFormat on DateTime {
  String get dayMonthYearNonUSFormate {
    return DateFormat("d MMMM y").format(this);
  }

  String get dayMonthNonUSFormate {
    return DateFormat("Md").format(this);
  }

  String get daySlashMonthSlashYear {
    return DateFormat.yMd().format(this);
  }
}
