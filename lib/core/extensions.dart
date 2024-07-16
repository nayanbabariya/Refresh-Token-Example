import 'package:chopper/chopper.dart';
import 'package:refresh_token_example/core/constants.dart';

extension RequestUtils on Request {
  bool get isRefreshTokenRequest => uri.path.contains('auth/refresh-token');
}

extension StringUtils on String {
  // Write your logic to check the validity of access token.
  bool get isValidAccessToken => this == kValidAccessToken;

  // This getter is for testing purpose.
  bool get isValidRefreshToken => this == kValidRefreshToken;
}
