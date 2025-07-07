import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/language_provider.dart';
import 'package:task_flow/providers/theme_provider.dart';
import 'package:task_flow/utils/reminder_service.dart';
import 'package:task_flow/widgets/base/not_found_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'firebase_options.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/theme/dark_theme.dart';
import 'package:task_flow/theme/light_theme.dart';
import 'package:task_flow/widgets/auth_screens/forget_password_screen.dart';
import 'package:task_flow/widgets/auth_screens/sign_in_screen.dart';
import 'package:task_flow/widgets/auth_screens/sign_up_screen.dart';
import 'package:task_flow/widgets/main_screen/main_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  final themeProvider = ThemeProvider();
  final languageProvider = LanguageProvider();

  await initNotifications();
  await initializeTimezone();
  await requestNotificationPermission();

  await themeProvider.loadTheme();
  await languageProvider.loadLanguage();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  if (kIsWeb) {
    await messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔔 Web Notification: ${message.notification?.title}');
    });
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: languageProvider),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid || Platform.isIOS) {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      locale: Provider.of<LanguageProvider>(context).locale,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'TaskFlow',
      theme: ligthTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.hasData ? const MainScreen() : const SignInScreen();
        },
      ),
      onGenerateRoute: (settings) {
        //проверка вошел ли уже пользователь в аккаунт
        final user = FirebaseAuth.instance.currentUser;

        if (user != null &&
            ['/', '/login', '/registration'].contains(settings.name)) {
          return MaterialPageRoute(builder: (_) => const MainScreen());
        }

        if (user == null && settings.name == '/main') {
          return MaterialPageRoute(builder: (_) => const SignInScreen());
        }

        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => const SignInScreen());
          case '/login/forget_password':
            return MaterialPageRoute(
              builder: (_) => const ForgetPasswordScreen(),
            );
          case '/registration':
            return MaterialPageRoute(builder: (_) => const SignUpScreen());
          case '/main':
            return MaterialPageRoute(builder: (_) => const MainScreen());
          default:
            return MaterialPageRoute(builder: (_) => const NotFoundPage());
        }
      },
    );
  }
}
