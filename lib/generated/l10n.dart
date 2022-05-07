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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `HTTP request error`
  String get httpError {
    return Intl.message(
      'HTTP request error',
      name: 'httpError',
      desc: '',
      args: [],
    );
  }

  /// `Not currently supported`
  String get notCurrentlySupported {
    return Intl.message(
      'Not currently supported',
      name: 'notCurrentlySupported',
      desc: '',
      args: [],
    );
  }

  /// `New version found`
  String get upgraderNewer {
    return Intl.message(
      'New version found',
      name: 'upgraderNewer',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get upgraderForward {
    return Intl.message(
      'Update Now',
      name: 'upgraderForward',
      desc: '',
      args: [],
    );
  }

  /// `Next Reminder`
  String get upgraderCancel {
    return Intl.message(
      'Next Reminder',
      name: 'upgraderCancel',
      desc: '',
      args: [],
    );
  }

  /// `Crop`
  String get pictureCrop {
    return Intl.message(
      'Crop',
      name: 'pictureCrop',
      desc: '',
      args: [],
    );
  }

  /// `Failed to crop picture`
  String get pictureCropFail {
    return Intl.message(
      'Failed to crop picture',
      name: 'pictureCropFail',
      desc: '',
      args: [],
    );
  }

  /// `Flip`
  String get pictureFlip {
    return Intl.message(
      'Flip',
      name: 'pictureFlip',
      desc: '',
      args: [],
    );
  }

  /// `Rotate Left`
  String get pictureRotateLeft {
    return Intl.message(
      'Rotate Left',
      name: 'pictureRotateLeft',
      desc: '',
      args: [],
    );
  }

  /// `Rotate Right`
  String get pictureRotateRight {
    return Intl.message(
      'Rotate Right',
      name: 'pictureRotateRight',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get pictureReset {
    return Intl.message(
      'Reset',
      name: 'pictureReset',
      desc: '',
      args: [],
    );
  }

  /// `Use the camera to take pictures`
  String get pictureCamera {
    return Intl.message(
      'Use the camera to take pictures',
      name: 'pictureCamera',
      desc: '',
      args: [],
    );
  }

  /// `Select from album`
  String get pictureAlbum {
    return Intl.message(
      'Select from album',
      name: 'pictureAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload picture`
  String get pictureUploadFail {
    return Intl.message(
      'Failed to upload picture',
      name: 'pictureUploadFail',
      desc: '',
      args: [],
    );
  }

  /// `Please draw a gesture password`
  String get passwordGestureNew {
    return Intl.message(
      'Please draw a gesture password',
      name: 'passwordGestureNew',
      desc: '',
      args: [],
    );
  }

  /// `Please draw gesture password again`
  String get passwordGestureRepeat {
    return Intl.message(
      'Please draw gesture password again',
      name: 'passwordGestureRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get passwordInputNew {
    return Intl.message(
      'Please enter a password',
      name: 'passwordInputNew',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password again`
  String get passwordInputRepeat {
    return Intl.message(
      'Please enter the password again',
      name: 'passwordInputRepeat',
      desc: '',
      args: [],
    );
  }

  /// `The two passwords are inconsistent`
  String get passwordNotEquals {
    return Intl.message(
      'The two passwords are inconsistent',
      name: 'passwordNotEquals',
      desc: '',
      args: [],
    );
  }

  /// `Connect at least `
  String get passwordGestureMinPrefix {
    return Intl.message(
      'Connect at least ',
      name: 'passwordGestureMinPrefix',
      desc: '',
      args: [],
    );
  }

  /// ` points`
  String get passwordGestureMinSuffix {
    return Intl.message(
      ' points',
      name: 'passwordGestureMinSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Enter at least `
  String get passwordInputMinPrefix {
    return Intl.message(
      'Enter at least ',
      name: 'passwordInputMinPrefix',
      desc: '',
      args: [],
    );
  }

  /// ` characters`
  String get passwordInputMinSuffix {
    return Intl.message(
      ' characters',
      name: 'passwordInputMinSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get passwordStandard {
    return Intl.message(
      'Standard',
      name: 'passwordStandard',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get passwordAdvanced {
    return Intl.message(
      'Advanced',
      name: 'passwordAdvanced',
      desc: '',
      args: [],
    );
  }

  /// `Professional`
  String get passwordProfessional {
    return Intl.message(
      'Professional',
      name: 'passwordProfessional',
      desc: '',
      args: [],
    );
  }

  /// `Digit`
  String get passwordDigit {
    return Intl.message(
      'Digit',
      name: 'passwordDigit',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get passwordText {
    return Intl.message(
      'Text',
      name: 'passwordText',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
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
