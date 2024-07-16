import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

/// Model class to send the body of refresh token request.
@JsonSerializable()
final class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}