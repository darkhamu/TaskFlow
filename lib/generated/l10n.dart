// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `TaskFlow`
  String get appName {
    return Intl.message('TaskFlow', name: 'appName', desc: '', args: []);
  }

  /// `Hello, {name}`
  String helloMessage(Object name) {
    return Intl.message(
      'Hello, $name',
      name: 'helloMessage',
      desc: '',
      args: [name],
    );
  }

  /// `Please, enter the correcr email`
  String get enter_correct_email {
    return Intl.message(
      'Please, enter the correcr email',
      name: 'enter_correct_email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Field must be filled`
  String get field_must_be_filled {
    return Intl.message(
      'Field must be filled',
      name: 'field_must_be_filled',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `The password must contain lowercase and uppercase, numbers, special characters and be longer than 8 characters`
  String get password_requirements {
    return Intl.message(
      'The password must contain lowercase and uppercase, numbers, special characters and be longer than 8 characters',
      name: 'password_requirements',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message('Sign up', name: 'sign_up', desc: '', args: []);
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message('Sign in', name: 'sign_in', desc: '', args: []);
  }

  /// `Registration failed`
  String get registration_failed {
    return Intl.message(
      'Registration failed',
      name: 'registration_failed',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get email_already_in_use {
    return Intl.message(
      'Email already in use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Weak password`
  String get weak_password {
    return Intl.message(
      'Weak password',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forget_password {
    return Intl.message(
      'Forget password?',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_failed {
    return Intl.message(
      'Login failed',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent`
  String get password_reset_email_sent {
    return Intl.message(
      'Password reset email sent',
      name: 'password_reset_email_sent',
      desc: '',
      args: [],
    );
  }

  /// `The error of sending the email`
  String get error_of_sending_the_email {
    return Intl.message(
      'The error of sending the email',
      name: 'error_of_sending_the_email',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `The specified account was not found`
  String get account_not_found {
    return Intl.message(
      'The specified account was not found',
      name: 'account_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Oops! The task ran away!`
  String get not_found_title {
    return Intl.message(
      'Oops! The task ran away!',
      name: 'not_found_title',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you ended up where no tasks exist.\nMaybe it's already done? 😉`
  String get not_found_subtitle {
    return Intl.message(
      'Looks like you ended up where no tasks exist.\nMaybe it\'s already done? 😉',
      name: 'not_found_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back_button {
    return Intl.message('Back', name: 'back_button', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Design theme`
  String get design_theme {
    return Intl.message(
      'Design theme',
      name: 'design_theme',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Sign out`
  String get sign_out {
    return Intl.message('Sign out', name: 'sign_out', desc: '', args: []);
  }

  /// `In process`
  String get in_process {
    return Intl.message('In process', name: 'in_process', desc: '', args: []);
  }

  /// `Finished`
  String get finished {
    return Intl.message('Finished', name: 'finished', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message('Tomorrow', name: 'tomorrow', desc: '', args: []);
  }

  /// `This week`
  String get this_week {
    return Intl.message('This week', name: 'this_week', desc: '', args: []);
  }

  /// `This month`
  String get this_month {
    return Intl.message('This month', name: 'this_month', desc: '', args: []);
  }

  /// `By date of expiration`
  String get by_date_of_expiration {
    return Intl.message(
      'By date of expiration',
      name: 'by_date_of_expiration',
      desc: '',
      args: [],
    );
  }

  /// `By name`
  String get by_name {
    return Intl.message('By name', name: 'by_name', desc: '', args: []);
  }

  /// `By priority`
  String get by_priority {
    return Intl.message('By priority', name: 'by_priority', desc: '', args: []);
  }

  /// `By order`
  String get by_order {
    return Intl.message('By order', name: 'by_order', desc: '', args: []);
  }

  /// `By descending`
  String get by_descending {
    return Intl.message(
      'By descending',
      name: 'by_descending',
      desc: '',
      args: [],
    );
  }

  /// `Filters and sorting`
  String get filters_and_sorting {
    return Intl.message(
      'Filters and sorting',
      name: 'filters_and_sorting',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Sorting`
  String get sorting {
    return Intl.message('Sorting', name: 'sorting', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
