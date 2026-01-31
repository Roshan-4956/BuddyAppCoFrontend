/// Logging utility module that provides debug and user-facing logging functionality.
/// Supports both debug console logging and UI toast notifications.
/// In release mode, console logs can be optionally suppressed using [ignorePrintsInRelease].
library;

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:interbits_23_app/util/color_theme.dart';

const bool ignorePrintsInRelease = false;

/// Debug tags for categorizing log messages across the application
class DebugTags {
  /// Repository creation and initialization logs
  static const String repoCreation = 'RepoCreation';

  static const String temp = 'TEMP';

  static const String auth = 'Auth';
  static const String authMiddleware = 'AuthMiddleware';
  static const String googleSignIn = 'Auth-GoogleSignIn';
  static const String authTokenFetch = 'Auth-AuthTokens';
  static const String firebase = 'Firebase';

  static const String secureStorage = 'SecureStorage';

  static const String httpClientException = 'HTTP Client Exception';
  static const String httpStatusNotOK = 'HTTP Error';
  static const String httpClientResponse = 'HTTP Response';
  static const String httpRequest = 'HTTP Request';

  static const String apiSuccess = 'API Success';
  static const String apiError = 'API Error';
  /*
  static const String rebuildingWidget = "Rebuilding";
  static const String apiCall = "API Call";
  static const String apiResult = "API Result";
  static const String apiResonseParseError = "Response Parse Failed";
*/
  static const String routing = 'Routing Path';
}

//Maybe add a warning log function too (it will print a flashy red warning, and also throw an runtime exception if in debug mode)?

/// Logs debug messages with optional toast notification
/// [debugTag] - Category tag for the message
/// [msg] - Content to be logged
/// [showToast] - Whether to show toast notification
void debugLog(
  String debugTag,
  dynamic msg, {
  bool showToast = false,
  /* ColorTheme? theme*/
}) {
  debugAndToast(
    debugTag,
    msg,
    showToast,
    backgroundColor:
        /*theme != null ? theme.toastBackgroundColor :*/ Colors.black,
    textColor: /*theme != null ? theme.toastTextColor :*/ Colors.white,
  );
}

/// Logs error messages with optional toast notification
/// [debugTag] - Category tag for the message
/// [msg] - Content to be logged
/// [showToast] - Whether to show toast notification
void errorLog(
  String debugTag,
  dynamic msg, {
  bool showToast = false,
  /* ColorTheme? theme*/
}) {
  debugAndToast(
    debugTag,
    msg,
    showToast,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    isError: true,
  );
}

/// Logs user-facing messages with toast notification
/// [msg] - Content to be shown to user
/// [showToast] - Whether to show toast notification
/// [debugTag] - Optional category tag for debug console
void userLog(
  dynamic msg, {
  bool showToast = true,
  String debugTag = '',
  /* ColorTheme? theme*/
}) {
  debugAndToast(
    debugTag,
    msg,
    showToast,
    backgroundColor:
        /*theme != null ? theme.toastBackgroundColor :*/ Colors.black,
    textColor: /*theme != null ? theme.toastTextColor :*/ Colors.white,
  );
}

void debugAndToast(
  String debugTag,
  dynamic msg,
  bool showToast, {
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
  bool isError = false,
}) {
  String debugMsg = debugTag.isEmpty ? msg.toString() : '$debugTag: $msg';
  if (kReleaseMode) {
    if (!ignorePrintsInRelease) {
      log(debugMsg, name: debugTag, error: isError ? msg : null);
    }
  } else {
    log(debugMsg, name: debugTag, error: isError ? msg : null);
  }

  if (showToast) {
    Fluttertoast.cancel().whenComplete(
      () => Fluttertoast.showToast(
        msg: msg.toString(),
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0,
      ),
    );
  }
}
