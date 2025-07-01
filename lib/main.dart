import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_flow/firebase_options.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/theme/dark_theme.dart';
import 'package:task_flow/theme/light_theme.dart';
import 'package:task_flow/widgets/auth_screens/sign_up_screen.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'TaskFlow',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
    );
  }
}
