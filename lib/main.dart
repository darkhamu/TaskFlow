import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'firebase_options.dart';
import 'package:task_flow/generated/l10n.dart';
import 'package:task_flow/theme/dark_theme.dart';
import 'package:task_flow/theme/light_theme.dart';
import 'package:task_flow/widgets/auth_screens/forget_password_screen.dart';
import 'package:task_flow/widgets/auth_screens/sign_in_screen.dart';
import 'package:task_flow/widgets/auth_screens/sign_up_screen.dart';
import 'package:task_flow/widgets/main_screen/main_screen.dart';
import 'dart:developer';

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

  await themeProvider.loadTheme();
  await languageProvider.loadLanguage();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (kIsWeb) {
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('🔔 Web Notification (Foreground): ${message.notification?.title}');
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

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  log('Handling a background message: ${message.messageId}');

  final notification = message.notification;
  if (notification != null) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const android = AndroidNotificationDetails(
      'task_reminders_channel',
      'Напоминания о задачах',
      channelDescription: 'Уведомления о предстоящих задачах',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const iOS = DarwinNotificationDetails();

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(android: android, iOS: iOS),
      payload: message.data['taskId'],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isNotificationPermissionGranted = false;
  bool _dialogIsShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (!kIsWeb) {
      _checkAndRequestNotificationPermissions();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !kIsWeb) {
      _checkAndRequestNotificationPermissions();
    }
  }

  Future<void> _checkAndRequestNotificationPermissions() async {
    bool currentPermissionStatus = false;

    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final status = await Permission.notification.status;
      currentPermissionStatus = status.isGranted;
      log(
        'Current mobile notification permission (via permission_handler): $currentPermissionStatus',
      );

      if (!currentPermissionStatus &&
          defaultTargetPlatform == TargetPlatform.iOS) {
        final IOSFlutterLocalNotificationsPlugin? iOSImplementation =
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin
                >();
        currentPermissionStatus =
            await iOSImplementation?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
        log(
          'iOS notification permission re-requested: $currentPermissionStatus',
        );
      }
    } else {
      currentPermissionStatus = true;
      log(
        'Non-mobile platform, assuming notification permission is implicitly available.',
      );
    }

    if (_isNotificationPermissionGranted != currentPermissionStatus) {
      setState(() {
        _isNotificationPermissionGranted = currentPermissionStatus;
      });
    }

    if (!_isNotificationPermissionGranted &&
        !_dialogIsShowing &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      _showPermissionRequestDialog();
    }
  }

  void _showPermissionRequestDialog() {
    _dialogIsShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            S.of(context).notification_permission_title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          content: Text(
            S.of(context).notification_permission_content,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                S.of(context).notification_permission_open_settings,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                _dialogIsShowing = false;
                if (!kIsWeb) {
                  await openAppSettings();
                }
              },
            ),
            TextButton(
              child: Text(
                S.of(context).notification_permission_later,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _dialogIsShowing = false;
              },
            ),
          ],
        );
      },
    ).then((_) {
      _dialogIsShowing = false;
    });
  }

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
