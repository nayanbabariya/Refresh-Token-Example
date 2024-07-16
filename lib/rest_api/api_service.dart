import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:refresh_token_example/core/app_service.dart';
import 'package:refresh_token_example/core/extensions.dart';
import 'package:refresh_token_example/models/refresh_token_request.dart';
import 'package:refresh_token_example/server/mock_client.dart';

import '../models/session.dart';

part 'api_authenticator.dart';
part 'api_interceptors.dart';
part 'api_service.chopper.dart';
part 'chopper_client.dart';

/// Generates API calls and handles responses.
@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService get instance => ApiService._();

  static ApiService _() => _$ApiService(_client);

  @Post(path: 'auth/refresh-token')
  Future<Response> refreshToken({
    @Body() required RefreshTokenRequest request,
  });

  @Get(path: 'products')
  Future<Response> getProducts();

  @Get(path: 'orders')
  Future<Response> getOrders();

  @Get(path: 'order/order-details')
  Future<Response> getOrderDetails();
}
