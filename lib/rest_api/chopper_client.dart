part of 'api_service.dart';

/// Chopper client for Rest API calls.
final _client = ChopperClient(
  services: [_$ApiService()],
  client: mockClient(),
  converter: const JsonConverter(),
  authenticator: ApiAuthenticator(),
  interceptors: [
    ApiInterceptor(),
    const HeadersInterceptor({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
    }),
    HttpLoggingInterceptor(),
  ],
);
