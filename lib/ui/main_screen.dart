import 'package:flutter/material.dart';
import 'package:refresh_token_example/core/app_service.dart';
import 'package:refresh_token_example/core/extensions.dart';
import 'package:refresh_token_example/rest_api/api_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _appService = AppService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refresh Token Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: _appService.session?.accessToken.isValidAccessToken ?? false,
            title: const Text('Invalid Auth Token'),
            subtitle: Text(
                'Current Auth Token ==> ${AppService.instance.session?.accessToken}'),
            onChanged: (value) {
              _appService.setAccessToken(invalidate: !value);
              setState(() {});
            },
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value:
                _appService.session?.refreshToken.isValidRefreshToken ?? false,
            title: const Text('Invalid Refresh Token'),
            subtitle: Text(
                'Current Refresh Token ==> ${AppService.instance.session?.refreshToken}'),
            onChanged: (value) {
              _appService.setRefreshToken(invalidate: !value);
              setState(() {});
            },
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              getProducts();
              getOrders();
              getOrderDetails();
            },
            child: const Text('Call 3 API at a time'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: getProducts,
            child: const Text('Get Products'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: getProducts,
            child: const Text('Get Orders'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: getOrderDetails,
            child: const Text('Get Order Details'),
          ),
        ],
      ),
    );
  }

  Future<void> getProducts() async {
    await ApiService.instance.getProducts();
    setState(() {});
  }

  Future<void> getOrders() async {
    await ApiService.instance.getOrders();
    setState(() {});
  }

  Future<void> getOrderDetails() async {
    await ApiService.instance.getOrderDetails();
    setState(() {});
  }
}
