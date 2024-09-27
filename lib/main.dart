import 'dart:async';
import 'package:flutter/material.dart';

import 'app.dart';

import 'package:modulife_utils/modulife_utils.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await LogService().init();

      runApp(const App());
    },
    (Object error, StackTrace stackTrace) {
      LogService.e('Unhandled error occurred', error, stackTrace);
    },
  );
}
