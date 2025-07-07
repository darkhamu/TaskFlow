import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/task_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestAlertPermission: true,

        requestBadgePermission: true,

        requestSoundPermission: true,
      );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,

    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> initializeTimezone() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Minsk'));
}

Future<String> getLocalizedNotificationText(
  String taskName,
  DateTime deadline,
  String userLanguageCode,
  String type,
) async {
  Intl.defaultLocale = userLanguageCode;

  final DateFormat dateFormatter = DateFormat.yMMMd(userLanguageCode);
  final DateFormat timeFormatter = DateFormat.Hm(userLanguageCode);

  final String formattedDate = dateFormatter.format(deadline);
  final String formattedTime = timeFormatter.format(deadline);

  // кастомный текст уведомления
  switch (type) {
    case 'body':
      switch (userLanguageCode) {
        case 'ru':
          return 'Напоминаем, задача "$taskName" должна быть завершена до $formattedDate $formattedTime.';
        case 'en':
        default:
          return 'Reminder: Task "$taskName" must be completed by $formattedDate $formattedTime.';
      }
    case 'head':
      switch (userLanguageCode) {
        case 'ru':
          return 'Напоминание о задаче!';
        case 'en':
        default:
          return 'Task reminder!';
      }
    case 'expired_body':
      switch (userLanguageCode) {
        case 'ru':
          return 'Задача "$taskName" истёк срок выполнения: $formattedDate $formattedTime. Пожалуйста, завершите ее.';
        case 'en':
        default:
          return 'Task "$taskName" deadline passed: $formattedDate $formattedTime. Please complete it.';
      }
    case 'expired_head':
      switch (userLanguageCode) {
        case 'ru':
          return 'Задача просрочена!';
        case 'en':
        default:
          return 'Task overdue!';
      }
    default:
      return '';
  }
}

Future<void> scheduleTaskReminders({
  required TaskModel task,
  required String userLanguageCode,
}) async {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

  final tz.TZDateTime localDeadlineTZ = tz.TZDateTime.from(
    task.deadlineDateTime,
    tz.local,
  );

  for (final int reminderOffsetMinutes in task.reminders) {
    final tz.TZDateTime scheduledNotificationDateTime = localDeadlineTZ
        .subtract(Duration(minutes: reminderOffsetMinutes));

    if (scheduledNotificationDateTime.isAfter(now)) {
      final String notificationBody = await getLocalizedNotificationText(
        task.name,
        task.deadlineDateTime,
        userLanguageCode,
        'body',
      );

      final String notificationHead = await getLocalizedNotificationText(
        task.name,
        task.deadlineDateTime,
        userLanguageCode,
        'head',
      );

      final int notificationId =
          '${task.id}_reminder_$reminderOffsetMinutes'.hashCode;

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'task_reminders_channel',
            'Напоминания о задачах',
            channelDescription: 'Уведомления о предстоящих задачах',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          );
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails();
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        notificationHead,
        notificationBody,
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: task.id,
      );
    }
  }
  if (!task.isDone) {
    final tz.TZDateTime expiredNotificationDateTime = localDeadlineTZ;
    if (expiredNotificationDateTime.isAfter(now) ||
        expiredNotificationDateTime.isAtSameMomentAs(now)) {
      final String expiredNotificationBody = await getLocalizedNotificationText(
        task.name,
        task.deadlineDateTime,
        userLanguageCode,
        'expired_body',
      );
      final String expiredNotificationHead = await getLocalizedNotificationText(
        task.name,
        task.deadlineDateTime,
        userLanguageCode,
        'expired_head',
      );

      final int expiredNotificationId = '${task.id}_expired'.hashCode;

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'task_expired_channel',
            'Просроченные задачи',
            channelDescription:
                'Уведомления о задачах, срок выполнения которых истёк',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
          );
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails();
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        expiredNotificationId,
        expiredNotificationHead,
        expiredNotificationBody,
        expiredNotificationDateTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: task.id,
      );
    }
  }
}

Future<void> cancelTaskReminders(TaskModel task) async {
  for (final int reminderOffsetMinutes in task.reminders) {
    final int notificationId1 =
        '${task.id}_reminder_$reminderOffsetMinutes'.hashCode;
    await flutterLocalNotificationsPlugin.cancel(notificationId1);
  }
  final int expiredNotificationId = '${task.id}_expired'.hashCode;
  await flutterLocalNotificationsPlugin.cancel(expiredNotificationId);
}
