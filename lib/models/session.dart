import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

/// Model class to manage refresh token API response.
@JsonSerializable(createToJson: false)
final class Session {
  final String accessToken;
  final String refreshToken;

  Session({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Session copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return Session(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
