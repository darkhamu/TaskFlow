import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_flow/theme/theme.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
  useMaterial3: true,
  textTheme: GoogleFonts.oswaldTextTheme(),
  colorScheme: const ColorScheme.dark(primary: primaryColor),
);
