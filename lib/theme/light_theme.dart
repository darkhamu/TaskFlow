import 'package:flutter/material.dart';
import 'package:task_flow/theme/theme.dart';

final ligthTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 240),
  useMaterial3: true,
  textTheme: textTheme,
  dividerTheme: DividerThemeData(color: Colors.grey.withAlpha(50)),
  colorScheme: const ColorScheme.light(primary: primaryColor),
);
