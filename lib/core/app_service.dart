import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:intl/intl.dart';
import 'package:refresh_token_example/core/constants.dart';
import 'package:refresh_token_example/models/session.dart';

/// Application service class to manage app level data.
final class AppService {
  // Singleton initialization
  AppService._();

  static final instance = AppService._();

  Session? _session = Session(
    accessToken: kValidAccessToken,
    refreshToken: kValidRefreshToken,
  );

  /// Getter for session data.
  Session? get session => _session;

  /// Setter for session data.
  void setSession(Session? session) {
    // In your app, you need to save the session data in your app storage.
    // Preferred storage is "Hive".
    _session = session;
  }

  /// Initialize the app service.
  void initialize() {
    // In your app, get the session data from your app storage.
    setAccessToken();
    setRefreshToken();

    chopperLogger.onRecord.listen((record) {
      log(
        '[${DateFormat('hh:mm:ss:S a').format(record.time)}]: ${record.message}',
        zone: record.zone,
        time: record.time,
        error: record.error,
        name: record.loggerName,
        level: record.level.value,
        stackTrace: record.stackTrace,
        sequenceNumber: record.sequenceNumber,
      );
    });
  }

  void setAccessToken({bool invalidate = false}) {
    // Don't forget to save new access token in your app storage.
    _session = _session?.copyWith(
      accessToken: invalidate ? kInvalidAccessToken : kValidAccessToken,
    );
  }

  void setRefreshToken({bool invalidate = false}) {
    // Don't forget to save new refresh token in your app storage.
    _session = _session?.copyWith(
      refreshToken: invalidate ? kInvalidRefreshToken : kValidRefreshToken,
    );
  }
}
