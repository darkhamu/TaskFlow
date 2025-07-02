// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(name) => "Hello, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account_not_found": MessageLookupByLibrary.simpleMessage(
      "The specified account was not found",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("TaskFlow"),
    "back_button": MessageLookupByLibrary.simpleMessage("Back"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "design_theme": MessageLookupByLibrary.simpleMessage("Design theme"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_already_in_use": MessageLookupByLibrary.simpleMessage(
      "Email already in use",
    ),
    "enter_correct_email": MessageLookupByLibrary.simpleMessage(
      "Please, enter the correcr email",
    ),
    "error_of_sending_the_email": MessageLookupByLibrary.simpleMessage(
      "The error of sending the email",
    ),
    "field_must_be_filled": MessageLookupByLibrary.simpleMessage(
      "Field must be filled",
    ),
    "forget_password": MessageLookupByLibrary.simpleMessage("Forget password?"),
    "helloMessage": m0,
    "invalid_email": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "login_failed": MessageLookupByLibrary.simpleMessage("Login failed"),
    "not_found_subtitle": MessageLookupByLibrary.simpleMessage(
      "Looks like you ended up where no tasks exist.\nMaybe it\'s already done? 😉",
    ),
    "not_found_title": MessageLookupByLibrary.simpleMessage(
      "Oops! The task ran away!",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_requirements": MessageLookupByLibrary.simpleMessage(
      "The password must contain lowercase and uppercase, numbers, special characters and be longer than 8 characters",
    ),
    "password_reset_email_sent": MessageLookupByLibrary.simpleMessage(
      "Password reset email sent",
    ),
    "registration_failed": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "reset_password": MessageLookupByLibrary.simpleMessage("Reset password"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sign_in": MessageLookupByLibrary.simpleMessage("Sign in"),
    "sign_out": MessageLookupByLibrary.simpleMessage("Sign out"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "weak_password": MessageLookupByLibrary.simpleMessage("Weak password"),
  };
}
