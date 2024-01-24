import 'dart:developer';
import 'package:flutter/foundation.dart';

///! Helper function to log errors
///* required message
///
void logError(String message) {
    if (kDebugMode) {
      log(message);
    }
  }