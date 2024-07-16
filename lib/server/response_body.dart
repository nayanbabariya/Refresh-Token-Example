part of 'mock_client.dart';

final _refreshTokenResponseBody = json.encode({
  'data': {
    'accessToken': kValidAccessToken,
    'refreshToken': kValidRefreshToken,
  }
});

final _refreshTokenUnAuthorizedResponseBody = json.encode({
  'status': 'Unauthorized',
  'message': 'You have been logged out',
});

final _productsResponseBody = json.encode({
  'data': 'List of products',
  'message': 'Products fetched successfully',
});

final _ordersResponseBody = json.encode({
  'data': 'List of orders',
  'message': 'Orders fetched successfully',
});

final _orderDetailsResponseBody = json.encode({
  'data': 'Order details',
  'message': 'Order details fetched successfully',
});
