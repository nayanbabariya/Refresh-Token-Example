part of 'api_service.dart';

/// Provides authenticator for every APIs and handles refreshing
/// access token for unauthorized APIs.
class ApiAuthenticator extends Authenticator {
  /// Completer to prevent multiple token refreshes at the same time.
  Completer<bool>? _completer;

  /// Provides latest session data from the service.
  Session? get _session => AppService.instance.session;

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    // Refresh token API call should be ignored & on 401, logout the user.
    if (request.isRefreshTokenRequest) {
      if (response.statusCode == HttpStatus.unauthorized) {
        _finishCompleter(complete: false);

        // Set up your logout logic here. don't forget to clear session data.
        AppService.instance.setSession(null);
        log('You have been logged out.......');
      }
      return null;
    }

    // Call the refresh token API when rest of the API requests have 401.
    if (response.statusCode == HttpStatus.unauthorized) {
      // If completer is running, hold the request until it completes.
      if (_completer != null && !_completer!.isCompleted) {
        final complete = await _completer?.future;
        if (complete ?? false) return applyAuthHeader(request);
        return null;
      }

      final session = _session;
      if (session == null) return null;

      if (session.accessToken.isValidAccessToken) {
        return applyAuthHeader(request);
      }

      _completer ??= Completer<bool>();
      final result = await ApiService.instance.refreshToken(
        request: RefreshTokenRequest(refreshToken: session.refreshToken),
      );

      if (result.isSuccessful && result.body != null) {
        final session = Session.fromJson(result.body['data']);
        // You need to save new session data in app storage.
        AppService.instance.setSession(session);

        // Complete the completer on successfully refreshing the token.
        if (_completer != null && !_completer!.isCompleted) {
          _finishCompleter();
        }

        return applyAuthHeader(request);
      }
    }
    return null;
  }

  void _finishCompleter({bool complete = true}) {
    _completer?.complete(complete);
    _completer = null;
  }

  /// Inserts the [accessToken] in the header section of all the APIs
  /// by fetching the latest data.
  Request applyAuthHeader(Request request) {
    return applyHeader(
      request,
      'Authorization',
      '${_session?.accessToken}',
    );
  }
}
