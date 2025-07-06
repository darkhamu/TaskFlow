import 'package:flutter/material.dart';

TimeOfDay? parseTimeOfDay(String? timeString) {
  try {
    if (timeString != null) {
      final cleanString = timeString
          .replaceAll('TimeOfDay(', '')
          .replaceAll(')', '');

      final parts = cleanString.split(':');
      if (parts.length != 2) throw FormatException('Invalid time format');

      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      return TimeOfDay(hour: hour, minute: minute);
    }
    return null;
  } catch (e) {
    print('Error parsing TimeOfDay: $e');
    return null;
  }
}

bool listEquals(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
