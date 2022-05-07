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

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "httpError": MessageLookupByLibrary.simpleMessage("HTTP request error"),
        "notCurrentlySupported":
            MessageLookupByLibrary.simpleMessage("Not currently supported"),
        "passwordAdvanced": MessageLookupByLibrary.simpleMessage("Advanced"),
        "passwordDigit": MessageLookupByLibrary.simpleMessage("Digit"),
        "passwordGestureMinPrefix":
            MessageLookupByLibrary.simpleMessage("Connect at least "),
        "passwordGestureMinSuffix":
            MessageLookupByLibrary.simpleMessage(" points"),
        "passwordGestureNew": MessageLookupByLibrary.simpleMessage(
            "Please draw a gesture password"),
        "passwordGestureRepeat": MessageLookupByLibrary.simpleMessage(
            "Please draw gesture password again"),
        "passwordInputMinPrefix":
            MessageLookupByLibrary.simpleMessage("Enter at least "),
        "passwordInputMinSuffix":
            MessageLookupByLibrary.simpleMessage(" characters"),
        "passwordInputNew":
            MessageLookupByLibrary.simpleMessage("Please enter a password"),
        "passwordInputRepeat": MessageLookupByLibrary.simpleMessage(
            "Please enter the password again"),
        "passwordNotEquals": MessageLookupByLibrary.simpleMessage(
            "The two passwords are inconsistent"),
        "passwordProfessional":
            MessageLookupByLibrary.simpleMessage("Professional"),
        "passwordStandard": MessageLookupByLibrary.simpleMessage("Standard"),
        "passwordText": MessageLookupByLibrary.simpleMessage("Text"),
        "pictureAlbum":
            MessageLookupByLibrary.simpleMessage("Select from album"),
        "pictureCamera": MessageLookupByLibrary.simpleMessage(
            "Use the camera to take pictures"),
        "pictureCrop": MessageLookupByLibrary.simpleMessage("Crop"),
        "pictureCropFail":
            MessageLookupByLibrary.simpleMessage("Failed to crop picture"),
        "pictureFlip": MessageLookupByLibrary.simpleMessage("Flip"),
        "pictureReset": MessageLookupByLibrary.simpleMessage("Reset"),
        "pictureRotateLeft":
            MessageLookupByLibrary.simpleMessage("Rotate Left"),
        "pictureRotateRight":
            MessageLookupByLibrary.simpleMessage("Rotate Right"),
        "pictureUploadFail":
            MessageLookupByLibrary.simpleMessage("Failed to upload picture"),
        "upgraderCancel": MessageLookupByLibrary.simpleMessage("Next Reminder"),
        "upgraderForward": MessageLookupByLibrary.simpleMessage("Update Now"),
        "upgraderNewer":
            MessageLookupByLibrary.simpleMessage("New version found")
      };
}
