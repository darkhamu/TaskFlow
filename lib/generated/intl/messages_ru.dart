// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(taskName) =>
      "Вы уверены, что хотите удалить \"${taskName}\"?";

  static String m1(name) => "Приветствуем, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account_not_found": MessageLookupByLibrary.simpleMessage(
      "Указанный аккаунт не был найден",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("TaskFlow"),
    "back_button": MessageLookupByLibrary.simpleMessage("Вернуться"),
    "by_date_of_expiration": MessageLookupByLibrary.simpleMessage(
      "По дате срока",
    ),
    "by_descending": MessageLookupByLibrary.simpleMessage("По убыванию"),
    "by_name": MessageLookupByLibrary.simpleMessage("По названию"),
    "by_order": MessageLookupByLibrary.simpleMessage("По возрастанию"),
    "by_priority": MessageLookupByLibrary.simpleMessage("По приоритету"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "change": MessageLookupByLibrary.simpleMessage("Изменить"),
    "complete": MessageLookupByLibrary.simpleMessage("Завершить"),
    "completed": MessageLookupByLibrary.simpleMessage("Выполнено"),
    "confirm_delete_task": m0,
    "dark": MessageLookupByLibrary.simpleMessage("Темная"),
    "days": MessageLookupByLibrary.simpleMessage("дн."),
    "deadline": MessageLookupByLibrary.simpleMessage("Дедлайн"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "delete_confirmation": MessageLookupByLibrary.simpleMessage(
      "Удалить задачу?",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Описание"),
    "design_theme": MessageLookupByLibrary.simpleMessage("Тема оформления"),
    "email": MessageLookupByLibrary.simpleMessage("Почта"),
    "email_already_in_use": MessageLookupByLibrary.simpleMessage(
      "Почта уже используется",
    ),
    "enter_correct_email": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите корректную почту",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
    "error_of_sending_the_email": MessageLookupByLibrary.simpleMessage(
      "Ошибка отправки письма",
    ),
    "field_must_be_filled": MessageLookupByLibrary.simpleMessage(
      "Поле должно быть заполнено",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("Фильтры"),
    "filters_and_sorting": MessageLookupByLibrary.simpleMessage(
      "Фильтры и сортировка",
    ),
    "finished": MessageLookupByLibrary.simpleMessage("Завершены"),
    "forget_password": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "have_to_do": MessageLookupByLibrary.simpleMessage("4 - Надо сделать"),
    "helloMessage": m1,
    "hours": MessageLookupByLibrary.simpleMessage("ч."),
    "if_possible": MessageLookupByLibrary.simpleMessage("5 - По возможности"),
    "important": MessageLookupByLibrary.simpleMessage("2 - Важно"),
    "in_process": MessageLookupByLibrary.simpleMessage("В процессе"),
    "invalid_email": MessageLookupByLibrary.simpleMessage("Некорректная почта"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "light": MessageLookupByLibrary.simpleMessage("Светлая"),
    "login_failed": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "medium": MessageLookupByLibrary.simpleMessage("3 - Средне"),
    "minutes": MessageLookupByLibrary.simpleMessage("мин."),
    "name": MessageLookupByLibrary.simpleMessage("Название"),
    "not_found_subtitle": MessageLookupByLibrary.simpleMessage(
      "Кажется, ты попал туда, где задач нет.\nА может, она просто уже выполнена? 😉",
    ),
    "not_found_title": MessageLookupByLibrary.simpleMessage(
      "Ой! Задача убежала!",
    ),
    "overdue": MessageLookupByLibrary.simpleMessage("Просрочено на"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "password_requirements": MessageLookupByLibrary.simpleMessage(
      "Пароль должен содержать строчные и прописные буквы, цифры, спец. символы и быть длиннее 8 символов",
    ),
    "password_reset_email_sent": MessageLookupByLibrary.simpleMessage(
      "Письмо для сброса пароля было отправлено",
    ),
    "priority": MessageLookupByLibrary.simpleMessage("Приоритет"),
    "registration_failed": MessageLookupByLibrary.simpleMessage(
      "Ошибка регистрации",
    ),
    "reminder12h": MessageLookupByLibrary.simpleMessage("За 12 часов"),
    "reminder15m": MessageLookupByLibrary.simpleMessage("За 15 минут"),
    "reminder1d": MessageLookupByLibrary.simpleMessage("За 1 день"),
    "reminder1h": MessageLookupByLibrary.simpleMessage("За 1 час"),
    "reminder1mo": MessageLookupByLibrary.simpleMessage("За 1 месяц"),
    "reminder1w": MessageLookupByLibrary.simpleMessage("За 1 неделю"),
    "reminder30m": MessageLookupByLibrary.simpleMessage("За 30 минут"),
    "reminder3d": MessageLookupByLibrary.simpleMessage("За 3 дня"),
    "reminder6h": MessageLookupByLibrary.simpleMessage("За 6 часов"),
    "repeat": MessageLookupByLibrary.simpleMessage("Повторить"),
    "reset_password": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "select": MessageLookupByLibrary.simpleMessage("Выбрать"),
    "select_time": MessageLookupByLibrary.simpleMessage("Выберите время"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "sign_in": MessageLookupByLibrary.simpleMessage("Вход в систему"),
    "sign_out": MessageLookupByLibrary.simpleMessage("Выйти из аккаунта"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "sorting": MessageLookupByLibrary.simpleMessage("Сортировка"),
    "system": MessageLookupByLibrary.simpleMessage("Системная"),
    "task_completed": MessageLookupByLibrary.simpleMessage(
      "Задача успешно выполнена",
    ),
    "task_deleted": MessageLookupByLibrary.simpleMessage(
      "Задача успешно удалена",
    ),
    "task_repeated": MessageLookupByLibrary.simpleMessage(
      "Задача успешно возобновлена",
    ),
    "this_month": MessageLookupByLibrary.simpleMessage("В месяце"),
    "this_week": MessageLookupByLibrary.simpleMessage("На неделе"),
    "time_of_reminder": MessageLookupByLibrary.simpleMessage(
      "Время напоминаний",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
    "tomorrow": MessageLookupByLibrary.simpleMessage("Завтра"),
    "unsaved_data": MessageLookupByLibrary.simpleMessage(
      "У вас есть несохраненные данные",
    ),
    "urgent": MessageLookupByLibrary.simpleMessage("1 - Срочно"),
    "username": MessageLookupByLibrary.simpleMessage("Логин"),
    "want_to_save": MessageLookupByLibrary.simpleMessage(
      "Хотите сохранить их?",
    ),
    "weak_password": MessageLookupByLibrary.simpleMessage("Слабый пароль"),
    "you_have": MessageLookupByLibrary.simpleMessage("Осталось"),
  };
}
