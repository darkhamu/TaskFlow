import 'package:flutter/material.dart';

Future<DateTime?> selectDate({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    initialDate: initialDate,
    lastDate: DateTime(2127),
  );
  return pickedDate;
}

Future<TimeOfDay?> selectTime({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
  return pickedTime;
}