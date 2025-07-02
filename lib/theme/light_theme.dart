import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_flow/theme/theme.dart';

final ligthTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 248, 244, 252),
  useMaterial3: true,
  textTheme: GoogleFonts.oswaldTextTheme(),
  dividerTheme: DividerThemeData(color: Colors.grey.withAlpha(50)),
  colorScheme: const ColorScheme.light(primary: primaryColor),
);
