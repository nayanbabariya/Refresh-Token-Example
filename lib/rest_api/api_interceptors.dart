part of 'api_service.dart';

/// Manages intercepting all the Rest API request by
/// adding an Auth token in a header.
class ApiInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    // Refresh token API don't require an auth token in the header.
    if (chain.request.isRefreshTokenRequest) {
      return chain.proceed(chain.request);
    }

    final session = AppService.instance.session;
    if (session != null) {
      // Inserts the [accessToken] in the header.
      final response = await chain.proceed(
        applyHeader(chain.request, 'Authorization', session.accessToken),
      );
      return response;
    }
    return chain.proceed(chain.request);
  }
}
