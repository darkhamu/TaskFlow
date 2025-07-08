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

  static String m0(taskName) =>
      "Are you sure you want to delete \"${taskName}\"?";

  static String m1(name) => "Hello, ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account_not_found": MessageLookupByLibrary.simpleMessage(
      "The specified account was not found",
    ),
    "appName": MessageLookupByLibrary.simpleMessage("TaskFlow"),
    "back_button": MessageLookupByLibrary.simpleMessage("Back"),
    "by_date_of_expiration": MessageLookupByLibrary.simpleMessage(
      "By date of expiration",
    ),
    "by_descending": MessageLookupByLibrary.simpleMessage("By descending"),
    "by_name": MessageLookupByLibrary.simpleMessage("By name"),
    "by_order": MessageLookupByLibrary.simpleMessage("By order"),
    "by_priority": MessageLookupByLibrary.simpleMessage("By priority"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "change": MessageLookupByLibrary.simpleMessage("Change"),
    "complete": MessageLookupByLibrary.simpleMessage("Complete"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirm_delete_task": m0,
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "days": MessageLookupByLibrary.simpleMessage("days"),
    "deadline": MessageLookupByLibrary.simpleMessage("Deadline"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "delete_confirmation": MessageLookupByLibrary.simpleMessage("Delete task?"),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "design_theme": MessageLookupByLibrary.simpleMessage("Design theme"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_already_in_use": MessageLookupByLibrary.simpleMessage(
      "Email already in use",
    ),
    "enter_correct_email": MessageLookupByLibrary.simpleMessage(
      "Please, enter the correcr email",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "error_of_sending_the_email": MessageLookupByLibrary.simpleMessage(
      "The error of sending the email",
    ),
    "field_must_be_filled": MessageLookupByLibrary.simpleMessage(
      "Field must be filled",
    ),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "filters_and_sorting": MessageLookupByLibrary.simpleMessage(
      "Filters and sorting",
    ),
    "finished": MessageLookupByLibrary.simpleMessage("Finished"),
    "forget_password": MessageLookupByLibrary.simpleMessage("Forget password?"),
    "have_to_do": MessageLookupByLibrary.simpleMessage("4 - Have to do"),
    "helloMessage": m1,
    "hours": MessageLookupByLibrary.simpleMessage("hr"),
    "if_possible": MessageLookupByLibrary.simpleMessage("5 - If possible"),
    "important": MessageLookupByLibrary.simpleMessage("2 - Important"),
    "in_process": MessageLookupByLibrary.simpleMessage("In process"),
    "invalid_email": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "login_failed": MessageLookupByLibrary.simpleMessage("Login failed"),
    "medium": MessageLookupByLibrary.simpleMessage("3 - Medium"),
    "minutes": MessageLookupByLibrary.simpleMessage("min"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "no_tasks_found": MessageLookupByLibrary.simpleMessage("No tasks found"),
    "not_found_subtitle": MessageLookupByLibrary.simpleMessage(
      "Looks like you ended up where no tasks exist.\nMaybe it\'s already done? 😉",
    ),
    "not_found_title": MessageLookupByLibrary.simpleMessage(
      "Oops! The task ran away!",
    ),
    "notification_permission_content": MessageLookupByLibrary.simpleMessage(
      "For the app to function fully and provide reminders, access to notifications is required. Please enable notifications in the app settings.",
    ),
    "notification_permission_later": MessageLookupByLibrary.simpleMessage(
      "Later",
    ),
    "notification_permission_open_settings":
        MessageLookupByLibrary.simpleMessage("Open Settings"),
    "notification_permission_title": MessageLookupByLibrary.simpleMessage(
      "Notification Permission",
    ),
    "overdue": MessageLookupByLibrary.simpleMessage("Overdue by"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_requirements": MessageLookupByLibrary.simpleMessage(
      "The password must contain lowercase and uppercase, numbers, special characters and be longer than 8 characters",
    ),
    "password_reset_email_sent": MessageLookupByLibrary.simpleMessage(
      "Password reset email sent",
    ),
    "priority": MessageLookupByLibrary.simpleMessage("Priority"),
    "registration_failed": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "reminder12h": MessageLookupByLibrary.simpleMessage("In 12 hours"),
    "reminder15m": MessageLookupByLibrary.simpleMessage("In 15 minutes"),
    "reminder1d": MessageLookupByLibrary.simpleMessage("In 1 day"),
    "reminder1h": MessageLookupByLibrary.simpleMessage("In 1 hour"),
    "reminder1mo": MessageLookupByLibrary.simpleMessage("In 1 month"),
    "reminder1w": MessageLookupByLibrary.simpleMessage("In 1 week"),
    "reminder30m": MessageLookupByLibrary.simpleMessage("In 30 minutes"),
    "reminder3d": MessageLookupByLibrary.simpleMessage("In 3 days"),
    "reminder6h": MessageLookupByLibrary.simpleMessage("In 6 hours"),
    "repeat": MessageLookupByLibrary.simpleMessage("Repeat"),
    "reset_password": MessageLookupByLibrary.simpleMessage("Reset password"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "select_time": MessageLookupByLibrary.simpleMessage("Select time"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "sign_in": MessageLookupByLibrary.simpleMessage("Sign in"),
    "sign_out": MessageLookupByLibrary.simpleMessage("Sign out"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign up"),
    "sorting": MessageLookupByLibrary.simpleMessage("Sorting"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "task_completed": MessageLookupByLibrary.simpleMessage(
      "Task completed successfully",
    ),
    "task_deleted": MessageLookupByLibrary.simpleMessage(
      "Task deleted successfully",
    ),
    "task_repeated": MessageLookupByLibrary.simpleMessage(
      "Task repeated successfully",
    ),
    "this_month": MessageLookupByLibrary.simpleMessage("This month"),
    "this_week": MessageLookupByLibrary.simpleMessage("This week"),
    "time_of_reminder": MessageLookupByLibrary.simpleMessage(
      "Time of reminder",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "tomorrow": MessageLookupByLibrary.simpleMessage("Tomorrow"),
    "unsaved_data": MessageLookupByLibrary.simpleMessage(
      "You have unsaved data",
    ),
    "urgent": MessageLookupByLibrary.simpleMessage("1 - Urgent"),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "want_to_save": MessageLookupByLibrary.simpleMessage(
      "Do you want to save them?",
    ),
    "weak_password": MessageLookupByLibrary.simpleMessage("Weak password"),
    "you_have": MessageLookupByLibrary.simpleMessage("You have"),
  };
}
