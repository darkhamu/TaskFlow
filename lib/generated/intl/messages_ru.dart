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

  static String m0(name) => "Приветствуем, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account_not_found": MessageLookupByLibrary.simpleMessage(
      "Указанный аккаунт не был найден",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("TaskFlow"),
    "back_button": MessageLookupByLibrary.simpleMessage("Вернуться"),
    "dark": MessageLookupByLibrary.simpleMessage("Темная"),
    "design_theme": MessageLookupByLibrary.simpleMessage("Тема оформления"),
    "email": MessageLookupByLibrary.simpleMessage("Почта"),
    "email_already_in_use": MessageLookupByLibrary.simpleMessage(
      "Почта уже используется",
    ),
    "enter_correct_email": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите корректную почту",
    ),
    "error_of_sending_the_email": MessageLookupByLibrary.simpleMessage(
      "Ошибка отправки письма",
    ),
    "field_must_be_filled": MessageLookupByLibrary.simpleMessage(
      "Поле должно быть заполнено",
    ),
    "forget_password": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "helloMessage": m0,
    "invalid_email": MessageLookupByLibrary.simpleMessage("Некорректная почта"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "light": MessageLookupByLibrary.simpleMessage("Светлая"),
    "login_failed": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "not_found_subtitle": MessageLookupByLibrary.simpleMessage(
      "Кажется, ты попал туда, где задач нет.\nА может, она просто уже выполнена? 😉",
    ),
    "not_found_title": MessageLookupByLibrary.simpleMessage(
      "Ой! Задача убежала!",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "password_requirements": MessageLookupByLibrary.simpleMessage(
      "Пароль должен содержать строчные и прописные буквы, цифры, спец. символы и быть длиннее 8 символов",
    ),
    "password_reset_email_sent": MessageLookupByLibrary.simpleMessage(
      "Письмо для сброса пароля было отправлено",
    ),
    "registration_failed": MessageLookupByLibrary.simpleMessage(
      "Ошибка регистрации",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "sign_in": MessageLookupByLibrary.simpleMessage("Вход в систему"),
    "sign_out": MessageLookupByLibrary.simpleMessage("Выйти из аккаунта"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "system": MessageLookupByLibrary.simpleMessage("Системная"),
    "username": MessageLookupByLibrary.simpleMessage("Логин"),
    "weak_password": MessageLookupByLibrary.simpleMessage("Слабый пароль"),
  };
}
