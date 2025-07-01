import 'package:flutter/material.dart';
import 'package:task_flow/theme/theme.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 40, 40, 39),
  useMaterial3: true,
  textTheme: textTheme,
  colorScheme: const ColorScheme.dark(primary: primaryColor),
);
